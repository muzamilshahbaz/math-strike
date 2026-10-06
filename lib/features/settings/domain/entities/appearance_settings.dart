import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/theme/game_theme_id.dart';

part 'appearance_settings.freezed.dart';
part 'appearance_settings.g.dart';

/// Visual and accessibility preferences.
///
/// Serialised to JSON in the local database and included in Drive backups.
@freezed
abstract class AppearanceSettings with _$AppearanceSettings {
  /// Creates settings; every field has a sensible default.
  const factory AppearanceSettings({
    /// Light / dark / follow system ("Auto").
    @JsonKey(unknownEnumValue: ThemeMode.system)
    @Default(ThemeMode.system)
    ThemeMode themeMode,

    /// Active visual theme.
    @JsonKey(unknownEnumValue: GameThemeId.space)
    @Default(GameThemeId.space)
    GameThemeId gameTheme,

    /// Maximum-contrast colour scheme.
    @Default(false) bool highContrast,

    /// Minimise animations, particles and screen shake.
    @Default(false) bool reduceMotion,

    /// Multiplier applied on top of the system text size.
    @Default(1.0) double textScale,
  }) = _AppearanceSettings;

  /// Deserialises settings; unknown enum values fall back to defaults.
  factory AppearanceSettings.fromJson(Map<String, dynamic> json) =>
      _$AppearanceSettingsFromJson(json);

  /// Allowed range for [AppearanceSettings.textScale].
  static const double minTextScale = 0.85;

  /// Allowed range for [AppearanceSettings.textScale].
  static const double maxTextScale = 1.6;
}
