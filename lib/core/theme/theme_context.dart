import 'package:flutter/material.dart';

import 'game_palette.dart';

/// Terse accessors for theme data and motion preferences.
extension ThemeContext on BuildContext {
  /// The current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// The current [ColorScheme].
  ColorScheme get colors => Theme.of(this).colorScheme;

  /// The current [TextTheme].
  TextTheme get textStyles => Theme.of(this).textTheme;

  /// Gameplay semantic colours.
  GamePalette get gamePalette => Theme.of(this).extension<GamePalette>()!;

  /// Whether animations should be minimised — true when either the OS
  /// accessibility setting or the in-app "reduce motion" option is on
  /// (the app merges both into [MediaQueryData.disableAnimations]).
  bool get reduceMotion => MediaQuery.disableAnimationsOf(this);

  /// Returns [duration], or [Duration.zero] when motion is reduced.
  Duration motion(Duration duration) => reduceMotion ? Duration.zero : duration;
}
