import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/key_value_store.dart';
import '../../domain/entities/daily_reward.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/rewards_repository.dart';

/// [RewardsRepository] stored in the backed-up `rewards` box.
final class RewardsRepositoryImpl implements RewardsRepository {
  /// Creates the repository.
  const RewardsRepositoryImpl({required this._store, required this._logger});

  final KeyValueStore _store;
  final AppLogger _logger;

  @override
  Wallet loadWallet() =>
      _read(RewardsKeys.wallet, Wallet.fromJson) ?? const Wallet();

  @override
  Future<Result<void>> saveWallet(Wallet wallet) =>
      Result.guard(() => _store.writeJson(RewardsKeys.wallet, wallet.toJson()));

  @override
  DailyRewardRecord loadDailyReward() =>
      _read(RewardsKeys.dailyReward, DailyRewardRecord.fromJson) ??
      const DailyRewardRecord();

  @override
  Future<Result<void>> saveDailyClaim({
    required DailyRewardRecord record,
    required Wallet wallet,
  }) => Result.guard(() async {
    await _store.writeJson(RewardsKeys.dailyReward, record.toJson());
    await _store.writeJson(RewardsKeys.wallet, wallet.toJson());
  });

  /// Reads and decodes [key]; unreadable data is logged and treated as
  /// absent, so a corrupt entry never blocks the game.
  T? _read<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    try {
      final json = _store.readJson(key);
      return json == null ? null : fromJson(json);
    } on Object catch (e, st) {
      _logger.warning('Rewards "$key" unreadable', error: e, stackTrace: st);
      return null;
    }
  }
}
