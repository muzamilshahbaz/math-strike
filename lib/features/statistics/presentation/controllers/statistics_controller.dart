import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/utils/calendar_day.dart';
import '../../domain/entities/game_session_summary.dart';
import '../../domain/entities/player_statistics.dart';
import '../../statistics_providers.dart';

part 'statistics_controller.g.dart';

/// The player's [PlayerStatistics].
///
/// Requires an opened database: only read it after start-up completes.
@Riverpod(keepAlive: true)
class StatisticsController extends _$StatisticsController {
  @override
  PlayerStatistics build() {
    // Reload when local data is replaced (restore / reset).
    ref.watch(localDataEpochProvider);
    return ref.watch(statisticsRepositoryProvider).load();
  }

  /// Adds a finished game to the statistics and saves them.
  Future<Result<void>> recordSession(GameSessionSummary session) async {
    final updated = state.record(
      session,
      CalendarDay.fromDateTime(session.endedAt.toLocal()),
    );
    final result = await ref.read(statisticsRepositoryProvider).save(updated);
    if (result.isSuccess && ref.mounted) state = updated;
    return result;
  }
}

/// Totals for [period], ending today.
@riverpod
StatTotals periodTotals(Ref ref, StatisticsPeriod period) => ref
    .watch(statisticsControllerProvider)
    .totalsFor(period, ref.watch(currentDayProvider));

/// Per-day totals for the last [days] days, oldest first.
@riverpod
List<(CalendarDay, StatTotals)> activityHistory(Ref ref, int days) => ref
    .watch(statisticsControllerProvider)
    .history(ref.watch(currentDayProvider), days);
