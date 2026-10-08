// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StatTotals _$StatTotalsFromJson(Map<String, dynamic> json) => _StatTotals(
  gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
  questionsAnswered: (json['questionsAnswered'] as num?)?.toInt() ?? 0,
  correctAnswers: (json['correctAnswers'] as num?)?.toInt() ?? 0,
  timePlayedMs: (json['timePlayedMs'] as num?)?.toInt() ?? 0,
  reactionTimeMs: (json['reactionTimeMs'] as num?)?.toInt() ?? 0,
  levelsCompleted: (json['levelsCompleted'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$StatTotalsToJson(_StatTotals instance) =>
    <String, dynamic>{
      'gamesPlayed': instance.gamesPlayed,
      'questionsAnswered': instance.questionsAnswered,
      'correctAnswers': instance.correctAnswers,
      'timePlayedMs': instance.timePlayedMs,
      'reactionTimeMs': instance.reactionTimeMs,
      'levelsCompleted': instance.levelsCompleted,
    };

_PlayerStatistics _$PlayerStatisticsFromJson(Map<String, dynamic> json) =>
    _PlayerStatistics(
      overall: json['overall'] == null
          ? const StatTotals()
          : StatTotals.fromJson(json['overall'] as Map<String, dynamic>),
      days:
          (json['days'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, StatTotals.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, StatTotals>{},
      bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
      highestCombo: (json['highestCombo'] as num?)?.toInt() ?? 0,
      lastPlayedAt: json['lastPlayedAt'] == null
          ? null
          : DateTime.parse(json['lastPlayedAt'] as String),
    );

Map<String, dynamic> _$PlayerStatisticsToJson(_PlayerStatistics instance) =>
    <String, dynamic>{
      'overall': instance.overall.toJson(),
      'days': instance.days.map((k, e) => MapEntry(k, e.toJson())),
      'bestStreak': instance.bestStreak,
      'highestCombo': instance.highestCombo,
      'lastPlayedAt': ?instance.lastPlayedAt?.toIso8601String(),
    };
