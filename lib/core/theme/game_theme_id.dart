import 'package:flutter/material.dart';

/// The catalogue of visual themes a player can apply.
///
/// Each theme contributes a seed colour from which the full Material 3
/// colour scheme is generated, so every screen stays consistent. Unlock
/// rules live in the rewards/shop features (Phase 10); game backgrounds
/// per theme arrive with the gameplay art (Phases 7–8).
enum GameThemeId {
  /// Default theme: deep-space violet.
  space('Space', Color(0xFF6C4DFF), Icons.rocket_launch_rounded),

  /// Lush greens.
  forest('Forest', Color(0xFF2E9D5B), Icons.park_rounded),

  /// Calm blues.
  ocean('Ocean', Color(0xFF0A84C6), Icons.waves_rounded),

  /// Warm sand.
  desert('Desert', Color(0xFFD08A2E), Icons.wb_sunny_rounded),

  /// Hot pink on dark.
  cyberpunk('Cyberpunk', Color(0xFFFF2E88), Icons.memory_rounded),

  /// Friendly chalkboard green / pencil yellow.
  school('School', Color(0xFF3F7D4E), Icons.school_rounded),

  /// Pastel sweets.
  candy('Candy', Color(0xFFFF7EB6), Icons.icecream_rounded),

  /// Nebula purple-blue.
  galaxy('Galaxy', Color(0xFF4C3FD1), Icons.auto_awesome_rounded),

  /// Terracotta and gold.
  ancient('Ancient', Color(0xFFA0522D), Icons.account_balance_rounded),

  /// Electric cyan.
  neon('Neon', Color(0xFF00D1C1), Icons.bolt_rounded);

  const GameThemeId(this.label, this.seedColor, this.icon);

  /// Display name.
  final String label;

  /// Seed for `ColorScheme.fromSeed`.
  final Color seedColor;

  /// Representative icon for pickers.
  final IconData icon;
}
