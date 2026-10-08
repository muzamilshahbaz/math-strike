import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/logging/app_logger.dart';
import '../../../../core/services/storage/key_value_store.dart';
import '../../domain/entities/player_profile.dart';
import '../../domain/repositories/profile_repository.dart';

/// [ProfileRepository] stored in the backed-up `profile` box.
final class ProfileRepositoryImpl implements ProfileRepository {
  /// Creates the repository.
  const ProfileRepositoryImpl({required this._store, required this._logger});

  final KeyValueStore _store;
  final AppLogger _logger;

  @override
  PlayerProfile? load() {
    try {
      final json = _store.readJson(ProfileKeys.player);
      return json == null ? null : PlayerProfile.fromJson(json);
    } on Object catch (e, st) {
      // Unreadable profile: onboarding runs again rather than crashing.
      _logger.warning('Player profile unreadable', error: e, stackTrace: st);
      return null;
    }
  }

  @override
  Future<Result<void>> save(PlayerProfile profile) => Result.guard(
    () => _store.writeJson(ProfileKeys.player, profile.toJson()),
  );
}
