import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/key_value_store.dart';
import '../../domain/entities/appearance_settings.dart';
import '../../domain/repositories/appearance_repository.dart';

/// [AppearanceRepository] backed by the encrypted `settings` box.
final class AppearanceRepositoryImpl implements AppearanceRepository {
  /// Creates the repository.
  const AppearanceRepositoryImpl({required this._store, required this._logger});

  final KeyValueStore _store;
  final AppLogger _logger;

  @override
  AppearanceSettings load() {
    try {
      final json = _store.readJson(SettingsKeys.appearance);
      return json == null
          ? const AppearanceSettings()
          : AppearanceSettings.fromJson(json);
    } on Object catch (e, st) {
      // Corrupt settings must never block start-up.
      _logger.warning(
        'Appearance settings unreadable; using defaults',
        error: e,
        stackTrace: st,
      );
      return const AppearanceSettings();
    }
  }

  @override
  Future<Result<void>> save(AppearanceSettings settings) => Result.guard(
    () => _store.writeJson(SettingsKeys.appearance, settings.toJson()),
  );
}
