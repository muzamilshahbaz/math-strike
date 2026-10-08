import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/key_value_store.dart';
import '../../domain/entities/player_statistics.dart';
import '../../domain/repositories/statistics_repository.dart';

/// [StatisticsRepository] stored in the backed-up `statistics` box.
final class StatisticsRepositoryImpl implements StatisticsRepository {
  /// Creates the repository.
  const StatisticsRepositoryImpl({required this._store, required this._logger});

  final KeyValueStore _store;
  final AppLogger _logger;

  @override
  PlayerStatistics load() {
    try {
      final json = _store.readJson(StatisticsKeys.player);
      return json == null
          ? const PlayerStatistics()
          : PlayerStatistics.fromJson(json);
    } on Object catch (e, st) {
      _logger.warning(
        'Statistics unreadable; starting fresh',
        error: e,
        stackTrace: st,
      );
      return const PlayerStatistics();
    }
  }

  @override
  Future<Result<void>> save(PlayerStatistics statistics) => Result.guard(
    () => _store.writeJson(StatisticsKeys.player, statistics.toJson()),
  );
}
