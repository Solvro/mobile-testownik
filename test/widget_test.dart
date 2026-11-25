import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mobile_testownik/app/app.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('Renders all 9 demo screens and overlays without overflow', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TestownikApp());
    await tester.pumpAndSettle();

    expect(find.text('Testownik'), findsOneWidget);
    expect(find.text('Twoje narzędzie do nauki na PWr'), findsOneWidget);

    await tester.tap(find.text('Zaloguj się'));
    await tester.pumpAndSettle();
    expect(find.text('Ostatnio uczone'), findsOneWidget);

    await tester.tap(find.text('Semestr 1'));
    await tester.pumpAndSettle();
    expect(find.text('Szukaj w folderze'), findsOneWidget);

    await tester.tap(find.text('Quizy').first);
    await tester.pumpAndSettle();
    expect(find.text('Ostatnio uczone'), findsOneWidget);

    await tester.ensureVisible(find.text('Fizyka 1 – egzamin'));
    await tester.tap(find.text('Fizyka 1 – egzamin'));
    await tester.pumpAndSettle();
    expect(find.text('Jak chcesz się uczyć?'), findsOneWidget);

    await tester.tap(find.text('Ucz się fiszkami'));
    await tester.pumpAndSettle();
    expect(find.text('Tryb fiszek'), findsOneWidget);
    expect(find.text('Pytanie'), findsOneWidget);

    await tester.tap(find.text('Dotknij, aby odwrócić'));
    await tester.pumpAndSettle();
    expect(find.text('Odpowiedź'), findsOneWidget);

    await tester.tap(find.text('Zapytaj AI o tę kartę'));
    await tester.pumpAndSettle();
    expect(find.text('Asystent AI'), findsOneWidget);

    await tester.tap(find.byIcon(LucideIcons.x).last);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(LucideIcons.x));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Kontynuuj').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kontynuuj').first);
    await tester.pumpAndSettle();
    expect(find.text('Połączono na żywo'), findsOneWidget);

    await tester.tap(find.text('f(x) = |x|'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sprawdź odpowiedź'));
    await tester.pumpAndSettle();
    expect(find.text('Poprawna odpowiedź!'), findsOneWidget);

    await tester.tap(find.text('Zapytaj AI'));
    await tester.pumpAndSettle();
    expect(find.text('Asystent AI'), findsOneWidget);
    await tester.tap(find.byIcon(LucideIcons.x).last);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(LucideIcons.x));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Oceny'));
    await tester.pumpAndSettle();
    expect(find.text('Średnia ważona'), findsOneWidget);

    await tester.tap(find.text('Konto'));
    await tester.pumpAndSettle();
    expect(find.text('Jan Kowalski'), findsOneWidget);

    await tester.ensureVisible(find.text('Wyloguj się'));
    await tester.tap(find.text('Wyloguj się'));
    await tester.pumpAndSettle();
    expect(find.text('Zaloguj się'), findsOneWidget);
  });
}
