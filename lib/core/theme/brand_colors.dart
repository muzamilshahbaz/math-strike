import 'package:flutter/material.dart';

/// Fixed brand colours used by the logo and the splash screen.
///
/// Unlike [ColorScheme] colours these never change with the player's theme:
/// the splash is drawn before the saved theme has been loaded, and the
/// brand must look identical on every launch.
abstract final class BrandColors {
  /// Darkest background tone.
  static const Color midnight = Color(0xFF0B0820);

  /// Mid background tone.
  static const Color deepSpace = Color(0xFF1A1040);

  /// Nebula glow behind the logo.
  static const Color nebula = Color(0xFF3A1670);

  /// Primary brand accent.
  static const Color violet = Color(0xFF8F7BFF);

  /// Secondary accent (progress, highlights).
  static const Color cyan = Color(0xFF3FE0FF);

  /// Tertiary accent (logo gradient, glow).
  static const Color magenta = Color(0xFFFF4FD8);

  /// Star / foreground white.
  static const Color star = Color(0xFFF4F1FF);

  /// Full-screen splash background.
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [deepSpace, midnight],
  );

  /// Logo tile and progress-bar fill.
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [violet, magenta],
  );
}
