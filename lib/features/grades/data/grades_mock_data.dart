// MOCK DATA
class MockSubjectGrade {
  const MockSubjectGrade({
    required this.name,
    required this.types,
    required this.ects,
    required this.grade,
  });

  final String name;
  final List<String> types;
  final int ects;
  final double? grade;
}

// MOCK DATA
class MockSemesterGrades {
  const MockSemesterGrades({
    required this.id,
    required this.title,
    required this.period,
    required this.subjects,
  });

  final int id;
  final String title;
  final String period;
  final List<MockSubjectGrade> subjects;
}

// MOCK DATA
abstract final class GradesMockData {
  // MOCK DATA
  static const String syncCaption = 'Z USOS · zaktualizowano dziś, 9:41';

  // MOCK DATA
  static const Set<int> initialSelectedSemesters = {1, 2};

  // MOCK DATA
  static const List<MockSemesterGrades> semesters = [
    MockSemesterGrades(
      id: 1,
      title: 'Semestr 1',
      period: '2025/26 zima',
      subjects: [
        MockSubjectGrade(
          name: 'Analiza matematyczna 1',
          types: ['W', 'C'],
          ects: 7,
          grade: 4.0,
        ),
        MockSubjectGrade(
          name: 'Algebra liniowa z geometrią',
          types: ['W', 'C'],
          ects: 5,
          grade: 4.5,
        ),
        MockSubjectGrade(
          name: 'Podstawy programowania',
          types: ['W', 'L'],
          ects: 6,
          grade: 5.0,
        ),
        MockSubjectGrade(
          name: 'Logika i teoria mnogości',
          types: ['W', 'C'],
          ects: 4,
          grade: 3.5,
        ),
        MockSubjectGrade(
          name: 'Fizyka 1',
          types: ['W'],
          ects: 4,
          grade: 4.0,
        ),
        MockSubjectGrade(
          name: 'Język angielski B2',
          types: ['C'],
          ects: 2,
          grade: 5.0,
        ),
      ],
    ),
    MockSemesterGrades(
      id: 2,
      title: 'Semestr 2',
      period: '2025/26 lato',
      subjects: [
        MockSubjectGrade(
          name: 'Analiza matematyczna 2',
          types: ['W', 'C'],
          ects: 7,
          grade: 4.5,
        ),
        MockSubjectGrade(
          name: 'Paradygmaty programowania',
          types: ['W', 'L'],
          ects: 5,
          grade: 5.0,
        ),
        MockSubjectGrade(
          name: 'Matematyka dyskretna',
          types: ['W', 'C'],
          ects: 5,
          grade: 3.0,
        ),
        MockSubjectGrade(
          name: 'Algorytmy i struktury danych',
          types: ['W', 'L'],
          ects: 6,
          grade: 4.5,
        ),
        MockSubjectGrade(
          name: 'Wstęp do sztucznej inteligencji',
          types: ['W', 'P'],
          ects: 4,
          grade: 5.5,
        ),
        MockSubjectGrade(
          name: 'Probabilistyka',
          types: ['W', 'C'],
          ects: 3,
          grade: null,
        ),
      ],
    ),
    MockSemesterGrades(
      id: 3,
      title: 'Semestr 3',
      period: '2026/27 zima',
      subjects: [
        MockSubjectGrade(
          name: 'Uczenie maszynowe',
          types: ['W', 'L'],
          ects: 6,
          grade: null,
        ),
        MockSubjectGrade(
          name: 'Bazy danych',
          types: ['W', 'L'],
          ects: 5,
          grade: null,
        ),
        MockSubjectGrade(
          name: 'Statystyka',
          types: ['W', 'C'],
          ects: 5,
          grade: 4.0,
        ),
        MockSubjectGrade(
          name: 'Systemy operacyjne',
          types: ['W', 'L'],
          ects: 5,
          grade: null,
        ),
      ],
    ),
  ];
}
