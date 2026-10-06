import 'package:flutter/material.dart';

/// Semantic, gameplay-specific colours that Material's [ColorScheme] does
/// not cover (feedback, currencies, combo glow).
///
/// Read with `Theme.of(context).extension<GamePalette>()!` or the
/// `context.gamePalette` shortcut.
@immutable
class GamePalette extends ThemeExtension<GamePalette> {
  /// Creates a palette. Prefer [GamePalette.light] / [GamePalette.dark].
  const GamePalette({
    required this.correct,
    required this.onCorrect,
    required this.wrong,
    required this.onWrong,
    required this.coin,
    required this.diamond,
    required this.xp,
    required this.combo,
  });

  /// Palette tuned for light backgrounds.
  factory GamePalette.light({bool highContrast = false}) => GamePalette(
    correct: highContrast ? const Color(0xFF00531F) : const Color(0xFF1E8E3E),
    onCorrect: Colors.white,
    wrong: highContrast ? const Color(0xFF8C0009) : const Color(0xFFD93025),
    onWrong: Colors.white,
    coin: const Color(0xFFB8860B),
    diamond: const Color(0xFF0288D1),
    xp: const Color(0xFF7B1FA2),
    combo: const Color(0xFFE65100),
  );

  /// Palette tuned for dark backgrounds.
  factory GamePalette.dark({bool highContrast = false}) => GamePalette(
    correct: highContrast ? const Color(0xFF8CFFA8) : const Color(0xFF5BD97F),
    onCorrect: Colors.black,
    wrong: highContrast ? const Color(0xFFFFB4AB) : const Color(0xFFFF6B61),
    onWrong: Colors.black,
    coin: const Color(0xFFFFD54F),
    diamond: const Color(0xFF4FC3F7),
    xp: const Color(0xFFCE93D8),
    combo: const Color(0xFFFFA726),
  );

  /// Correct answer / success feedback.
  final Color correct;

  /// Foreground on [correct].
  final Color onCorrect;

  /// Wrong answer / damage feedback.
  final Color wrong;

  /// Foreground on [wrong].
  final Color onWrong;

  /// Coin currency.
  final Color coin;

  /// Diamond (premium) currency.
  final Color diamond;

  /// Experience points.
  final Color xp;

  /// Combo counter and streak glow.
  final Color combo;

  @override
  GamePalette copyWith({
    Color? correct,
    Color? onCorrect,
    Color? wrong,
    Color? onWrong,
    Color? coin,
    Color? diamond,
    Color? xp,
    Color? combo,
  }) => GamePalette(
    correct: correct ?? this.correct,
    onCorrect: onCorrect ?? this.onCorrect,
    wrong: wrong ?? this.wrong,
    onWrong: onWrong ?? this.onWrong,
    coin: coin ?? this.coin,
    diamond: diamond ?? this.diamond,
    xp: xp ?? this.xp,
    combo: combo ?? this.combo,
  );

  @override
  GamePalette lerp(covariant GamePalette? other, double t) {
    if (other == null) return this;
    return GamePalette(
      correct: Color.lerp(correct, other.correct, t)!,
      onCorrect: Color.lerp(onCorrect, other.onCorrect, t)!,
      wrong: Color.lerp(wrong, other.wrong, t)!,
      onWrong: Color.lerp(onWrong, other.onWrong, t)!,
      coin: Color.lerp(coin, other.coin, t)!,
      diamond: Color.lerp(diamond, other.diamond, t)!,
      xp: Color.lerp(xp, other.xp, t)!,
      combo: Color.lerp(combo, other.combo, t)!,
    );
  }
}
