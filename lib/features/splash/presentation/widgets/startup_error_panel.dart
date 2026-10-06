import 'package:flutter/material.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/brand_colors.dart';
import '../../domain/entities/startup_state.dart';

/// Shown on the splash screen when a critical start-up task fails.
class StartupErrorPanel extends StatelessWidget {
  /// Creates the panel.
  const StartupErrorPanel({
    required this.failure,
    required this.onRetry,
    super.key,
  });

  /// What failed.
  final StartupFailure failure;

  /// Re-runs start-up.
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 360),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: BrandColors.midnight.withValues(alpha: 0.75),
        borderRadius: AppRadii.lgAll,
        border: Border.all(color: BrandColors.magenta.withValues(alpha: 0.5)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: BrandColors.magenta,
            size: 40,
          ),
          const SizedBox(height: AppSpacing.smd),
          Semantics(
            liveRegion: true,
            child: const Text(
              "We couldn't start the game",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: BrandColors.star,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Something went wrong while ${failure.taskLabel.toLowerCase()}. '
            'Your progress is safe — please try again.',
            textAlign: TextAlign.center,
            style: TextStyle(color: BrandColors.star.withValues(alpha: 0.75)),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton.icon(
            style: FilledButton.styleFrom(
              backgroundColor: BrandColors.violet,
              foregroundColor: BrandColors.midnight,
            ),
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Try again'),
          ),
        ],
      ),
    );
  }
}
