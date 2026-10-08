import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/theme/game_theme_id.dart';
import 'package:math_strike/features/authentication/domain/entities/account_link.dart';
import 'package:math_strike/features/authentication/presentation/controllers/account_controller.dart';
import 'package:math_strike/features/profile/domain/entities/age_group.dart';
import 'package:math_strike/features/profile/domain/entities/difficulty.dart';
import 'package:math_strike/features/profile/domain/entities/player_profile.dart';
import 'package:math_strike/features/profile/presentation/controllers/onboarding_controller.dart';
import 'package:math_strike/features/profile/presentation/controllers/profile_controller.dart';
import 'package:math_strike/features/settings/presentation/controllers/appearance_controller.dart';
import 'package:math_strike/features/settings/presentation/controllers/audio_settings_controller.dart';
import 'package:math_strike/routing/app_routes.dart';

import '../../helpers/test_app.dart';

void main() {
  group('PlayerProfile.validateName', () {
    test('accepts names in any script, with spaces and hyphens', () {
      for (final name in ['Ava', 'Mary-Jane', "D'Angelo", 'Zoë', 'José 2']) {
        expect(PlayerProfile.validateName(name), isNull, reason: name);
      }
    });

    test('rejects empty, too long and symbol names', () {
      expect(PlayerProfile.validateName('   '), isNotNull);
      expect(PlayerProfile.validateName('A' * 17), isNotNull);
      expect(PlayerProfile.validateName('<script>'), isNotNull);
    });

    test('normalizes whitespace', () {
      expect(PlayerProfile.normalizeName('  Ada   Love '), 'Ada Love');
    });
  });

  group('OnboardingController', () {
    late ProviderContainer container;

    setUp(() async {
      final db = InMemoryLocalDatabase();
      await linkTestAccount(db, stage: AccountSetupStage.onboarding);
      container = createTestContainer(database: db);
      container.listen(onboardingControllerProvider, (_, _) {});
    });

    OnboardingController controller() =>
        container.read(onboardingControllerProvider.notifier);
    OnboardingState state() => container.read(onboardingControllerProvider);

    test('suggests the first name of the Google account', () {
      expect(state().name, 'Test'); // from "Test Player"
    });

    test('picking an age suggests its difficulty until one is chosen', () {
      controller().setAgeGroup(AgeGroup.teen);
      expect(state().difficulty, Difficulty.hard);

      controller()
        ..setDifficulty(Difficulty.easy)
        ..setAgeGroup(AgeGroup.adult);
      expect(state().difficulty, Difficulty.easy);
    });

    test('cannot leave the name or age step while incomplete', () {
      controller()
        ..setName('')
        ..next();
      expect(state().step, OnboardingStep.name);

      controller()
        ..setName('Ada')
        ..next()
        ..next(); // avatar → age
      expect(state().step, OnboardingStep.age);
      controller().next();
      expect(state().step, OnboardingStep.age, reason: 'no age group yet');
    });

    test('complete saves profile and audio and finishes setup', () async {
      controller()
        ..setName('  Ada  ')
        ..setAvatar('luna')
        ..setAgeGroup(AgeGroup.earlyPrimary)
        ..setMusic(enabled: false);

      await controller().complete();

      final profile = container.read(profileControllerProvider)!;
      expect(profile.name, 'Ada');
      expect(profile.avatarId, 'luna');
      expect(profile.ageGroup, AgeGroup.earlyPrimary);
      expect(profile.difficulty, Difficulty.easy);
      expect(
        container.read(audioSettingsControllerProvider).musicEnabled,
        false,
      );
      expect(
        container.read(accountControllerProvider)!.stage,
        AccountSetupStage.complete,
      );
    });
  });

  group('Onboarding screen', () {
    Future<void> pumpOnboarding(
      WidgetTester tester, {
      Size size = const Size(400, 800),
    }) async {
      final db = InMemoryLocalDatabase();
      await linkTestAccount(db, stage: AccountSetupStage.onboarding);
      await tester.pumpMathStrikeAppAtSplash(database: db, size: size);
      await tester.pumpAndSettle();
      expect(tester.currentLocation, AppRoutes.onboarding);
    }

    testWidgets('full wizard creates the profile and opens the app', (
      tester,
    ) async {
      await pumpOnboarding(tester);

      await tester.completeOnboarding(name: 'Ada');

      expect(tester.currentLocation, AppRoutes.home);
      expect(tester.appContainer.read(profileControllerProvider)!.name, 'Ada');
    });

    testWidgets('theme choices apply live', (tester) async {
      await pumpOnboarding(tester);
      final controller = tester.appContainer.read(
        onboardingControllerProvider.notifier,
      );
      controller
        ..next()
        ..next()
        ..setAgeGroup(AgeGroup.adult)
        ..next()
        ..next();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Forest'));
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      final appearance = tester.appContainer.read(appearanceControllerProvider);
      expect(appearance.gameTheme, GameThemeId.forest);
      final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(app.themeMode, ThemeMode.dark);
    });

    testWidgets('back button returns to the previous step, never leaves', (
      tester,
    ) async {
      await pumpOnboarding(tester);
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(find.text('Pick your Striker'), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      expect(find.text('What should we call you?'), findsOneWidget);

      // System back on the first step does nothing.
      final handled = await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
      expect(handled, isTrue);
      expect(tester.currentLocation, AppRoutes.onboarding);
    });

    testWidgets('the name field is focused on arrival', (tester) async {
      await pumpOnboarding(tester);

      final field = tester.widget<EditableText>(find.byType(EditableText));
      expect(field.focusNode.hasFocus, isTrue);
    });

    testWidgets('Enter advances without skipping steps', (tester) async {
      await pumpOnboarding(tester);

      // On the name step the text field submits (once).
      await tester.testTextInput.receiveAction(TextInputAction.next);
      await tester.pumpAndSettle();
      expect(find.text('Pick your Striker'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.enter);
      await tester.pumpAndSettle();
      expect(find.text('How old are you?'), findsOneWidget);
    });

    testWidgets('wide screens show a live preview card', (tester) async {
      await pumpOnboarding(tester, size: const Size(1280, 800));

      expect(find.text('Preview'), findsOneWidget);
      await tester.enterText(find.byType(TextField), 'Ada');
      await tester.pump();
      expect(find.text('Ada'), findsWidgets);
    });
  });
}
