import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'pending_answer.freezed.dart';
part 'pending_answer.g.dart';

@JsonEnum(valueField: 'jsonValue')
enum PendingAnswerStatus {
  pending('pending'),
  failed('failed');

  const PendingAnswerStatus(this.jsonValue);

  final String jsonValue;
}

@freezed
@JsonSerializable(fieldRename: FieldRename.snake)
class PendingAnswer with _$PendingAnswer {
  PendingAnswer({
    required this.requestId,
    required this.quizId,
    required this.sessionId,
    required this.quizVersion,
    required this.questionId,
    required List<String> selectedAnswers,
    required this.elapsedSeconds,
    this.nextQuestion,
    DateTime? createdAt,
    this.status = PendingAnswerStatus.pending,
    this.lastError,
  }) : selectedAnswers = List<String>.unmodifiable(selectedAnswers),
       createdAt = (createdAt ?? DateTime.now()).toUtc() {
    _validate();
  }

  factory PendingAnswer.create({
    required String quizId,
    required String sessionId,
    required int quizVersion,
    required String questionId,
    required List<String> selectedAnswers,
    required int elapsedSeconds,
    String? nextQuestion,
    String? requestId,
    DateTime? createdAt,
  }) {
    return PendingAnswer(
      requestId: requestId ?? _uuid.v4(),
      quizId: quizId,
      sessionId: sessionId,
      quizVersion: quizVersion,
      questionId: questionId,
      selectedAnswers: selectedAnswers,
      elapsedSeconds: elapsedSeconds.clamp(
        minElapsedSeconds,
        maxElapsedSeconds,
      ),
      nextQuestion: nextQuestion,
      createdAt: createdAt,
    );
  }

  factory PendingAnswer.fromJson(Object? value) {
    if (value is! Map<Object?, Object?>) {
      throw const FormatException('Pending answer must be a JSON object.');
    }

    final json = <String, Object?>{};
    for (final entry in value.entries) {
      if (entry.key is! String) {
        throw const FormatException('Pending answer JSON key must be text.');
      }
      json[entry.key as String] = entry.value;
    }

    const requiredKeys = [
      'request_id',
      'quiz_id',
      'session_id',
      'version',
      'question_id',
      'selected_answers',
      'elapsed_seconds',
      'created_at',
      'status',
    ];
    for (final key in requiredKeys) {
      if (json[key] == null) {
        throw FormatException('Pending answer $key is required.');
      }
    }

    try {
      return _$PendingAnswerFromJson(json);
    } on FormatException {
      rethrow;
    } catch (error) {
      throw FormatException('Invalid pending answer: ${error.runtimeType}.');
    }
  }

  static const int minElapsedSeconds = 0;
  static const int maxElapsedSeconds = 3600;

  static final RegExp _uuidV4 = RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-4[0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$',
    caseSensitive: false,
  );
  static final Uuid _uuid = Uuid();

  @override
  final String requestId;
  @override
  final String quizId;
  @override
  final String sessionId;
  @override
  @JsonKey(name: 'version', fromJson: _readJsonInt)
  final int quizVersion;
  @override
  final String questionId;
  @override
  final List<String> selectedAnswers;
  @override
  @JsonKey(fromJson: _readJsonInt)
  final int elapsedSeconds;
  @override
  final String? nextQuestion;
  @override
  final DateTime createdAt;
  @override
  final PendingAnswerStatus status;
  @override
  final String? lastError;

  static String generateUuidV4() => _uuid.v4();

  Map<String, Object?> toJson() => _$PendingAnswerToJson(this);

  PendingAnswer withStatus(PendingAnswerStatus newStatus, {String? lastError}) {
    return copyWith(status: newStatus, lastError: lastError);
  }

  void _validate() {
    if (!_uuidV4.hasMatch(requestId)) {
      throw const FormatException('Pending answer request_id must be UUID v4.');
    }
    _requireNonEmpty(quizId, 'quiz_id');
    _requireNonEmpty(sessionId, 'session_id');
    _requireNonEmpty(questionId, 'question_id');
    if (quizVersion < 0) {
      throw const FormatException('Pending answer version cannot be negative.');
    }
    if (elapsedSeconds < minElapsedSeconds ||
        elapsedSeconds > maxElapsedSeconds) {
      throw const FormatException('Pending answer elapsed_seconds is invalid.');
    }
    for (final answerId in selectedAnswers) {
      _requireNonEmpty(answerId, 'selected_answers item');
    }
    if (nextQuestion != null && nextQuestion!.isEmpty) {
      throw const FormatException('Pending answer next_question is empty.');
    }
    switch (status) {
      case PendingAnswerStatus.pending:
        if (lastError != null) {
          throw const FormatException(
            'Pending answer cannot have last_error when pending.',
          );
        }
      case PendingAnswerStatus.failed:
        if (lastError == null || lastError!.isEmpty) {
          throw const FormatException(
            'Failed answer must have a non-empty last_error.',
          );
        }
    }
  }

  static void _requireNonEmpty(String value, String field) {
    if (value.isEmpty) {
      throw FormatException('Pending answer $field cannot be empty.');
    }
  }
}

int _readJsonInt(Object? value) {
  if (value is! int) {
    throw const FormatException('Pending answer integer field is invalid.');
  }
  return value;
}
