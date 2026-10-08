import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/calendar_day.dart';
import 'reward.dart';

part 'daily_reward.freezed.dart';
part 'daily_reward.g.dart';

/// The persisted daily-reward history.
@freezed
abstract class DailyRewardRecord with _$DailyRewardRecord {
  /// Creates a record.
  const factory DailyRewardRecord({
    /// The last day a reward was claimed, or `null` if never.
    @CalendarDayConverter() CalendarDay? lastClaimDay,

    /// Consecutive days claimed, ending on [lastClaimDay].
    @Default(0) int streak,

    /// Longest streak ever reached.
    @Default(0) int longestStreak,

    /// Total rewards ever claimed.
    @Default(0) int totalClaims,
  }) = _DailyRewardRecord;

  /// Deserialises a record.
  factory DailyRewardRecord.fromJson(Map<String, dynamic> json) =>
      _$DailyRewardRecordFromJson(json);
}

/// Where the player stands in the daily-reward cycle today.
@freezed
abstract class DailyRewardStatus with _$DailyRewardStatus {
  /// Creates a status.
  const factory DailyRewardStatus({
    /// Whether today's reward is waiting to be claimed.
    required bool canClaim,

    /// Current unbroken streak (0 once a day has been missed).
    required int streak,

    /// Day of the cycle (1-based) to highlight: the one claimable today, or
    /// the one already claimed today.
    required int cycleDay,

    /// Rewards for each day of the cycle.
    required List<Reward> cycle,

    /// Whether a previous streak was lost by missing a day.
    @Default(false) bool streakLost,

    /// Longest streak ever reached.
    @Default(0) int longestStreak,
  }) = _DailyRewardStatus;

  const DailyRewardStatus._();

  /// Today's reward (claimable or already claimed).
  Reward get todaysReward => cycle[cycleDay - 1];

  /// Tomorrow's reward, once today's is claimed.
  Reward get nextReward => cycle[cycleDay % cycle.length];

  /// Whether [day] (1-based) of the cycle has been claimed.
  bool isClaimed(int day) => canClaim ? day < cycleDay : day <= cycleDay;
}

/// The result of claiming a daily reward.
@freezed
abstract class DailyRewardClaim with _$DailyRewardClaim {
  /// Creates a claim.
  const factory DailyRewardClaim({
    /// What was granted.
    required Reward reward,

    /// The record to persist.
    required DailyRewardRecord record,

    /// Day of the cycle (1-based) that was claimed.
    required int cycleDay,
  }) = _DailyRewardClaim;
}

/// Pure rules of the daily-reward cycle.
///
/// One reward can be claimed per local calendar day. Claiming on
/// consecutive days builds a streak that walks through [cycle]; after the
/// last day the cycle starts over while the streak keeps counting. Missing a
/// day resets the streak to day 1.
///
/// If the device clock moves backwards past the last claim, nothing is
/// claimable until that day has passed again, so changing the clock cannot
/// grant repeated rewards.
final class DailyRewardSchedule {
  /// Creates a schedule over a non-empty [cycle].
  const DailyRewardSchedule(this.cycle);

  /// The standard 7-day cycle, ending in a treasure chest.
  static const DailyRewardSchedule standard = DailyRewardSchedule([
    Reward(coins: 50),
    Reward(coins: 75),
    Reward(coins: 100, xp: 25),
    Reward(coins: 125),
    Reward(coins: 150, diamonds: 1),
    Reward(coins: 200, xp: 50),
    Reward(coins: 300, diamonds: 3, xp: 100),
  ]);

  /// Rewards for each day, in order.
  final List<Reward> cycle;

  /// The cycle day (1-based) reached by the [streak]th consecutive claim.
  int dayInCycle(int streak) => (streak - 1) % cycle.length + 1;

  /// The status of [record] on [today].
  DailyRewardStatus statusFor(DailyRewardRecord record, CalendarDay today) {
    final last = record.lastClaimDay;
    final gap = last == null ? null : today.daysSince(last);

    if (gap != null && gap <= 0) {
      // Claimed today (or the clock was moved back).
      return DailyRewardStatus(
        canClaim: false,
        streak: record.streak,
        cycleDay: dayInCycle(math.max(1, record.streak)),
        cycle: cycle,
        longestStreak: record.longestStreak,
      );
    }
    final continues = gap == 1;
    final nextStreak = continues ? record.streak + 1 : 1;
    return DailyRewardStatus(
      canClaim: true,
      streak: continues ? record.streak : 0,
      cycleDay: dayInCycle(nextStreak),
      cycle: cycle,
      streakLost: !continues && record.streak > 0,
      longestStreak: record.longestStreak,
    );
  }

  /// Claims [today]'s reward, or returns `null` if it is not claimable.
  DailyRewardClaim? claim(DailyRewardRecord record, CalendarDay today) {
    final status = statusFor(record, today);
    if (!status.canClaim) return null;
    final streak = status.streak + 1;
    return DailyRewardClaim(
      reward: status.todaysReward,
      cycleDay: status.cycleDay,
      record: DailyRewardRecord(
        lastClaimDay: today,
        streak: streak,
        longestStreak: math.max(record.longestStreak, streak),
        totalClaims: record.totalClaims + 1,
      ),
    );
  }
}
