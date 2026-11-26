import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_testownik/features/sync/data/change_queue.dart';
import 'package:mobile_testownik/features/sync/data/in_memory_change_queue.dart';
import 'package:mobile_testownik/features/sync/data/src/change_queue_base.dart';

import 'test_helpers.dart';

final class _InMemoryHarness implements QueueTestHarness {
  final Map<String, String> values = <String, String>{};

  @override
  Future<ChangeQueue> create({
    required String userId,
    QueueCorruptionReporter? onCorruptData,
  }) async {
    return InMemoryChangeQueue(
      userId: userId,
      values: values,
      onCorruptData: onCorruptData,
    );
  }

  @override
  Future<void> seedRaw(String userId, String value) async {
    values['queue.$userId'] = value;
  }

  @override
  Future<String?> readRaw(String key) async => values[key];
}

final class _ControlledStorage implements QueueStorage {
  int _active = 0;
  int maxActive = 0;
  Completer<String?>? readCompleter;

  @override
  Future<String?> read(String key) {
    return _run(() => readCompleter?.future ?? Future<String?>.value(null));
  }

  @override
  Future<void> write(String key, String value) => _run(() async {});

  @override
  Future<void> remove(String key) => _run(() async {});

  @override
  Future<bool> containsKey(String key) => _run(() async => false);

  Future<T> _run<T>(Future<T> Function() action) async {
    _active++;
    if (_active > maxActive) maxActive = _active;
    await Future<void>.delayed(Duration.zero);
    try {
      return await action();
    } finally {
      _active--;
    }
  }
}

final class _ControlledQueue extends ChangeQueueBase {
  _ControlledQueue({required super.userId, required super.storage});
}

void main() {
  runChangeQueueContractTests(() => _InMemoryHarness());

  test('only one storage mutation is active at a time', () async {
    final storage = _ControlledStorage();
    final queue = _ControlledQueue(userId: 'user-a', storage: storage);
    addTearDown(queue.dispose);

    await Future.wait([
      for (var index = 1; index <= 20; index++)
        queue.enqueue(buildAnswer(index: index)),
    ]);

    expect(storage.maxActive, 1);
    expect(
      await queue.watch().first,
      const QueueCounts(pending: 20, failed: 0),
    );
  });

  test('watch completes after dispose', () async {
    final queue = InMemoryChangeQueue(userId: 'user-a');
    final initial = Completer<void>();
    final subscription = queue.watch().listen((_) {
      if (!initial.isCompleted) initial.complete();
    });

    await initial.future;
    await queue.dispose();
    await subscription.asFuture<void>();
  });

  test('watch does not emit after dispose during initial read', () async {
    final storage = _ControlledStorage()..readCompleter = Completer<String?>();
    final queue = _ControlledQueue(userId: 'user-a', storage: storage);
    final events = <QueueCounts>[];
    final subscription = queue.watch().listen(events.add);

    await Future<void>.delayed(Duration.zero);
    await queue.dispose();
    storage.readCompleter!.complete(null);

    await subscription.asFuture<void>();
    expect(events, isEmpty);
  });
}
