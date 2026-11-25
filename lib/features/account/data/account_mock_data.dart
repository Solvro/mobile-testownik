// MOCK DATA
class MockAccountToggle {
  const MockAccountToggle({
    required this.key,
    required this.label,
    required this.description,
    required this.initialValue,
  });

  final String key;
  final String label;
  final String description;
  final bool initialValue;
}

// MOCK DATA
abstract final class AccountMockData {
  // MOCK DATA
  static const String initials = 'JK';
  // MOCK DATA
  static const String fullName = 'Jan Kowalski';
  // MOCK DATA
  static const String email = '272345@student.pwr.edu.pl';
  // MOCK DATA
  static const String roleBadge = 'Student';

  // MOCK DATA
  static const List<MockAccountToggle> learningToggles = [
    MockAccountToggle(
      key: 'shuffle',
      label: 'Losowa kolejność pytań',
      description: 'Pytania i odpowiedzi w innej kolejności za każdym razem',
      initialValue: true,
    ),
    MockAccountToggle(
      key: 'repeat',
      label: 'Powtarzaj błędne odpowiedzi',
      description: 'Pytanie wraca, dopóki nie odpowiesz poprawnie',
      initialValue: true,
    ),
    MockAccountToggle(
      key: 'remind',
      label: 'Przypomnienia o nauce',
      description: 'Codzienne powiadomienie wieczorem',
      initialValue: false,
    ),
  ];

  // MOCK DATA
  static const String currentThemeLabel = 'Systemowy';
  // MOCK DATA
  static const String currentLanguageLabel = 'Polski';
  // MOCK DATA
  static const String appVersionLabel = '[WERSJA]';
}
