import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/errors/failure_messages.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/effects/confetti_burst.dart';
import '../../domain/entities/daily_reward.dart';
import '../../domain/entities/reward.dart';
import '../controllers/daily_reward_controller.dart';
import 'currency.dart';
import 'next_reward_countdown.dart';

/// Opens the daily-reward calendar as a modal bottom sheet.
///
/// Uses the root navigator so the sheet covers the navigation bar instead
/// of opening inside the current tab beneath it.
Future<void> showDailyRewardSheet(BuildContext context) =>
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) => const DailyRewardSheet(),
    );

/// The 7-day reward calendar, with the claim button and celebration.
class DailyRewardSheet extends ConsumerStatefulWidget {
  /// Creates the sheet.
  const DailyRewardSheet({super.key});

  @override
  ConsumerState<DailyRewardSheet> createState() => _DailyRewardSheetState();
}

class _DailyRewardSheetState extends ConsumerState<DailyRewardSheet> {
  DailyRewardClaim? _claimed;
  bool _busy = false;
  String? _error;

  Future<void> _claim() async {
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref
        .read(dailyRewardControllerProvider.notifier)
        .claim();
    if (!mounted) return;
    setState(() {
      _busy = false;
      switch (result) {
        case Success(:final value):
          _claimed = value;
        case Err(:final failure):
          _error = describeFailure(
            failure,
            fallback: "Couldn't save your reward. Please try again.",
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(dailyRewardControllerProvider);
    final claimed = _claimed;
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Semantics(
                header: true,
                child: Text(
                  'Daily rewards',
                  style: context.textStyles.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              StreakLabel(streak: status.streak),
              if (status.canClaim && status.streakLost) ...[
                const SizedBox(height: AppSpacing.smd),
                Text(
                  'You missed a day, so your streak starts again. '
                  'Come back every day to keep it going!',
                  textAlign: TextAlign.center,
                  style: context.textStyles.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (var day = 1; day <= status.cycle.length; day++)
                    _DayTile(
                      day: day,
                      reward: status.cycle[day - 1],
                      state: status.isClaimed(day)
                          ? _DayState.claimed
                          : status.canClaim && day == status.cycleDay
                          ? _DayState.ready
                          : _DayState.upcoming,
                      isChest: day == status.cycle.length,
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              if (claimed != null)
                _ClaimCelebration(claim: claimed)
              else if (status.canClaim)
                FilledButton.icon(
                  onPressed: _busy ? null : _claim,
                  icon: const Icon(Icons.redeem_rounded),
                  label: Text('Claim day ${status.cycleDay} reward'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(220, 52),
                  ),
                )
              else
                _ComeBackTomorrow(status: status),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.smd),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: context.colors.error),
                ),
              ],
            ],
          ),
        ),
        if (claimed != null)
          Positioned.fill(child: ConfettiBurst(key: ValueKey(claimed))),
      ],
    );
  }
}

/// "3-day streak" with a flame, or an invitation to start one.
class StreakLabel extends StatelessWidget {
  /// Creates the label.
  const StreakLabel({required this.streak, super.key});

  /// Current streak in days.
  final int streak;

  @override
  Widget build(BuildContext context) {
    final color = context.gamePalette.combo;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.local_fire_department_rounded, color: color, size: 20),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(
            streak == 0 ? 'Start a streak today!' : '$streak-day streak',
            style: context.textStyles.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

enum _DayState { claimed, ready, upcoming }

class _DayTile extends StatelessWidget {
  const _DayTile({
    required this.day,
    required this.reward,
    required this.state,
    required this.isChest,
  });

  final int day;
  final Reward reward;
  final _DayState state;
  final bool isChest;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final (background, border) = switch (state) {
      _DayState.ready => (colors.primaryContainer, colors.primary),
      _DayState.claimed => (colors.surfaceContainerHighest, Colors.transparent),
      _DayState.upcoming => (colors.surfaceContainerLow, colors.outlineVariant),
    };
    final stateText = switch (state) {
      _DayState.claimed => 'claimed',
      _DayState.ready => 'ready to claim',
      _DayState.upcoming => 'locked',
    };
    final icon = switch (state) {
      _DayState.claimed => Icon(
        Icons.check_circle_rounded,
        color: context.gamePalette.correct,
        size: 28,
      ),
      _ when isChest => Icon(
        Icons.redeem_rounded,
        color: context.gamePalette.coin,
        size: 32,
      ),
      _ => Icon(
        reward.diamonds > 0 ? Icons.diamond_rounded : Currency.coins.icon,
        color: reward.diamonds > 0
            ? context.gamePalette.diamond
            : context.gamePalette.coin,
        size: 28,
      ),
    };

    return Semantics(
      container: true,
      label: 'Day $day, ${describeReward(reward)}, $stateText',
      selected: state == _DayState.ready,
      excludeSemantics: true,
      child: AnimatedContainer(
        duration: context.motion(AppDurations.medium),
        width: isChest ? 152 : 72,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: background,
          borderRadius: AppRadii.mdAll,
          border: Border.all(
            color: border,
            width: state == _DayState.ready ? 2 : 1,
          ),
        ),
        child: Opacity(
          opacity: state == _DayState.claimed ? 0.7 : 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Day $day',
                style: context.textStyles.labelMedium?.copyWith(
                  fontWeight: state == _DayState.ready ? FontWeight.w800 : null,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              icon,
              const SizedBox(height: AppSpacing.xs),
              RewardAmounts(
                reward: reward,
                iconSize: 12,
                style: context.textStyles.labelSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ClaimCelebration extends StatelessWidget {
  const _ClaimCelebration({required this.claim});

  final DailyRewardClaim claim;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.5, end: 1),
          duration: context.motion(AppDurations.extraLong),
          curve: Curves.elasticOut,
          builder: (context, scale, child) =>
              Transform.scale(scale: scale, child: child),
          child: Semantics(
            liveRegion: true,
            label:
                'Day ${claim.cycleDay} reward claimed: '
                '${describeReward(claim.reward)}',
            excludeSemantics: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Reward claimed!',
                  style: context.textStyles.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                RewardAmounts(
                  reward: claim.reward,
                  iconSize: 28,
                  style: context.textStyles.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          style: FilledButton.styleFrom(minimumSize: const Size(180, 48)),
          child: const Text('Awesome!'),
        ),
      ],
    );
  }
}

class _ComeBackTomorrow extends StatelessWidget {
  const _ComeBackTomorrow({required this.status});

  final DailyRewardStatus status;

  @override
  Widget build(BuildContext context) {
    final muted = context.textStyles.bodyMedium?.copyWith(
      color: context.colors.onSurfaceVariant,
    );
    final tomorrow = status.cycleDay % status.cycle.length + 1;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Today's reward is collected. Come back tomorrow for day "
          '$tomorrow:',
          textAlign: TextAlign.center,
          style: muted,
        ),
        const SizedBox(height: AppSpacing.sm),
        RewardAmounts(reward: status.nextReward),
        const SizedBox(height: AppSpacing.sm),
        NextRewardCountdown(style: muted),
      ],
    );
  }
}
