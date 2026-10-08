import '../../../../core/errors/result.dart';
import '../entities/daily_reward.dart';
import '../entities/wallet.dart';

/// Persists the player's [Wallet] and daily-reward history.
abstract interface class RewardsRepository {
  /// The saved wallet, or an empty one if none exists (or it is unreadable).
  Wallet loadWallet();

  /// Saves [wallet].
  Future<Result<void>> saveWallet(Wallet wallet);

  /// The saved daily-reward history, or an empty one.
  DailyRewardRecord loadDailyReward();

  /// Saves a daily claim: the updated [record] and the credited [wallet].
  ///
  /// The record is written first, so an interrupted write can never let
  /// the same day be claimed twice.
  Future<Result<void>> saveDailyClaim({
    required DailyRewardRecord record,
    required Wallet wallet,
  });
}
