import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/di/core_providers.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/theme/theme_context.dart';
import '../../../features/profile/presentation/avatars/avatar_catalog.dart';
import '../../../features/profile/presentation/avatars/avatar_view.dart';
import '../../../features/profile/presentation/controllers/profile_controller.dart';
import '../../../features/rewards/presentation/controllers/wallet_controller.dart';
import '../../../features/rewards/presentation/widgets/level_progress.dart';

/// A greeting suited to the local [time] of day.
String greetingFor(DateTime time) => switch (time.hour) {
  >= 5 && < 12 => 'Good morning',
  >= 12 && < 17 => 'Good afternoon',
  >= 17 && < 22 => 'Good evening',
  _ => 'Hello',
};

/// The player's avatar, a greeting, and their level and XP progress.
class PlayerHeader extends ConsumerWidget {
  /// Creates the header.
  const PlayerHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
    final level = ref.watch(walletControllerProvider.select((w) => w.level));
    final greeting = greetingFor(ref.watch(clockProvider)());
    final colors = context.colors;
    final avatar = AvatarCatalog.byId(profile?.avatarId ?? '');

    return Card(
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [colors.primaryContainer, colors.tertiaryContainer],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                AvatarView(avatar: avatar, size: 72),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        greeting,
                        style: context.textStyles.bodyLarge?.copyWith(
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      Text(
                        profile?.name ?? 'Player',
                        style: context.textStyles.headlineSmall?.copyWith(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (profile != null)
                        Text(
                          '${profile.difficulty.label} · '
                          '${profile.ageGroup.label}',
                          style: context.textStyles.labelMedium?.copyWith(
                            color: colors.onPrimaryContainer,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            LevelProgress(level: level, foreground: colors.onPrimaryContainer),
          ],
        ),
      ),
    );
  }
}
