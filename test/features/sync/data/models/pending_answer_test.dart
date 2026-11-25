import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_testownik/features/sync/data/models/pending_answer.dart';

import '../test_helpers.dart';

void main() {
  test('create clamps elapsedSeconds and JSON round-trips', () {
    final created = PendingAnswer.create(
      quizId: 'quiz-a',
      sessionId: 'session-a',
      quizVersion: 1,
      questionId: 'question-a',
      selectedAnswers: const ['answer-a'],
      elapsedSeconds: 5000,
    );
    expect(created.elapsedSeconds, PendingAnswer.maxElapsedSeconds);
    expect(
      created.requestId,
      matches(
        RegExp(
          r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
          caseSensitive: false,
        ),
      ),
    );

    final failed = buildAnswer().withStatus(
      PendingAnswerStatus.failed,
      lastError: 'HTTP 409',
    );
    expect(PendingAnswer.fromJson(failed.toJson()).toJson(), failed.toJson());
  });

  test('invalid stored data is rejected', () {
    final valid = buildAnswer().toJson();
    final invalid = [
      {...valid, 'version': -1},
      {...valid, 'elapsed_seconds': 3601},
      {...valid, 'request_id': 'not-a-uuid'},
      {...valid, 'created_at': 'not-a-date'},
      {...valid, 'created_at': null},
      {...valid, 'status': 'unknown'},
      {...valid, 'status': null},
      {...valid, 'elapsed_seconds': 1.5},
      {...valid, 'last_error': 'error'},
      {
        ...valid,
        'selected_answers': <Object?>[42],
      },
    ];

    for (final value in invalid) {
      expect(() => PendingAnswer.fromJson(value), throwsFormatException);
    }
  });
}
