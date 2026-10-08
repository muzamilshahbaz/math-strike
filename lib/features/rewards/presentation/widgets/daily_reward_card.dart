import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../controllers/daily_reward_controller.dart';
import 'currency.dart';
import 'daily_reward_sheet.dart';
import 'next_reward_countdown.dart';

/// Dashboard card for the daily reward: highlights an unclaimed reward and
/// opens the reward calendar.
class DailyRewardCard extends ConsumerWidget {
  /// Creates the card.
  const DailyRewardCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(dailyRewardControllerProvider);
    final colors = context.colors;
    final ready = status.canClaim;
    final muted = context.textStyles.bodyMedium?.copyWith(
      color: colors.onSurfaceVariant,
    );

    return Card(
      child: InkWell(
        onTap: () => showDailyRewardSheet(context),
        child: AnimatedContainer(
          duration: context.motion(AppDurations.medium),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            gradient: ready
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colors.tertiaryContainer, colors.primaryContainer],
                  )
                : null,
          ),
          child: Row(
            children: [
              _GiftIcon(ready: ready),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ready
                          ? 'Day ${status.cycleDay} reward is ready!'
                          : 'Daily reward collected',
                      style: context.textStyles.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    if (ready)
                      RewardAmounts(reward: status.todaysReward)
                    else
                      NextRewardCountdown(style: muted),
                    const SizedBox(height: AppSpacing.xs),
                    StreakLabel(streak: status.streak),
                    if (ready) ...[
                      const SizedBox(height: AppSpacing.smd),
                      FilledButton.icon(
                        onPressed: () => showDailyRewardSheet(context),
                        icon: const Icon(Icons.redeem_rounded),
                        label: const Text('Claim'),
                      ),
                    ],
                  ],
                ),
              ),
              if (!ready) ...[
                const SizedBox(width: AppSpacing.sm),
                Icon(Icons.chevron_right_rounded, color: colors.outline),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _GiftIcon extends StatelessWidget {
  const _GiftIcon({required this.ready});

  final bool ready;

  @override
  Widget build(BuildContext context) {
    final color = context.gamePalette.coin;
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: ready ? 0.25 : 0.12),
        boxShadow: ready
            ? [BoxShadow(color: color.withValues(alpha: 0.5), blurRadius: 16)]
            : null,
      ),
      child: Icon(
        ready ? Icons.redeem_rounded : Icons.card_giftcard_rounded,
        color: color,
        size: 28,
      ),
    );
  }
}
