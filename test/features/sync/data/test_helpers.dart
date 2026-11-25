import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_testownik/features/sync/data/change_queue.dart';

abstract interface class QueueTestHarness {
  Future<ChangeQueue> create({
    required String userId,
    QueueCorruptionReporter? onCorruptData,
  });

  Future<void> seedRaw(String userId, String value);

  Future<String?> readRaw(String key);
}

String answerRequestId(int index) {
  return '00000000-0000-4000-8000-${index.toString().padLeft(12, '0')}';
}

PendingAnswer buildAnswer({
  int index = 1,
  String quizId = 'quiz-a',
  int elapsedSeconds = 42,
}) {
  return PendingAnswer(
    requestId: answerRequestId(index),
    quizId: quizId,
    sessionId: 'session-$quizId',
    quizVersion: 3,
    questionId: 'question-$index',
    selectedAnswers: const ['answer-1'],
    elapsedSeconds: elapsedSeconds,
    createdAt: DateTime.utc(2026, 11, 25, 12),
  );
}

void runChangeQueueContractTests(QueueTestHarness Function() createHarness) {
  late QueueTestHarness harness;

  setUp(() {
    harness = createHarness();
  });

  test('queue operations', () async {
    final queue = await harness.create(userId: 'user-a');
    addTearDown(queue.dispose);

    await queue.enqueue(buildAnswer(index: 1));
    await queue.enqueue(buildAnswer(index: 2));
    await queue.enqueue(buildAnswer(index: 3, quizId: 'quiz-b'));

    expect((await queue.peekNext())!.requestId, answerRequestId(1));
    expect(await queue.watch().first, const QueueCounts(pending: 3, failed: 0));

    await queue.markSent(answerRequestId(1));
    await queue.markSent(answerRequestId(1));
    await queue.markFailed('quiz-a', 'HTTP 409');

    expect((await queue.peekNext())!.quizId, 'quiz-b');
    expect(await queue.watch().first, const QueueCounts(pending: 1, failed: 1));
    await expectLater(
      queue.enqueue(buildAnswer(index: 4)),
      throwsA(isA<QuizSyncBlockedException>()),
    );

    expect(await queue.discardFailed('quiz-a'), 1);
    await queue.enqueue(buildAnswer(index: 5));
    await expectLater(
      queue.enqueue(buildAnswer(index: 5)),
      throwsA(isA<DuplicateQueueEntryException>()),
    );
    expect(await queue.watch().first, const QueueCounts(pending: 2, failed: 0));
  });

  test('restart, account isolation and concurrent enqueue', () async {
    final userA = await harness.create(userId: 'user-a');
    await Future.wait([
      for (var index = 1; index <= 30; index++)
        userA.enqueue(buildAnswer(index: index)),
    ]);
    await userA.dispose();

    final restarted = await harness.create(userId: 'user-a');
    final userB = await harness.create(userId: 'user-b');
    addTearDown(restarted.dispose);
    addTearDown(userB.dispose);

    expect(
      await restarted.watch().first,
      const QueueCounts(pending: 30, failed: 0),
    );
    expect(await userB.peekNext(), isNull);

    await expectLater(
      Future.wait([
        restarted.enqueue(buildAnswer(index: 31)),
        restarted.enqueue(buildAnswer(index: 31)),
      ]),
      throwsA(isA<DuplicateQueueEntryException>()),
    );
    expect(
      await restarted.watch().first,
      const QueueCounts(pending: 31, failed: 0),
    );
  });

  test('broken stored JSON is backed up and reported', () async {
    final reports = <QueueCorruptionReport>[];
    await harness.seedRaw('user-a', '{not json');

    final queue = await harness.create(
      userId: 'user-a',
      onCorruptData: reports.add,
    );
    addTearDown(queue.dispose);

    expect(await queue.peekNext(), isNull);
    expect(await harness.readRaw('queue.user-a.corrupt'), '{not json');
    expect(await harness.readRaw('queue.user-a'), isNull);
    expect(reports, hasLength(1));

    await queue.enqueue(buildAnswer(index: 1));
    expect((await queue.peekNext())!.requestId, answerRequestId(1));
  });
}
