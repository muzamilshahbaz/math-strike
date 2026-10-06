import 'package:flutter/material.dart';

import '../../core/constants/app_durations.dart';
import '../../core/theme/app_tokens.dart';
import '../../core/theme/theme_context.dart';

/// Temporary screen for a destination whose feature ships in a later phase.
///
/// Keeps navigation fully testable from Phase 1 onward; each instance is
/// replaced by the real feature screen in its phase.
class PlaceholderScreen extends StatelessWidget {
  /// Creates a placeholder.
  const PlaceholderScreen({
    required this.title,
    required this.icon,
    required this.phase,
    this.description,
    this.action,
    super.key,
  });

  /// App-bar title and headline.
  final String title;

  /// Illustrative icon.
  final IconData icon;

  /// Development phase that delivers this screen.
  final int phase;

  /// Optional one-line explanation.
  final String? description;

  /// Optional call-to-action.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.6, end: 1),
                  duration: context.motion(AppDurations.long),
                  curve: Curves.elasticOut,
                  builder: (context, scale, child) =>
                      Transform.scale(scale: scale, child: child),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: colors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 56,
                      color: colors.onPrimaryContainer,
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  title,
                  style: context.textStyles.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.sm),
                Chip(
                  avatar: const Icon(Icons.construction_rounded, size: 18),
                  label: Text('Arrives in Phase $phase'),
                ),
                if (description != null) ...[
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    description!,
                    style: context.textStyles.bodyLarge?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
                if (action != null) ...[
                  const SizedBox(height: AppSpacing.lg),
                  action!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
