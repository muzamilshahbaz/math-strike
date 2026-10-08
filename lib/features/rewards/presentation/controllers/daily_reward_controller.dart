import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/daily_reward.dart';
import '../../rewards_providers.dart';
import 'wallet_controller.dart';

part 'daily_reward_controller.g.dart';

/// Today's [DailyRewardStatus]; rolls over automatically at midnight.
///
/// Requires an opened database: only read it after start-up completes.
@Riverpod(keepAlive: true)
class DailyRewardController extends _$DailyRewardController {
  bool _claiming = false;

  @override
  DailyRewardStatus build() {
    ref.watch(localDataEpochProvider);
    final today = ref.watch(currentDayProvider);
    final record = ref.watch(rewardsRepositoryProvider).loadDailyReward();
    return ref.watch(dailyRewardScheduleProvider).statusFor(record, today);
  }

  /// Claims today's reward and credits it to the wallet.
  ///
  /// Fails if the reward is not claimable (already claimed, or a claim is
  /// already in progress) or cannot be saved.
  Future<Result<DailyRewardClaim>> claim() async {
    if (_claiming) return const Err(_notClaimable);
    _claiming = true;
    try {
      // Re-read the clock: the app may have been open across midnight.
      ref.read(currentDayProvider.notifier).refresh();
      final today = ref.read(currentDayProvider);
      final repository = ref.read(rewardsRepositoryProvider);
      final schedule = ref.read(dailyRewardScheduleProvider);
      final claim = schedule.claim(repository.loadDailyReward(), today);
      if (claim == null) return const Err(_notClaimable);

      final wallet = ref.read(walletControllerProvider).credit(claim.reward);
      final saved = await repository.saveDailyClaim(
        record: claim.record,
        wallet: wallet,
      );
      if (saved case Err(:final failure)) return Err(failure);
      if (ref.mounted) {
        ref.read(walletControllerProvider.notifier).applySaved(wallet);
        state = schedule.statusFor(claim.record, today);
      }
      return Success(claim);
    } finally {
      _claiming = false;
    }
  }

  static const Failure _notClaimable = Failure.unexpected(
    "Today's reward has already been claimed",
  );
}
