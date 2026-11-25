// MOCK DATA
abstract final class AuthMockData {
  // MOCK DATA
  static const String previewQuestionCounter = 'Pytanie 12 z 48';
  // MOCK DATA
  static const String previewQuestionText =
      'Która funkcja jest ciągła na całym ℝ?';
  // MOCK DATA
  static const List<({String text, bool isCorrect})> previewAnswers = [
    (text: 'f(x) = 1/x', isCorrect: false),
    (text: 'f(x) = |x|', isCorrect: true),
    (text: 'f(x) = ⌊x⌋', isCorrect: false),
  ];
}
