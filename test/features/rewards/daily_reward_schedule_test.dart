import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/utils/calendar_day.dart';
import 'package:math_strike/features/rewards/domain/entities/daily_reward.dart';
import 'package:math_strike/features/rewards/domain/entities/reward.dart';

void main() {
  const schedule = DailyRewardSchedule.standard;
  const day1 = CalendarDay(2026, 10, 1);

  /// Claims on each of [days] in turn, starting from an empty record.
  DailyRewardRecord claimOn(Iterable<CalendarDay> days) {
    var record = const DailyRewardRecord();
    for (final day in days) {
      record = schedule.claim(record, day)!.record;
    }
    return record;
  }

  List<CalendarDay> consecutive(int count) => [
    for (var i = 0; i < count; i++) day1.addDays(i),
  ];

  test('a new player can claim day 1', () {
    final status = schedule.statusFor(const DailyRewardRecord(), day1);

    expect(status.canClaim, isTrue);
    expect(status.cycleDay, 1);
    expect(status.streak, 0);
    expect(status.streakLost, isFalse);
    expect(status.todaysReward, const Reward(coins: 50));
  });

  test('claiming grants the reward and records the day', () {
    final claim = schedule.claim(const DailyRewardRecord(), day1)!;

    expect(claim.reward, const Reward(coins: 50));
    expect(claim.cycleDay, 1);
    expect(claim.record.lastClaimDay, day1);
    expect(claim.record.streak, 1);
    expect(claim.record.longestStreak, 1);
    expect(claim.record.totalClaims, 1);
  });

  test('only one claim per day', () {
    final record = claimOn([day1]);
    final status = schedule.statusFor(record, day1);

    expect(status.canClaim, isFalse);
    expect(status.cycleDay, 1);
    expect(status.isClaimed(1), isTrue);
    expect(status.nextReward, const Reward(coins: 75));
    expect(schedule.claim(record, day1), isNull);
  });

  test('claiming on consecutive days walks through the cycle', () {
    final record = claimOn(consecutive(3));
    final status = schedule.statusFor(record, day1.addDays(3));

    expect(status.canClaim, isTrue);
    expect(status.streak, 3);
    expect(status.cycleDay, 4);
    expect(
      [for (var d = 1; d <= 7; d++) status.isClaimed(d)],
      [true, true, true, false, false, false, false],
    );
  });

  test('missing a day resets the streak to day 1', () {
    final record = claimOn(consecutive(4));
    final status = schedule.statusFor(record, day1.addDays(5));

    expect(status.canClaim, isTrue);
    expect(status.streak, 0);
    expect(status.cycleDay, 1);
    expect(status.streakLost, isTrue);

    final claim = schedule.claim(record, day1.addDays(5))!;
    expect(claim.record.streak, 1);
    expect(claim.record.longestStreak, 4, reason: 'longest is kept');
  });

  test('day 7 is the treasure chest, then the cycle restarts', () {
    final week = claimOn(consecutive(7));
    expect(schedule.statusFor(week, day1.addDays(6)).cycleDay, 7);
    expect(
      schedule.statusFor(week, day1.addDays(6)).todaysReward,
      const Reward(coins: 300, diamonds: 3, xp: 100),
    );

    final eighth = schedule.statusFor(week, day1.addDays(7));
    expect(eighth.cycleDay, 1);
    expect(eighth.streak, 7, reason: 'the streak keeps counting');
    expect(schedule.claim(week, day1.addDays(7))!.record.streak, 8);
  });

  test('moving the clock back never grants extra rewards', () {
    final record = claimOn([day1.addDays(5)]);

    expect(schedule.statusFor(record, day1).canClaim, isFalse);
    expect(schedule.claim(record, day1), isNull);
    expect(schedule.statusFor(record, day1.addDays(6)).canClaim, isTrue);
  });

  test('reward amounts grow through the week', () {
    final coins = [for (final r in schedule.cycle) r.coins];
    expect(coins, orderedEquals([...coins]..sort()));
    expect(schedule.cycle, hasLength(7));
  });
}
