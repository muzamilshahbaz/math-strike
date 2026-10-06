@Tags(['golden'])
library;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/startup/startup_task.dart';
import 'package:math_strike/features/splash/splash_providers.dart';

import '../helpers/golden_fonts.dart';
import '../helpers/test_app.dart';

void main() {
  setUpAll(loadGoldenFonts);

  testWidgets('splash at the moment of impact', (tester) async {
    final gate = Completer<void>();
    await tester.pumpMathStrikeAppAtSplash(
      size: const Size(400, 820),
      overrides: [
        startupTasksProvider.overrideWithValue([
          StartupTask(
            id: 'wait',
            label: 'Opening your save data',
            run: () => gate.future,
          ),
        ]),
      ],
    );
    // 1.8 s entrance: impact flash peaks ~0.9 s, wordmark sweep mid-way.
    await tester.pump(const Duration(milliseconds: 1150));

    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/splash_impact_phone.png'),
    );

    gate.complete();
    await tester.pumpAndSettle();
  });

  for (final (name, size) in [
    ('phone', const Size(400, 820)),
    ('desktop', const Size(1280, 800)),
  ]) {
    testWidgets('splash mid-start-up ($name)', (tester) async {
      final gate = Completer<void>();
      await tester.pumpMathStrikeAppAtSplash(
        size: size,
        overrides: [
          startupTasksProvider.overrideWithValue([
            StartupTask(id: 'db', label: 'Done', weight: 3, run: () async {}),
            StartupTask(
              id: 'theme',
              label: 'Loading your theme',
              run: () => gate.future,
            ),
          ]),
        ],
      );
      // Entrance finished; ambient animations at a fixed point in time.
      await tester.pump(const Duration(milliseconds: 2000));

      await expectLater(
        find.byType(MathStrikeApp),
        matchesGoldenFile('goldens/splash_$name.png'),
      );

      gate.complete();
      await tester.pumpAndSettle();
    });
  }
}
