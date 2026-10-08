@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/core/utils/calendar_day.dart';
import 'package:math_strike/features/rewards/domain/entities/daily_reward.dart';
import 'package:math_strike/features/rewards/domain/entities/wallet.dart';
import 'package:math_strike/features/statistics/domain/entities/game_session_summary.dart';
import 'package:math_strike/features/statistics/domain/entities/player_statistics.dart';

import '../helpers/fake_clock.dart';
import '../helpers/golden_fonts.dart';
import '../helpers/test_app.dart';

void main() {
  setUpAll(loadGoldenFonts);

  const today = CalendarDay(2026, 10, 9);

  /// A player a few days into the game: a 2-day reward streak, some coins
  /// and a week of statistics.
  Future<InMemoryLocalDatabase> seasonedPlayer() async {
    final db = InMemoryLocalDatabase();
    final rewards = db.store(StorageBox.rewards);
    await rewards.writeJson(
      RewardsKeys.wallet,
      const Wallet(coins: 1250, diamonds: 4, xp: 610).toJson(),
    );
    await rewards.writeJson(
      RewardsKeys.dailyReward,
      DailyRewardRecord(lastClaimDay: today.addDays(-1), streak: 2).toJson(),
    );
    var stats = const PlayerStatistics();
    for (final (daysAgo, questions, correct) in const [
      (6, 24, 19),
      (5, 30, 25),
      (3, 18, 16),
      (2, 36, 31),
      (1, 28, 26),
      (0, 14, 12),
    ]) {
      stats = stats.record(
        GameSessionSummary(
          endedAt: DateTime(2026, 10, 9 - daysAgo, 17),
          duration: Duration(minutes: questions ~/ 3),
          questionsAnswered: questions,
          correctAnswers: correct,
          totalReactionTime: Duration(milliseconds: questions * 2100),
          bestStreak: correct ~/ 2,
          highestCombo: correct ~/ 4,
        ),
        today.addDays(-daysAgo),
      );
    }
    await db
        .store(StorageBox.statistics)
        .writeJson(StatisticsKeys.player, stats.toJson());
    return db;
  }

  Future<void> pump(WidgetTester tester, Size size) async {
    await tester.pumpMathStrikeApp(
      database: await seasonedPlayer(),
      size: size,
      overrides: [FakeClock(DateTime(2026, 10, 9, 18, 30)).override],
    );
  }

  Future<void> snapshot(WidgetTester tester, String name) async {
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MathStrikeApp),
      matchesGoldenFile('goldens/$name.png'),
    );
  }

  testWidgets('home dashboard (phone)', (tester) async {
    await pump(tester, const Size(400, 900));
    await snapshot(tester, 'home_phone');
  });

  testWidgets('home dashboard (desktop)', (tester) async {
    await pump(tester, const Size(1440, 900));
    await snapshot(tester, 'home_desktop');
  });

  testWidgets('daily reward sheet', (tester) async {
    await pump(tester, const Size(400, 900));
    await tester.tap(find.text('Claim'));
    await snapshot(tester, 'daily_reward_sheet_phone');
  });

  testWidgets('progress tab', (tester) async {
    await pump(tester, const Size(400, 900));
    await tester.tap(find.text('Progress').last);
    await snapshot(tester, 'progress_phone');
  });
}
