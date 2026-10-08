import 'package:flutter/material.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../domain/entities/age_group.dart';
import '../../domain/entities/difficulty.dart';
import '../avatars/avatar_catalog.dart';
import '../avatars/avatar_view.dart';

/// A player's identity card: avatar, name, age group and difficulty.
///
/// Used as the live preview during onboarding and on the home dashboard.
/// Every field is optional so it can render a profile that is still being
/// filled in.
class PlayerCard extends StatelessWidget {
  /// Creates the card.
  const PlayerCard({
    required this.avatar,
    this.name,
    this.ageGroup,
    this.difficulty,
    this.avatarSize = 96,
    super.key,
  });

  /// Avatar to show.
  final AvatarSpec avatar;

  /// Player name; a placeholder is shown when empty.
  final String? name;

  /// Age group, if chosen.
  final AgeGroup? ageGroup;

  /// Difficulty, if chosen.
  final Difficulty? difficulty;

  /// Avatar diameter.
  final double avatarSize;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final displayName = (name?.trim().isNotEmpty ?? false)
        ? name!.trim()
        : 'Your name';
    return Card(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colors.primaryContainer, colors.tertiaryContainer],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: context.motion(AppDurations.medium),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: AvatarView(
                key: ValueKey(avatar.id),
                avatar: avatar,
                size: avatarSize,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              displayName,
              textAlign: TextAlign.center,
              style: context.textStyles.headlineSmall?.copyWith(
                color: colors.onPrimaryContainer,
              ),
            ),
            if (ageGroup != null || difficulty != null) ...[
              const SizedBox(height: AppSpacing.smd),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  if (ageGroup != null)
                    _Tag(icon: Icons.cake_rounded, label: ageGroup!.label),
                  if (difficulty != null)
                    _Tag(icon: Icons.speed_rounded, label: difficulty!.label),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.smd,
      vertical: AppSpacing.xs + 2,
    ),
    decoration: BoxDecoration(
      color: context.colors.surface.withValues(alpha: 0.7),
      borderRadius: const BorderRadius.all(AppRadii.pill),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: context.colors.primary),
        const SizedBox(width: AppSpacing.xs + 2),
        Text(label, style: context.textStyles.labelLarge),
      ],
    ),
  );
}
