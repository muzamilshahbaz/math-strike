import '../../../../core/errors/result.dart';
import '../entities/audio_settings.dart';

/// Persists [AudioSettings].
abstract interface class AudioSettingsRepository {
  /// Saved settings, or defaults if none are saved or they are unreadable.
  AudioSettings load();

  /// Persists [settings].
  Future<Result<void>> save(AudioSettings settings);
}
