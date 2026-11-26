import 'models/pending_answer.dart';

export 'models/pending_answer.dart';

final class QueueCounts {
  const QueueCounts({required this.pending, required this.failed});

  final int pending;
  final int failed;

  bool get isEmpty => pending == 0 && failed == 0;

  @override
  bool operator ==(Object other) {
    return other is QueueCounts &&
        other.pending == pending &&
        other.failed == failed;
  }

  @override
  int get hashCode => Object.hash(pending, failed);

  @override
  String toString() => 'QueueCounts(pending: $pending, failed: $failed)';
}

final class QueueCorruptionReport {
  const QueueCorruptionReport({
    required this.backupKey,
    required this.errorType,
  });

  final String backupKey;
  final String errorType;
}

typedef QueueCorruptionReporter = void Function(QueueCorruptionReport report);

sealed class ChangeQueueException implements Exception {
  const ChangeQueueException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

final class DuplicateQueueEntryException extends ChangeQueueException {
  const DuplicateQueueEntryException(String requestId)
    : super('Queue entry $requestId is already queued.');
}

final class QuizSyncBlockedException extends ChangeQueueException {
  const QuizSyncBlockedException(String quizId)
    : super('Quiz $quizId is blocked by a previous sync error.');
}

abstract interface class ChangeQueue {
  Future<void> enqueue(PendingAnswer entry);

  Future<PendingAnswer?> peekNext();

  Future<void> markSent(String requestId);

  Future<void> markFailed(String quizId, String error);

  Future<int> discardFailed(String quizId);

  Stream<QueueCounts> watch();

  Future<void> dispose();
}
