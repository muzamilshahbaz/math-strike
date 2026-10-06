import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/theme/app_theme.dart';
import 'package:math_strike/core/theme/game_palette.dart';
import 'package:math_strike/core/theme/game_theme_id.dart';

void main() {
  group('AppTheme.build', () {
    for (final brightness in Brightness.values) {
      test(
        'produces a Material 3 ${brightness.name} theme with GamePalette',
        () {
          final theme = AppTheme.build(
            seedColor: GameThemeId.space.seedColor,
            brightness: brightness,
          );
          expect(theme.useMaterial3, isTrue);
          expect(theme.colorScheme.brightness, brightness);
          expect(theme.extension<GamePalette>(), isNotNull);
        },
      );
    }

    test('every game theme yields a distinct primary colour', () {
      final primaries = {
        for (final id in GameThemeId.values)
          AppTheme.build(
            seedColor: id.seedColor,
            brightness: Brightness.light,
          ).colorScheme.primary,
      };
      expect(primaries, hasLength(GameThemeId.values.length));
    });

    test('high contrast increases primary/surface contrast', () {
      double contrast(ThemeData t) {
        final a = t.colorScheme.primary.computeLuminance();
        final b = t.colorScheme.surface.computeLuminance();
        final (hi, lo) = a > b ? (a, b) : (b, a);
        return (hi + 0.05) / (lo + 0.05);
      }

      final normal = AppTheme.build(
        seedColor: GameThemeId.candy.seedColor,
        brightness: Brightness.light,
      );
      final high = AppTheme.build(
        seedColor: GameThemeId.candy.seedColor,
        brightness: Brightness.light,
        highContrast: true,
      );
      expect(contrast(high), greaterThan(contrast(normal)));
    });
  });

  test('GamePalette.lerp interpolates between palettes', () {
    final a = GamePalette.light();
    final b = GamePalette.dark();
    expect(a.lerp(b, 0).correct, a.correct);
    expect(a.lerp(b, 1).correct, b.correct);
  });
}
