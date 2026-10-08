import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/features/rewards/domain/entities/player_level.dart';
import 'package:math_strike/features/rewards/domain/entities/reward.dart';
import 'package:math_strike/features/rewards/domain/entities/wallet.dart';

void main() {
  test('a new player is a level 1 Rookie', () {
    final level = PlayerLevel.fromXp(0);

    expect(level.level, 1);
    expect(level.xpIntoLevel, 0);
    expect(level.xpForNextLevel, 100);
    expect(level.progress, 0);
    expect(level.rank, PlayerRank.rookie);
  });

  test('each level costs 50 XP more than the last', () {
    expect(PlayerLevel.fromXp(99).level, 1);
    expect(PlayerLevel.fromXp(100).level, 2);
    expect(PlayerLevel.fromXp(100).xpForNextLevel, 150);
    expect(PlayerLevel.fromXp(249).level, 2);
    expect(PlayerLevel.fromXp(250).level, 3);
    expect(PlayerLevel.fromXp(300).xpIntoLevel, 50);
    expect(PlayerLevel.fromXp(300).progress, closeTo(0.25, 1e-9));
  });

  test('levels stop at the maximum', () {
    final top = PlayerLevel.fromXp(1 << 30);

    expect(top.level, PlayerLevel.maxLevel);
    expect(top.isMax, isTrue);
    expect(top.progress, 1);
    expect(top.rank, PlayerRank.legend);
  });

  test('negative XP is treated as zero', () {
    expect(PlayerLevel.fromXp(-50), PlayerLevel.fromXp(0));
  });

  test('ranks follow level bands', () {
    expect(PlayerRank.forLevel(4), PlayerRank.rookie);
    expect(PlayerRank.forLevel(5), PlayerRank.cadet);
    expect(PlayerRank.forLevel(19), PlayerRank.striker);
    expect(PlayerRank.forLevel(20), PlayerRank.ace);
    expect(PlayerRank.forLevel(49), PlayerRank.champion);
    expect(PlayerRank.forLevel(50), PlayerRank.legend);
  });

  test('wallet credits rewards and derives the level from XP', () {
    final wallet = const Wallet(coins: 10)
        .credit(const Reward(coins: 40, diamonds: 2, xp: 120));

    expect(wallet, const Wallet(coins: 50, diamonds: 2, xp: 120));
    expect(wallet.level.level, 2);
  });
}
