// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlayerProfile _$PlayerProfileFromJson(Map<String, dynamic> json) =>
    _PlayerProfile(
      name: json['name'] as String,
      avatarId: json['avatarId'] as String,
      ageGroup: $enumDecode(
        _$AgeGroupEnumMap,
        json['ageGroup'],
        unknownValue: AgeGroup.custom,
      ),
      difficulty: $enumDecode(
        _$DifficultyEnumMap,
        json['difficulty'],
        unknownValue: Difficulty.medium,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PlayerProfileToJson(_PlayerProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'avatarId': instance.avatarId,
      'ageGroup': _$AgeGroupEnumMap[instance.ageGroup]!,
      'difficulty': _$DifficultyEnumMap[instance.difficulty]!,
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$AgeGroupEnumMap = {
  AgeGroup.preschool: 'preschool',
  AgeGroup.earlyPrimary: 'earlyPrimary',
  AgeGroup.latePrimary: 'latePrimary',
  AgeGroup.teen: 'teen',
  AgeGroup.adult: 'adult',
  AgeGroup.custom: 'custom',
};

const _$DifficultyEnumMap = {
  Difficulty.easy: 'easy',
  Difficulty.medium: 'medium',
  Difficulty.hard: 'hard',
  Difficulty.expert: 'expert',
};
