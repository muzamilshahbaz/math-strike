import '../../../../core/errors/result.dart';
import '../entities/player_profile.dart';

/// Persists the local [PlayerProfile].
abstract interface class ProfileRepository {
  /// The saved profile, or `null` if none exists (or it is unreadable).
  PlayerProfile? load();

  /// Saves [profile].
  Future<Result<void>> save(PlayerProfile profile);
}
