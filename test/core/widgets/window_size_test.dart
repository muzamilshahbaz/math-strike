import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/widgets/responsive/window_size.dart';

import '../../helpers/test_app.dart';

void main() {
  test('WindowSize.fromWidth follows Material 3 breakpoints', () {
    expect(WindowSize.fromWidth(390), WindowSize.compact);
    expect(WindowSize.fromWidth(600), WindowSize.medium);
    expect(WindowSize.fromWidth(900), WindowSize.expanded);
    expect(WindowSize.fromWidth(1440), WindowSize.large);
    expect(WindowSize.large >= WindowSize.medium, isTrue);
    expect(WindowSize.compact >= WindowSize.medium, isFalse);
  });

  testWidgets('ResponsiveLayout falls back to the nearest smaller layout', (
    tester,
  ) async {
    tester.setWindowSize(const Size(1000, 800)); // expanded
    await tester.pumpWidget(
      MaterialApp(
        home: ResponsiveLayout(
          compact: (_) => const Text('compact'),
          medium: (_) => const Text('medium'),
        ),
      ),
    );
    expect(find.text('medium'), findsOneWidget);
  });
}
