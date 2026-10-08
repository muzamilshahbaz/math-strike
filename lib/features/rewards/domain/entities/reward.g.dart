// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reward.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reward _$RewardFromJson(Map<String, dynamic> json) => _Reward(
  coins: (json['coins'] as num?)?.toInt() ?? 0,
  diamonds: (json['diamonds'] as num?)?.toInt() ?? 0,
  xp: (json['xp'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RewardToJson(_Reward instance) => <String, dynamic>{
  'coins': instance.coins,
  'diamonds': instance.diamonds,
  'xp': instance.xp,
};
