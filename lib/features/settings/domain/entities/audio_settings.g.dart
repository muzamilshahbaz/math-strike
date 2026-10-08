// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AudioSettings _$AudioSettingsFromJson(Map<String, dynamic> json) =>
    _AudioSettings(
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      soundVolume: (json['soundVolume'] as num?)?.toDouble() ?? 0.8,
      musicVolume: (json['musicVolume'] as num?)?.toDouble() ?? 0.6,
    );

Map<String, dynamic> _$AudioSettingsToJson(_AudioSettings instance) =>
    <String, dynamic>{
      'soundEnabled': instance.soundEnabled,
      'musicEnabled': instance.musicEnabled,
      'soundVolume': instance.soundVolume,
      'musicVolume': instance.musicVolume,
    };
