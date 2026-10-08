import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/features/math/domain/adaptive/adaptive_model.dart';
import 'package:math_strike/features/math/domain/difficulty/difficulty_profile.dart';
import 'package:math_strike/features/math/domain/entities/math_topic.dart';
import 'package:math_strike/features/math/domain/entities/topic_mastery.dart';
import 'package:math_strike/features/math/math_providers.dart';
import 'package:math_strike/features/math/presentation/controllers/practice_session_controller.dart';
import 'package:math_strike/features/math/presentation/screens/practice_screen.dart';
import 'package:math_strike/features/math/presentation/screens/practice_session_screen.dart';
import 'package:math_strike/features/profile/domain/entities/age_group.dart';
import 'package:math_strike/features/profile/domain/entities/difficulty.dart';
import 'package:math_strike/routing/app_router.dart';
import 'package:math_strike/routing/app_routes.dart';

import '../../helpers/fake_clock.dart';
import '../../helpers/test_app.dart';

void main() {
  late InMemoryLocalDatabase database;

  setUp(() => database = InMemoryLocalDatabase());

  Future<void> pumpApp(
    WidgetTester tester, {
    Size size = const Size(400, 900),
  }) => tester.pumpMathStrikeApp(
    database: database,
    size: size,
    overrides: [
      FakeClock(DateTime(2026, 10, 9, 16)).override,
      mathRandomProvider.overrideWithValue(math.Random(8)),
    ],
  );

  Future<void> openSession(WidgetTester tester, MathTopic topic) async {
    tester.appContainer
        .read(appRouterProvider)
        .push<void>(
          '${AppRoutes.practiceSession}?${AppRoutes.topicParam}=${topic.name}',
        )
        .ignore();
    await tester.pumpAndSettle();
  }

  PracticeSession sessionState(WidgetTester tester, MathTopic? topic) =>
      tester.appContainer.read(practiceSessionControllerProvider(topic));

  /// Seeds weak subtraction mastery.
  Future<void> seedWeakSubtraction() async {
    const model = AdaptiveModel();
    final profile = DifficultyProfile.of(
      AgeGroup.latePrimary,
      Difficulty.medium,
    );
    TopicMastery? mastery;
    for (var i = 0; i < 8; i++) {
      mastery = model.record(
        mastery,
        const AnswerOutcome(
          correct: false,
          level: 3,
          reactionTime: Duration(seconds: 5),
        ),
        profile,
        DateTime(2026, 10, 8),
      );
    }
    await database
        .store(StorageBox.learning)
        .writeJson(
          LearningKeys.progress,
          const LearningProgress()
              .withMastery(MathTopic.subtraction, mastery!)
              .toJson(),
        );
  }

  testWidgets('the Play tab opens practice, listing the age group topics', (
    tester,
  ) async {
    await pumpApp(tester);
    await tester.tap(find.text('Play').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Practice mode'));
    await tester.pumpAndSettle();

    // push() keeps the base location, so check what is on screen.
    expect(find.byType(PracticeScreen), findsOneWidget);
    expect(find.text('Recommended mix'), findsOneWidget);
    // The test profile is 9–12: fractions yes, algebra no.
    await tester.scrollUntilVisible(find.text('Fractions'), 200);
    expect(find.text('Fractions'), findsOneWidget);
    expect(find.text('Algebra'), findsNothing);
  });

  testWidgets('weak topics are recommended on the hub and on Home', (
    tester,
  ) async {
    await seedWeakSubtraction();
    await pumpApp(tester);

    await tester.scrollUntilVisible(find.text('Practise Subtraction'), 200);
    expect(
      find.textContaining('Subtraction needs some practice'),
      findsOneWidget,
    );

    await tester.tap(find.text('All topics'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(Chip, 'Subtraction'), findsOneWidget);
    expect(find.text('Needs practice'), findsWidgets);
  });

  testWidgets('a full session: answer, explanation, hint and summary', (
    tester,
  ) async {
    await pumpApp(tester);
    await openSession(tester, MathTopic.addition);
    expect(find.byType(PracticeSessionScreen), findsOneWidget);
    expect(find.text('Question 1 of 10'), findsOneWidget);

    // Hint first.
    await tester.tap(find.text('Show a hint'));
    await tester.pump();
    expect(
      find.text(sessionState(tester, MathTopic.addition).question.hint),
      findsOneWidget,
    );

    // Wrong answer shows the right one and the explanation.
    var question = sessionState(tester, MathTopic.addition).question;
    final wrong = (question.answerIndex + 1) % question.choices.length;
    await tester.tap(find.byKey(ValueKey('choice-$wrong')));
    await tester.pumpAndSettle();
    expect(
      find.text('Not quite — the answer is ${question.answer}'),
      findsOneWidget,
    );
    expect(find.text(question.explanation), findsOneWidget);
    expect(
      find.bySemanticsLabel('${question.answer}, correct answer'),
      findsOneWidget,
    );

    await tester.tap(find.text('Next question'));
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 10'), findsOneWidget);

    for (var i = 2; i <= 10; i++) {
      question = sessionState(tester, MathTopic.addition).question;
      await tester.tap(find.byKey(ValueKey('choice-${question.answerIndex}')));
      await tester.pumpAndSettle();
      expect(find.text('Correct!'), findsOneWidget);
      await tester.tap(find.text(i == 10 ? 'See results' : 'Next question'));
      await tester.pumpAndSettle();
    }

    expect(find.text('Brilliant work!'), findsOneWidget);
    expect(find.bySemanticsLabel('Score: 9 / 10'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Review your mistakes'), 200);
    expect(find.text('Review your mistakes'), findsOneWidget);

    await tester.scrollUntilVisible(find.text('Practice again'), 200);
    await tester.tap(find.text('Practice again'));
    await tester.pumpAndSettle();
    expect(find.text('Question 1 of 10'), findsOneWidget);
  });

  testWidgets('number keys answer, H shows the hint and Enter moves on', (
    tester,
  ) async {
    await pumpApp(tester, size: const Size(1280, 900));
    await openSession(tester, MathTopic.multiplication);

    await tester.sendKeyEvent(LogicalKeyboardKey.keyH);
    await tester.pump();
    expect(sessionState(tester, MathTopic.multiplication).hintShown, isTrue);

    final question = sessionState(tester, MathTopic.multiplication).question;
    await tester.sendKeyEvent(
      [
        LogicalKeyboardKey.digit1,
        LogicalKeyboardKey.digit2,
        LogicalKeyboardKey.digit3,
        LogicalKeyboardKey.digit4,
      ][question.answerIndex],
    );
    await tester.pumpAndSettle();
    expect(find.text('Correct!'), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.text('Question 2 of 10'), findsOneWidget);
  });

  testWidgets('the session screen fits 200% text', (tester) async {
    await pumpApp(tester);
    tester.platformDispatcher.textScaleFactorTestValue = 2;
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
    await openSession(tester, MathTopic.wordProblems);
    final question = sessionState(tester, MathTopic.wordProblems).question;
    await tester.tap(find.byKey(ValueKey('choice-${question.answerIndex}')));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('practice results show on the Progress tab', (tester) async {
    await seedWeakSubtraction();
    await pumpApp(tester);
    await tester.tap(find.text('Progress').last);
    await tester.pumpAndSettle();

    await tester.scrollUntilVisible(find.text('Subtraction · L1'), 200);
    expect(find.text('1 of 14 topics practised'), findsOneWidget);
    await tester.tap(find.text('Subtraction · L1'));
    await tester.pumpAndSettle();
    expect(find.byType(PracticeSessionScreen), findsOneWidget);
    expect(
      sessionState(tester, MathTopic.subtraction).question.topic,
      MathTopic.subtraction,
    );
  });
}
