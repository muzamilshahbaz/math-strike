import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/key_value_store.dart';
import '../../domain/entities/audio_settings.dart';
import '../../domain/repositories/audio_settings_repository.dart';

/// [AudioSettingsRepository] backed by the encrypted `settings` box.
final class AudioSettingsRepositoryImpl implements AudioSettingsRepository {
  /// Creates the repository.
  const AudioSettingsRepositoryImpl({
    required this._store,
    required this._logger,
  });

  final KeyValueStore _store;
  final AppLogger _logger;

  @override
  AudioSettings load() {
    try {
      final json = _store.readJson(SettingsKeys.audio);
      return json == null
          ? const AudioSettings()
          : AudioSettings.fromJson(json);
    } on Object catch (e, st) {
      _logger.warning(
        'Audio settings unreadable; using defaults',
        error: e,
        stackTrace: st,
      );
      return const AudioSettings();
    }
  }

  @override
  Future<Result<void>> save(AudioSettings settings) => Result.guard(
    () => _store.writeJson(SettingsKeys.audio, settings.toJson()),
  );
}
