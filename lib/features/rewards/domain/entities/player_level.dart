import 'dart:math' as math;

import 'package:flutter/foundation.dart';

/// Rank titles, unlocked as the player levels up.
enum PlayerRank {
  /// Levels 1–4.
  rookie('Rookie', 1),

  /// Levels 5–9.
  cadet('Cadet', 5),

  /// Levels 10–19.
  striker('Striker', 10),

  /// Levels 20–34.
  ace('Ace', 20),

  /// Levels 35–49.
  champion('Champion', 35),

  /// Level 50 and above.
  legend('Legend', 50);

  const PlayerRank(this.label, this.minLevel);

  /// Player-facing title.
  final String label;

  /// First level with this rank.
  final int minLevel;

  /// The rank held at [level].
  static PlayerRank forLevel(int level) =>
      values.lastWhere((rank) => level >= rank.minLevel);
}

/// The player's level, derived from lifetime experience.
///
/// Each level needs 50 XP more than the previous one: 100 XP from level 1
/// to 2, 150 from 2 to 3, and so on, up to [maxLevel].
@immutable
final class PlayerLevel {
  const PlayerLevel._({
    required this.level,
    required this.xpIntoLevel,
    required this.xpForNextLevel,
  });

  /// Computes the level reached with [totalXp].
  factory PlayerLevel.fromXp(int totalXp) {
    var level = 1;
    var remaining = math.max(0, totalXp);
    while (level < maxLevel && remaining >= xpToAdvance(level)) {
      remaining -= xpToAdvance(level);
      level++;
    }
    return PlayerLevel._(
      level: level,
      xpIntoLevel: level == maxLevel ? 0 : remaining,
      xpForNextLevel: level == maxLevel ? 0 : xpToAdvance(level),
    );
  }

  /// Highest reachable level.
  static const int maxLevel = 100;

  /// XP needed to go from [level] to the next one.
  static int xpToAdvance(int level) => 100 + (level - 1) * 50;

  /// Current level, 1–[maxLevel].
  final int level;

  /// XP earned since reaching [level].
  final int xpIntoLevel;

  /// XP needed to reach the next level (0 at [maxLevel]).
  final int xpForNextLevel;

  /// Whether the top level has been reached.
  bool get isMax => level == maxLevel;

  /// Progress towards the next level, 0–1 (1 at [maxLevel]).
  double get progress => isMax ? 1 : xpIntoLevel / xpForNextLevel;

  /// The rank title for [level].
  PlayerRank get rank => PlayerRank.forLevel(level);

  @override
  bool operator ==(Object other) =>
      other is PlayerLevel &&
      other.level == level &&
      other.xpIntoLevel == xpIntoLevel;

  @override
  int get hashCode => Object.hash(level, xpIntoLevel);

  @override
  String toString() => 'PlayerLevel($level, $xpIntoLevel/$xpForNextLevel)';
}
