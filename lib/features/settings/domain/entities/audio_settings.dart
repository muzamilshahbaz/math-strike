import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_settings.freezed.dart';
part 'audio_settings.g.dart';

/// Sound-effect and music preferences. Chosen during onboarding, editable
/// in Settings (Phase 11), consumed by the audio engine (Phase 8).
@freezed
abstract class AudioSettings with _$AudioSettings {
  /// Creates settings; everything is on by default.
  const factory AudioSettings({
    @Default(true) bool soundEnabled,
    @Default(true) bool musicEnabled,

    /// Sound-effect volume, 0.0–1.0.
    @Default(0.8) double soundVolume,

    /// Music volume, 0.0–1.0.
    @Default(0.6) double musicVolume,
  }) = _AudioSettings;

  /// Deserialises settings.
  factory AudioSettings.fromJson(Map<String, dynamic> json) =>
      _$AudioSettingsFromJson(json);
}
