import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/startup/startup_task.dart';
import 'package:math_strike/core/widgets/brand/math_strike_logo.dart';
import 'package:math_strike/core/widgets/brand/math_strike_wordmark.dart';
import 'package:math_strike/features/splash/presentation/screens/splash_screen.dart';
import 'package:math_strike/features/splash/splash_providers.dart';
import 'package:math_strike/routing/app_router.dart';
import 'package:math_strike/routing/app_routes.dart';

import '../../helpers/test_app.dart';

void main() {
  testWidgets('shows brand, progress and version, then goes home', (
    tester,
  ) async {
    final gate = Completer<void>();
    await tester.pumpMathStrikeAppAtSplash(
      overrides: [
        startupTasksProvider.overrideWithValue([
          StartupTask(id: 'wait', label: 'Warming up', run: () => gate.future),
        ]),
      ],
    );
    await tester.pump(const Duration(milliseconds: 1900)); // entrance done

    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(MathStrikeLogo), findsOneWidget);
    expect(find.byType(MathStrikeWordmark), findsOneWidget);
    expect(find.bySemanticsLabel('Math Strike'), findsOneWidget);
    expect(find.text('Warming up…'), findsOneWidget);
    expect(find.text('v1.0.0 (1)'), findsOneWidget);
    expect(find.bySemanticsLabel('Loading'), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();

    expect(find.byType(SplashScreen), findsNothing);
    expect(tester.currentLocation, AppRoutes.home);
  });

  testWidgets('start-up waits until the splash is actually on screen', (
    tester,
  ) async {
    // Regression: on the web the first frame can be built long before it is
    // rasterized; the splash must not run (and burn its minimum duration)
    // while still hidden behind the HTML pre-loader.
    final rasterized = Completer<void>();
    var ran = false;
    await tester.pumpMathStrikeAppAtSplash(
      firstFrameSignal: () => rasterized.future,
      overrides: [
        startupTasksProvider.overrideWithValue([
          StartupTask(id: 'probe', label: 'Probe', run: () async => ran = true),
        ]),
      ],
    );
    await tester.pump(const Duration(seconds: 2));
    expect(ran, isFalse);
    expect(find.byType(SplashScreen), findsOneWidget);

    rasterized.complete();
    await tester.pumpAndSettle();

    expect(ran, isTrue);
    expect(tester.currentLocation, AppRoutes.home);
  });

  testWidgets('critical failure shows a retry that recovers', (tester) async {
    var attempts = 0;
    await tester.pumpMathStrikeAppAtSplash(
      overrides: [
        startupTasksProvider.overrideWithValue([
          StartupTask(
            id: 'database',
            label: 'Opening your save data',
            isCritical: true,
            run: () async {
              if (++attempts == 1) throw StateError('locked');
            },
          ),
        ]),
      ],
    );
    await tester.pump(const Duration(milliseconds: 1900));

    expect(find.text("We couldn't start the game"), findsOneWidget);
    expect(tester.currentLocation, startsWith(AppRoutes.splash));

    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();

    expect(attempts, 2);
    expect(tester.currentLocation, AppRoutes.home);
  });

  testWidgets('deep links wait for start-up, then open', (tester) async {
    final gate = Completer<void>();
    await tester.pumpMathStrikeAppAtSplash(
      overrides: [
        startupTasksProvider.overrideWithValue([
          StartupTask(id: 'wait', label: 'Wait', run: () => gate.future),
        ]),
      ],
    );

    tester.container.read(appRouterProvider).go(AppRoutes.settings);
    await tester.pump();
    await tester.pump();
    expect(find.byType(SplashScreen), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();

    expect(tester.currentLocation, AppRoutes.settings);
  });

  testWidgets('reduced motion: nothing loops, so the splash settles', (
    tester,
  ) async {
    tester.platformDispatcher.accessibilityFeaturesTestValue =
        const FakeAccessibilityFeatures(disableAnimations: true);
    addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

    final gate = Completer<void>();
    await tester.pumpMathStrikeAppAtSplash(
      overrides: [
        startupTasksProvider.overrideWithValue([
          StartupTask(id: 'wait', label: 'Wait', run: () => gate.future),
        ]),
      ],
    );

    // Would time out if any animation were still repeating.
    await tester.pumpAndSettle();
    expect(find.byType(SplashScreen), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();
    expect(tester.currentLocation, AppRoutes.home);
  });

  testWidgets('splash survives very small landscape windows', (tester) async {
    final gate = Completer<void>();
    await tester.pumpMathStrikeAppAtSplash(
      size: const Size(640, 320),
      overrides: [
        startupTasksProvider.overrideWithValue([
          StartupTask(id: 'wait', label: 'Wait', run: () => gate.future),
        ]),
      ],
    );
    await tester.pump(const Duration(milliseconds: 1900));

    expect(tester.takeException(), isNull);

    gate.complete();
    await tester.pumpAndSettle();
  });
}
