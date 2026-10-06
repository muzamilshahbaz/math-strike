// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appearance_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppearanceSettings _$AppearanceSettingsFromJson(Map<String, dynamic> json) =>
    _AppearanceSettings(
      themeMode:
          $enumDecodeNullable(
            _$ThemeModeEnumMap,
            json['themeMode'],
            unknownValue: ThemeMode.system,
          ) ??
          ThemeMode.system,
      gameTheme:
          $enumDecodeNullable(
            _$GameThemeIdEnumMap,
            json['gameTheme'],
            unknownValue: GameThemeId.space,
          ) ??
          GameThemeId.space,
      highContrast: json['highContrast'] as bool? ?? false,
      reduceMotion: json['reduceMotion'] as bool? ?? false,
      textScale: (json['textScale'] as num?)?.toDouble() ?? 1.0,
    );

Map<String, dynamic> _$AppearanceSettingsToJson(_AppearanceSettings instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'gameTheme': _$GameThemeIdEnumMap[instance.gameTheme]!,
      'highContrast': instance.highContrast,
      'reduceMotion': instance.reduceMotion,
      'textScale': instance.textScale,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};

const _$GameThemeIdEnumMap = {
  GameThemeId.space: 'space',
  GameThemeId.forest: 'forest',
  GameThemeId.ocean: 'ocean',
  GameThemeId.desert: 'desert',
  GameThemeId.cyberpunk: 'cyberpunk',
  GameThemeId.school: 'school',
  GameThemeId.candy: 'candy',
  GameThemeId.galaxy: 'galaxy',
  GameThemeId.ancient: 'ancient',
  GameThemeId.neon: 'neon',
};
