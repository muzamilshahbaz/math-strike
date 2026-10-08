@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/features/authentication/domain/entities/account_link.dart';
import 'package:math_strike/features/profile/domain/entities/age_group.dart';
import 'package:math_strike/features/profile/presentation/controllers/onboarding_controller.dart';

import '../helpers/golden_fonts.dart';
import '../helpers/test_app.dart';

void main() {
  setUpAll(loadGoldenFonts);

  Future<OnboardingController> pumpOnboarding(
    WidgetTester tester,
    Size size,
  ) async {
    final db = InMemoryLocalDatabase();
    await linkTestAccount(db, stage: AccountSetupStage.onboarding);
    await tester.pumpMathStrikeAppAtSplash(database: db, size: size);
    await tester.pumpAndSettle();
    return tester.appContainer.read(onboardingControllerProvider.notifier);
  }

  Future<void> snapshot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/$name.png'),
    );
  }

  const phone = Size(400, 860);

  testWidgets('name step', (tester) async {
    await pumpOnboarding(tester, phone);
    await snapshot(tester, 'onboarding_name_phone');
  });

  testWidgets('avatar step', (tester) async {
    (await pumpOnboarding(tester, phone))
      ..next()
      ..setAvatar('whiskers');
    await snapshot(tester, 'onboarding_avatar_phone');
  });

  testWidgets('age step', (tester) async {
    (await pumpOnboarding(tester, phone))
      ..next()
      ..next()
      ..setAgeGroup(AgeGroup.latePrimary);
    await snapshot(tester, 'onboarding_age_phone');
  });

  testWidgets('difficulty step', (tester) async {
    (await pumpOnboarding(tester, phone))
      ..next()
      ..next()
      ..setAgeGroup(AgeGroup.latePrimary)
      ..next();
    await snapshot(tester, 'onboarding_difficulty_phone');
  });

  testWidgets('summary', (tester) async {
    (await pumpOnboarding(tester, phone))
      ..setName('Ada')
      ..setAvatar('nova')
      ..next()
      ..next()
      ..setAgeGroup(AgeGroup.earlyPrimary)
      ..next()
      ..next()
      ..next()
      ..next();
    await snapshot(tester, 'onboarding_summary_phone');
  });

  testWidgets('desktop with live preview', (tester) async {
    (await pumpOnboarding(tester, const Size(1280, 800)))
      ..setName('Ada')
      ..setAvatar('rex')
      ..next()
      ..next()
      ..setAgeGroup(AgeGroup.teen);
    await snapshot(tester, 'onboarding_age_desktop');
  });
}
