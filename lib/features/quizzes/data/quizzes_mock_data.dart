// MOCK DATA
class MockRecentQuiz {
  const MockRecentQuiz({
    required this.title,
    required this.subtitle,
    required this.masteredPercent,
    required this.isPrimaryFeatured,
  });

  final String title;
  final String subtitle;
  final int masteredPercent;
  final bool isPrimaryFeatured;
}

// MOCK DATA
class MockFolderItem {
  const MockFolderItem({
    required this.name,
    required this.quizCountLabel,
    required this.detailsMeta,
  });

  final String name;
  final String quizCountLabel;
  final String detailsMeta;
}

// MOCK DATA
class MockQuizRow {
  const MockQuizRow({
    required this.title,
    required this.meta,
    required this.sheetMeta,
    this.progressPercent,
  });

  final String title;
  final String meta;
  final String sheetMeta;
  final int? progressPercent;
}

// MOCK DATA
abstract final class QuizzesMockData {
  // MOCK DATA
  static const List<MockRecentQuiz> recentQuizzes = [
    MockRecentQuiz(
      title: 'Analiza matematyczna – kolokwium 1',
      subtitle: '48 pytań · 2 godz. temu',
      masteredPercent: 62,
      isPrimaryFeatured: true,
    ),
    MockRecentQuiz(
      title: 'Paradygmaty programowania – wykład',
      subtitle: '120 pytań · wczoraj',
      masteredPercent: 24,
      isPrimaryFeatured: false,
    ),
  ];

  // MOCK DATA
  static const List<MockFolderItem> folders = [
    MockFolderItem(
      name: 'Semestr 1',
      quizCountLabel: '6 quizów',
      detailsMeta: '6 quizów · 412 pytań',
    ),
    MockFolderItem(
      name: 'Sesja zimowa',
      quizCountLabel: '4 quizy',
      detailsMeta: '4 quizy · 284 pytania',
    ),
    MockFolderItem(
      name: 'Udostępnione mi',
      quizCountLabel: '2 quizy',
      detailsMeta: '2 quizy · 116 pytań',
    ),
  ];

  // MOCK DATA
  static const List<MockQuizRow> otherQuizzes = [
    MockQuizRow(
      title: 'Fizyka 1 – egzamin',
      meta: '64 pytania · 3 dni temu',
      sheetMeta: '64 pytania · 3 dni temu · 12% opanowane',
    ),
    MockQuizRow(
      title: 'Algebra liniowa – definicje',
      meta: '36 pytań · tydzień temu',
      sheetMeta: '36 pytań · tydzień temu · 80% opanowane',
    ),
    MockQuizRow(
      title: 'Logika i teoria mnogości',
      meta: '52 pytania · 2 tyg. temu',
      sheetMeta: '52 pytania · 2 tyg. temu · 41% opanowane',
    ),
    MockQuizRow(
      title: 'Język angielski B2 – słówka',
      meta: '210 pytań · miesiąc temu',
      sheetMeta: '210 pytań · miesiąc temu · 55% opanowane',
    ),
  ];

  // MOCK DATA
  static const String archiveSubtitle =
      '3 quizy · usunięte znikają po 30 dniach';

  // MOCK DATA
  static const List<MockQuizRow> folderQuizzes = [
    MockQuizRow(
      title: 'Analiza matematyczna – kolokwium 1',
      meta: '48 pytań · 62% opanowane',
      sheetMeta: '48 pytań · 2 godz. temu · 62% opanowane',
      progressPercent: 62,
    ),
    MockQuizRow(
      title: 'Analiza matematyczna – egzamin',
      meta: '96 pytań · 18% opanowane',
      sheetMeta: '96 pytań · 4 dni temu · 18% opanowane',
      progressPercent: 18,
    ),
    MockQuizRow(
      title: 'Algebra liniowa – definicje',
      meta: '36 pytań · 80% opanowane',
      sheetMeta: '36 pytań · tydzień temu · 80% opanowane',
      progressPercent: 80,
    ),
    MockQuizRow(
      title: 'Podstawy programowania – wykład',
      meta: '74 pytań · 100% opanowane',
      sheetMeta: '74 pytań · tydzień temu · 100% opanowane',
      progressPercent: 100,
    ),
    MockQuizRow(
      title: 'Logika i teoria mnogości',
      meta: '52 pytań · 41% opanowane',
      sheetMeta: '52 pytań · 2 tyg. temu · 41% opanowane',
      progressPercent: 41,
    ),
    MockQuizRow(
      title: 'Fizyka 1 – egzamin',
      meta: '106 pytań · 0% opanowane',
      sheetMeta: '106 pytań · 3 tyg. temu · 0% opanowane',
      progressPercent: 0,
    ),
  ];
}
