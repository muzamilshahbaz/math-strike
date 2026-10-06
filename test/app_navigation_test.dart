import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/core/widgets/brand/math_strike_wordmark.dart';

import 'helpers/test_app.dart';

void main() {
  group('Adaptive shell', () {
    testWidgets('phones use a bottom NavigationBar', (tester) async {
      await tester.pumpMathStrikeApp(size: const Size(400, 800));

      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.byType(NavigationRail), findsNothing);
    });

    testWidgets('tablets use a collapsed NavigationRail', (tester) async {
      await tester.pumpMathStrikeApp(size: const Size(900, 1000));

      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.extended, isFalse);
      expect(find.byType(NavigationBar), findsNothing);
    });

    testWidgets('desktops use an extended sidebar with branding', (
      tester,
    ) async {
      await tester.pumpMathStrikeApp(size: const Size(1440, 900));

      final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
      expect(rail.extended, isTrue);
      expect(find.byType(MathStrikeWordmark), findsOneWidget);
    });
  });

  group('Navigation', () {
    testWidgets('tapping a destination switches tabs', (tester) async {
      await tester.pumpMathStrikeApp();

      await tester.tap(find.text('Settings').last);
      await tester.pumpAndSettle();

      expect(find.text('Appearance'), findsOneWidget);
    });

    testWidgets('Alt+number switches tabs from the keyboard', (tester) async {
      await tester.pumpMathStrikeApp(size: const Size(1440, 900));

      await tester.sendKeyDownEvent(LogicalKeyboardKey.altLeft);
      await tester.sendKeyEvent(LogicalKeyboardKey.digit4);
      await tester.sendKeyUpEvent(LogicalKeyboardKey.altLeft);
      await tester.pumpAndSettle();

      expect(find.text('Arrives in Phase 10'), findsOneWidget); // Shop
    });

    testWidgets('Quick play opens gameplay full-screen', (tester) async {
      await tester.pumpMathStrikeApp();

      await tester.tap(find.text('Quick play'));
      await tester.pumpAndSettle();

      expect(find.text('Arrives in Phase 7'), findsOneWidget);
      expect(find.byType(NavigationBar), findsNothing);
      expect(find.byType(BackButton), findsOneWidget);
    });
  });

  testWidgets('choosing Dark in settings updates the theme and persists it', (
    tester,
  ) async {
    final database = InMemoryLocalDatabase();
    await tester.pumpMathStrikeApp(database: database);

    await tester.tap(find.text('Settings').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
    expect(
      database
          .store(StorageBox.settings)
          .readJson(SettingsKeys.appearance)?['themeMode'],
      'dark',
    );
  });
}
