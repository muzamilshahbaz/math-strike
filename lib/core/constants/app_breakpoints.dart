/// Layout breakpoints following the Material 3 window size classes.
///
/// See https://m3.material.io/foundations/layout/applying-layout/window-size-classes
abstract final class AppBreakpoints {
  /// Width at which the layout switches from compact (phones) to medium.
  static const double medium = 600;

  /// Width at which the layout switches from medium (tablets) to expanded.
  static const double expanded = 840;

  /// Width at which the layout switches from expanded to large (desktop).
  static const double large = 1200;

  /// Maximum width for readable content columns on very wide screens.
  static const double maxContentWidth = 1280;
}
