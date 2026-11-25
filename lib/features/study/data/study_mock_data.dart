// MOCK DATA
class MockQuizAnswer {
  const MockQuizAnswer({
    required this.id,
    required this.letter,
    required this.text,
  });

  final String id;
  final String letter;
  final String text;
}

// MOCK DATA
class MockFlashcardItem {
  const MockFlashcardItem({
    required this.question,
    required this.answer,
    required this.note,
  });

  final String question;
  final String answer;
  final String note;
}

// MOCK DATA
abstract final class StudyMockData {
  // MOCK DATA
  static const String defaultQuizTitle = 'Analiza matematyczna – kolokwium 1';
  // MOCK DATA
  static const String questionProgressLabel = 'Pytanie 12 z 48';
  // MOCK DATA
  static const String masteredLabel = '18 opanowanych';
  // MOCK DATA
  static const double quizProgress = 0.25;
  // MOCK DATA
  static const String questionText =
      'Która z poniższych funkcji jest ciągła w każdym punkcie zbioru liczb rzeczywistych?';
  // MOCK DATA
  static const String correctAnswerId = 'b';
  // MOCK DATA
  static const List<MockQuizAnswer> answers = [
    MockQuizAnswer(id: 'a', letter: 'A', text: 'f(x) = 1/x'),
    MockQuizAnswer(id: 'b', letter: 'B', text: 'f(x) = |x|'),
    MockQuizAnswer(id: 'c', letter: 'C', text: 'f(x) = ⌊x⌋ (część całkowita)'),
    MockQuizAnswer(id: 'd', letter: 'D', text: 'f(x) = sgn(x)'),
  ];
  // MOCK DATA
  static const String correctVerdictSub =
      '|x| nie ma skoków – w zerze obie granice wynoszą 0 = f(0).';
  // MOCK DATA
  static const String wrongVerdictSub = 'Poprawna jest odpowiedź B: f(x) = |x|.';
  // MOCK DATA
  static const String followUpPromptLabel = 'Dlaczego nie ⌊x⌋?';

  // MOCK DATA
  static const String aiSubtitle = 'Zna treść pytania 12 i Twoją odpowiedź';
  // MOCK DATA
  static const String aiContextLabel = 'Pytanie 12 · Twoja odpowiedź: C';
  // MOCK DATA
  static const String aiUserMessage = 'Dlaczego ⌊x⌋ nie jest ciągła?';
  // MOCK DATA
  static const List<String> aiReplyParagraphs = [
    'Część całkowita ⌊x⌋ „skacze” w każdej liczbie całkowitej.',
    'Np. przy x → 1⁻ wartości są równe 0, a f(1) = 1. Granica lewostronna różni się od wartości funkcji, więc w x = 1 nie ma ciągłości.',
    'Funkcja |x| nie ma skoków – w zerze obie granice jednostronne wynoszą 0 = f(0).',
  ];
  // MOCK DATA
  static const List<String> aiSuggestions = [
    'Podaj podobny przykład',
    'Wyjaśnij prościej',
    'A sgn(x)?',
  ];

  // MOCK DATA
  static const String defaultFlashcardsTitle = 'Fizyka 1 – egzamin';
  // MOCK DATA
  static const int flashcardsTotal = 64;
  // MOCK DATA
  static const int initialKnownCount = 7;
  // MOCK DATA
  static const int initialAgainCount = 2;
  // MOCK DATA
  static const List<MockFlashcardItem> flashcards = [
    MockFlashcardItem(
      question: 'Co mówi I zasada dynamiki Newtona?',
      answer: 'Bez wypadkowej siły ciało nie zmienia prędkości',
      note:
          'Pozostaje w spoczynku lub porusza się ruchem jednostajnym prostoliniowym.',
    ),
    MockFlashcardItem(
      question: 'Jednostka indukcji magnetycznej w układzie SI?',
      answer: 'Tesla (T)',
      note: '1 T = 1 kg / (A · s²)',
    ),
    MockFlashcardItem(
      question: 'Wzór na energię kinetyczną',
      answer: 'Eₖ = ½ · m · v²',
      note: 'm – masa, v – prędkość',
    ),
  ];
}
