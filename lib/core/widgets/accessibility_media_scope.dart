import 'package:flutter/widgets.dart';

/// Applies in-app accessibility preferences on top of the platform ones.
///
/// * [textScale] multiplies the OS text scale (it never overrides a larger
///   system setting downwards).
/// * [reduceMotion] is OR-ed with the OS "remove animations" setting and
///   exposed through [MediaQueryData.disableAnimations], so every widget can
///   use the standard API (or `context.reduceMotion`).
class AccessibilityMediaScope extends StatelessWidget {
  /// Wraps [child] with the adjusted [MediaQuery].
  const AccessibilityMediaScope({
    required this.textScale,
    required this.reduceMotion,
    required this.child,
    super.key,
  });

  /// Extra text scale factor chosen in settings (1.0 = system default).
  final double textScale;

  /// In-app "reduce motion" preference.
  final bool reduceMotion;

  /// The subtree to configure.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final systemScale = media.textScaler.scale(1);
    return MediaQuery(
      data: media.copyWith(
        textScaler: textScale == 1.0
            ? media.textScaler
            : TextScaler.linear(systemScale * textScale),
        disableAnimations: media.disableAnimations || reduceMotion,
      ),
      child: child,
    );
  }
}
