/// Standard motion durations, aligned with Material 3 motion tokens.
///
/// Always resolve these through `context.motion(...)` so the user's
/// "reduce motion" preference is honoured.
abstract final class AppDurations {
  /// Micro-interactions: ripples, toggles, hover states.
  static const Duration short = Duration(milliseconds: 150);

  /// Most component transitions.
  static const Duration medium = Duration(milliseconds: 300);

  /// Page transitions and large surfaces.
  static const Duration long = Duration(milliseconds: 500);

  /// Celebratory effects (confetti, level-up).
  static const Duration extraLong = Duration(milliseconds: 900);
}
