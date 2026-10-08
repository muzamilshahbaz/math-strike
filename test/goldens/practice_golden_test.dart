@Tags(['golden'])
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/features/math/domain/entities/math_topic.dart';
import 'package:math_strike/features/math/math_providers.dart';
import 'package:math_strike/features/math/presentation/controllers/practice_session_controller.dart';
import 'package:math_strike/routing/app_router.dart';
import 'package:math_strike/routing/app_routes.dart';

import '../helpers/fake_clock.dart';
import '../helpers/golden_fonts.dart';
import '../helpers/test_app.dart';

void main() {
  setUpAll(loadGoldenFonts);

  const phone = Size(400, 900);

  Future<void> pump(WidgetTester tester, {Size size = phone}) =>
      tester.pumpMathStrikeApp(
        database: InMemoryLocalDatabase(),
        size: size,
        overrides: [
          FakeClock(DateTime(2026, 10, 9, 16)).override,
          mathRandomProvider.overrideWithValue(math.Random(21)),
        ],
      );

  Future<void> open(WidgetTester tester, String location) async {
    tester.appContainer.read(appRouterProvider).push<void>(location).ignore();
    await tester.pumpAndSettle();
  }

  PracticeSessionController controller(WidgetTester tester) => tester
      .appContainer
      .read(practiceSessionControllerProvider(MathTopic.fractions).notifier);

  Future<void> snapshot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/$name.png'),
    );
  }

  const fractions =
      '${AppRoutes.practiceSession}?${AppRoutes.topicParam}=fractions';

  testWidgets('practice hub', (tester) async {
    await pump(tester);
    await open(tester, AppRoutes.practice);
    await snapshot(tester, 'practice_hub_phone');
  });

  testWidgets('wrong answer with explanation', (tester) async {
    await pump(tester);
    await open(tester, fractions);
    final question = tester.appContainer
        .read(practiceSessionControllerProvider(MathTopic.fractions))
        .question;
    await controller(tester)
        .answer((question.answerIndex + 1) % question.choices.length);
    await snapshot(tester, 'practice_wrong_phone');
  });

  testWidgets('session on desktop with a hint', (tester) async {
    await pump(tester, size: const Size(1280, 860));
    await open(tester, fractions);
    controller(tester).showHint();
    await snapshot(tester, 'practice_hint_desktop');
  });

  testWidgets('summary', (tester) async {
    await pump(tester);
    await open(tester, fractions);
    for (var i = 0; i < 10; i++) {
      final question = tester.appContainer
          .read(practiceSessionControllerProvider(MathTopic.fractions))
          .question;
      await controller(tester).answer(
        i.isEven
            ? question.answerIndex
            : (question.answerIndex + 1) % question.choices.length,
      );
      await controller(tester).next();
    }
    await snapshot(tester, 'practice_summary_phone');
  });

  testWidgets('exponents render raised without special glyphs', (tester) async {
    await pump(tester);
    await open(
      tester,
      '${AppRoutes.practiceSession}?${AppRoutes.topicParam}=exponents',
    );
    await snapshot(tester, 'practice_exponents_phone');
  });
}
