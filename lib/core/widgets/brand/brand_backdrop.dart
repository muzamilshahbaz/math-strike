import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/brand_colors.dart';

/// Full-screen brand background (deep-space gradient with a nebula glow),
/// shared by the splash and the first-launch screens so they read as one
/// continuous experience. Forces light status-bar icons.
class BrandBackdrop extends StatelessWidget {
  /// Creates the backdrop behind [child]. [layers] are painted between the
  /// background and the child (e.g. particles).
  const BrandBackdrop({required this.child, this.layers = const [], super.key});

  /// Foreground content.
  final Widget child;

  /// Optional decorative layers above the gradient.
  final List<Widget> layers;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Material(
        color: BrandColors.midnight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: BrandColors.backgroundGradient,
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.25),
                  radius: 0.9,
                  colors: [BrandColors.nebula, Colors.transparent],
                ),
              ),
            ),
            ...layers,
            child,
          ],
        ),
      ),
    );
  }
}

/// Text styles for content on [BrandBackdrop] (always dark background,
/// independent of the player's theme).
abstract final class BrandText {
  /// Screen headline.
  static const TextStyle headline = TextStyle(
    color: BrandColors.star,
    fontSize: 26,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );

  /// Body copy.
  static TextStyle body = TextStyle(
    color: BrandColors.star.withValues(alpha: 0.78),
    fontSize: 15,
    height: 1.45,
  );

  /// Small print.
  static TextStyle caption = TextStyle(
    color: BrandColors.star.withValues(alpha: 0.6),
    fontSize: 12.5,
    height: 1.4,
  );
}
