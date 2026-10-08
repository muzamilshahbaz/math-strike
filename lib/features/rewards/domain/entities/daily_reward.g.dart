// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DailyRewardRecord _$DailyRewardRecordFromJson(Map<String, dynamic> json) =>
    _DailyRewardRecord(
      lastClaimDay: _$JsonConverterFromJson<String, CalendarDay>(
        json['lastClaimDay'],
        const CalendarDayConverter().fromJson,
      ),
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      longestStreak: (json['longestStreak'] as num?)?.toInt() ?? 0,
      totalClaims: (json['totalClaims'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DailyRewardRecordToJson(_DailyRewardRecord instance) =>
    <String, dynamic>{
      'lastClaimDay': ?_$JsonConverterToJson<String, CalendarDay>(
        instance.lastClaimDay,
        const CalendarDayConverter().toJson,
      ),
      'streak': instance.streak,
      'longestStreak': instance.longestStreak,
      'totalClaims': instance.totalClaims,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
