import 'dart:async';
import 'dart:convert';

import '../change_queue.dart';

abstract interface class QueueStorage {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<void> remove(String key);

  Future<bool> containsKey(String key);
}

final class _QueueState {
  _QueueState({List<PendingAnswer>? entries, Map<String, String>? errors})
    : entries = entries ?? <PendingAnswer>[],
      errors = errors ?? <String, String>{};

  final List<PendingAnswer> entries;
  final Map<String, String> errors;

  _QueueState copy() {
    return _QueueState(
      entries: List<PendingAnswer>.of(entries),
      errors: Map<String, String>.of(errors),
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'schemaVersion': 1,
      'entries': entries.map((entry) => entry.toJson()).toList(),
      'errors': Map<String, String>.of(errors),
    };
  }

  static _QueueState fromJson(Object? value) {
    if (value is! Map<Object?, Object?>) {
      throw const FormatException('Change queue state must be a JSON object.');
    }
    if (value['schemaVersion'] != 1) {
      throw const FormatException('Unsupported change queue schema version.');
    }

    final rawEntries = value['entries'];
    if (rawEntries is! List<Object?>) {
      throw const FormatException('Change queue entries must be a list.');
    }

    final rawErrors = value['errors'];
    if (rawErrors is! Map<Object?, Object?>) {
      throw const FormatException('Change queue errors must be an object.');
    }

    final errors = <String, String>{};
    for (final MapEntry<Object?, Object?> entry in rawErrors.entries) {
      if (entry.key is! String || (entry.key as String).isEmpty) {
        throw const FormatException('Change queue error quiz id is invalid.');
      }
      if (entry.value is! String || (entry.value as String).isEmpty) {
        throw const FormatException('Change queue error text is invalid.');
      }
      errors[entry.key as String] = entry.value as String;
    }

    final state = _QueueState(
      entries: [
        for (final rawEntry in rawEntries) PendingAnswer.fromJson(rawEntry),
      ],
      errors: errors,
    );
    validateState(state);
    return state;
  }

  static void validateState(_QueueState state) {
    final requestIds = <String>{};
    for (final entry in state.entries) {
      if (!requestIds.add(entry.requestId)) {
        throw const FormatException('Duplicate request_id in change queue.');
      }
      final quizError = state.errors[entry.quizId];
      switch (entry.status) {
        case PendingAnswerStatus.pending:
          if (quizError != null) {
            throw const FormatException(
              'Pending entry belongs to a blocked quiz.',
            );
          }
        case PendingAnswerStatus.failed:
          if (quizError == null) {
            throw const FormatException('Failed entry has no quiz error.');
          }
          if (entry.lastError != quizError) {
            throw const FormatException(
              'Failed entry error differs from quiz error.',
            );
          }
      }
    }
  }
}

final class _QueueUpdate {
  const _QueueUpdate(this.counts, this.revision);

  final QueueCounts counts;
  final int revision;
}

base class ChangeQueueBase implements ChangeQueue {
  ChangeQueueBase({
    required String userId,
    required QueueStorage storage,
    QueueCorruptionReporter? onCorruptData,
  }) : _userId = userId,
       _storage = storage,
       _onCorruptData = onCorruptData,
       _mainKey = 'queue.$userId' {
    if (userId.isEmpty) {
      throw ArgumentError.value(userId, 'userId', 'Owner id cannot be empty.');
    }
    _ready = _initialize();
  }

  final String _userId;
  final QueueStorage _storage;
  final QueueCorruptionReporter? _onCorruptData;
  final String _mainKey;

  late final Future<void> _ready;
  Future<void> _tail = Future<void>.value();
  _QueueState _state = _QueueState();
  Object? _loadError;
  bool _disposed = false;
  var _revision = 0;
  final StreamController<_QueueUpdate> _updates =
      StreamController<_QueueUpdate>.broadcast();

  @override
  Future<void> enqueue(PendingAnswer entry) {
    _assertOpen();
    return _mutate((state) {
      if (state.errors.containsKey(entry.quizId)) {
        throw QuizSyncBlockedException(entry.quizId);
      }
      if (state.entries.any((item) => item.requestId == entry.requestId)) {
        throw DuplicateQueueEntryException(entry.requestId);
      }
      state.entries.add(entry);
    });
  }

  @override
  Future<PendingAnswer?> peekNext() {
    _assertOpen();
    return _serialize(() async {
      final state = await _readForOperation();
      for (final entry in state.entries) {
        if (entry.status == PendingAnswerStatus.pending &&
            !state.errors.containsKey(entry.quizId)) {
          return entry;
        }
      }
      return null;
    });
  }

  @override
  Future<void> markSent(String requestId) {
    _assertOpen();
    if (requestId.isEmpty) {
      throw ArgumentError.value(requestId, 'requestId', 'Cannot be empty.');
    }
    return _mutate((state) {
      state.entries.removeWhere((entry) => entry.requestId == requestId);
    });
  }

  @override
  Future<void> markFailed(String quizId, String error) {
    _assertOpen();
    if (quizId.isEmpty) {
      throw ArgumentError.value(quizId, 'quizId', 'Cannot be empty.');
    }
    if (error.isEmpty) {
      throw ArgumentError.value(error, 'error', 'Cannot be empty.');
    }
    return _mutate((state) {
      state.errors[quizId] = error;
      for (var index = 0; index < state.entries.length; index++) {
        final entry = state.entries[index];
        if (entry.quizId == quizId) {
          state.entries[index] = entry.withStatus(
            PendingAnswerStatus.failed,
            lastError: error,
          );
        }
      }
    });
  }

  @override
  Future<int> discardFailed(String quizId) {
    _assertOpen();
    if (quizId.isEmpty) {
      throw ArgumentError.value(quizId, 'quizId', 'Cannot be empty.');
    }
    return _mutate((state) {
      final before = state.entries.length;
      state.entries.removeWhere(
        (entry) =>
            entry.quizId == quizId &&
            entry.status == PendingAnswerStatus.failed,
      );
      state.errors.remove(quizId);
      return before - state.entries.length;
    });
  }

  @override
  Stream<QueueCounts> watch() async* {
    _assertOpen();

    final localController = StreamController<QueueCounts>();
    var cutoff = _revision;
    final subscription = _updates.stream.listen(
      (update) {
        if (update.revision > cutoff) {
          localController.add(update.counts);
        }
      },
      onDone: () {
        if (!localController.isClosed) localController.close();
      },
    );

    try {
      final state = await _readForOperation();
      if (localController.isClosed) return;
      cutoff = _revision;
      localController.add(_counts(state));
      yield* localController.stream;
    } finally {
      await subscription.cancel();
      if (!localController.isClosed) await localController.close();
    }
  }

  @override
  Future<void> dispose() async {
    if (_disposed) return;
    _disposed = true;
    await _updates.close();
  }

  Future<void> _initialize() async {
    try {
      final raw = await _storage.read(_mainKey);
      if (raw == null) {
        _state = _QueueState();
        return;
      }

      try {
        _state = _QueueState.fromJson(jsonDecode(raw));
      } catch (error) {
        await _preserveCorruptValue(raw, error);
        _state = _QueueState();
      }
    } catch (error, stackTrace) {
      _state = _QueueState();
      _loadError = error;
      _loadErrorStackTrace = stackTrace;
    }
  }

  StackTrace? _loadErrorStackTrace;

  Future<void> _preserveCorruptValue(String raw, Object error) async {
    var suffix = 0;
    late final String backupKey;
    while (true) {
      final candidate = suffix == 0
          ? '$_mainKey.corrupt'
          : '$_mainKey.corrupt.$suffix';
      if (!await _storage.containsKey(candidate)) {
        backupKey = candidate;
        break;
      }
      suffix++;
    }

    await _storage.write(backupKey, raw);
    await _storage.remove(_mainKey);

    final reporter = _onCorruptData;
    if (reporter != null) {
      try {
        reporter(
          QueueCorruptionReport(
            backupKey: backupKey,
            errorType: error.runtimeType.toString(),
          ),
        );
      } catch (_) {}
    }
  }

  Future<T> _serialize<T>(Future<T> Function() action) {
    final result = _tail.then((_) => action());
    _tail = result.then((_) {}, onError: (_, _) {});
    return result;
  }

  Future<_QueueState> _readForOperation() async {
    await _ready;
    final error = _loadError;
    if (error != null) {
      final stackTrace = _loadErrorStackTrace;
      if (stackTrace == null) {
        throw error;
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
    return _state.copy();
  }

  Future<T> _mutate<T>(T Function(_QueueState state) mutation) {
    return _serialize(() async {
      final next = await _readForOperation();
      final result = mutation(next);
      _QueueState.validateState(next);
      await _storage.write(_mainKey, jsonEncode(next.toJson()));
      _state = next;
      _publish(next);
      return result;
    });
  }

  void _publish(_QueueState state) {
    _revision++;
    if (!_updates.isClosed) {
      _updates.add(_QueueUpdate(_counts(state), _revision));
    }
  }

  QueueCounts _counts(_QueueState state) {
    var pending = 0;
    var failed = 0;
    for (final entry in state.entries) {
      switch (entry.status) {
        case PendingAnswerStatus.pending:
          pending++;
        case PendingAnswerStatus.failed:
          failed++;
      }
    }
    return QueueCounts(pending: pending, failed: failed);
  }

  void _assertOpen() {
    if (_disposed) {
      throw StateError('Change queue is disposed. User id: $_userId');
    }
  }
}
