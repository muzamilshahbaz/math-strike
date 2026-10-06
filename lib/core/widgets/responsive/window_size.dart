import 'package:flutter/widgets.dart';

import '../../constants/app_breakpoints.dart';

/// Material 3 window size classes.
enum WindowSize {
  /// Phones in portrait (< 600dp).
  compact,

  /// Tablets in portrait, foldables, small windows (600–839dp).
  medium,

  /// Tablets in landscape, small desktop windows (840–1199dp).
  expanded,

  /// Desktop and large web windows (≥ 1200dp).
  large;

  /// Classifies a logical [width].
  static WindowSize fromWidth(double width) {
    if (width >= AppBreakpoints.large) return WindowSize.large;
    if (width >= AppBreakpoints.expanded) return WindowSize.expanded;
    if (width >= AppBreakpoints.medium) return WindowSize.medium;
    return WindowSize.compact;
  }

  /// Whether this is at least [other] (e.g. `size >= WindowSize.medium`).
  bool operator >=(WindowSize other) => index >= other.index;
}

/// Responsive shortcuts on [BuildContext].
extension WindowSizeContext on BuildContext {
  /// The window size class for the current screen width.
  ///
  /// Uses `MediaQuery.sizeOf` so widgets rebuild only on size changes.
  WindowSize get windowSize =>
      WindowSize.fromWidth(MediaQuery.sizeOf(this).width);
}

/// Builds a different subtree per [WindowSize], falling back to the nearest
/// smaller layout that was provided.
class ResponsiveLayout extends StatelessWidget {
  /// Creates a responsive layout. Only [compact] is required.
  const ResponsiveLayout({
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    super.key,
  });

  /// Phone layout (also the final fallback).
  final WidgetBuilder compact;

  /// Tablet layout.
  final WidgetBuilder? medium;

  /// Landscape tablet / small desktop layout.
  final WidgetBuilder? expanded;

  /// Desktop layout.
  final WidgetBuilder? large;

  @override
  Widget build(BuildContext context) {
    final builder = switch (context.windowSize) {
      WindowSize.large => large ?? expanded ?? medium ?? compact,
      WindowSize.expanded => expanded ?? medium ?? compact,
      WindowSize.medium => medium ?? compact,
      WindowSize.compact => compact,
    };
    return builder(context);
  }
}
