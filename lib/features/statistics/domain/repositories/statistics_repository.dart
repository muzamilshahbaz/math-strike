import '../../../../core/errors/result.dart';
import '../entities/player_statistics.dart';

/// Persists the player's [PlayerStatistics].
abstract interface class StatisticsRepository {
  /// The saved statistics, or empty ones if none exist (or are unreadable).
  PlayerStatistics load();

  /// Saves [statistics].
  Future<Result<void>> save(PlayerStatistics statistics);
}
