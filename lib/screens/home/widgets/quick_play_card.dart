import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/brand_colors.dart';
import '../../../core/theme/theme_context.dart';
import '../../../routing/app_routes.dart';

/// The dashboard's main call to action: jump straight into a game.
class QuickPlayCard extends StatelessWidget {
  /// Creates the card.
  const QuickPlayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [BrandColors.deepSpace, BrandColors.nebula],
          ),
        ),
        child: Stack(
          children: [
            // Decorative rocket behind the content, so the text and button
            // always get the full width (large text sizes, narrow phones).
            Positioned(
              right: -12,
              bottom: -16,
              child: ExcludeSemantics(
                child: Icon(
                  Icons.rocket_launch_rounded,
                  size: 120,
                  color: BrandColors.magenta.withValues(alpha: 0.35),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready for a challenge?',
                    style: context.textStyles.titleLarge?.copyWith(
                      color: BrandColors.star,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Shoot the right answers, build your combo and earn '
                    'coins.',
                    style: context.textStyles.bodyMedium?.copyWith(
                      color: BrandColors.star.withValues(alpha: 0.85),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  FilledButton.icon(
                    onPressed: () => context.push(AppRoutes.game),
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Quick play'),
                    style: FilledButton.styleFrom(
                      backgroundColor: BrandColors.cyan,
                      foregroundColor: BrandColors.midnight,
                      minimumSize: const Size(160, 52),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
