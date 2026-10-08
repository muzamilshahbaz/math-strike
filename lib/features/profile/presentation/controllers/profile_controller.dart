import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/player_profile.dart';
import '../../profile_providers.dart';

part 'profile_controller.g.dart';

/// The local player's profile, or `null` before onboarding.
///
/// Requires an opened database: only read it after start-up completes.
@Riverpod(keepAlive: true)
class ProfileController extends _$ProfileController {
  @override
  PlayerProfile? build() {
    // Reload when local data is replaced (restore / reset).
    ref.watch(localDataEpochProvider);
    return ref.watch(profileRepositoryProvider).load();
  }

  /// Saves [profile] and publishes it on success.
  Future<Result<void>> save(PlayerProfile profile) async {
    final result = await ref.read(profileRepositoryProvider).save(profile);
    if (result.isSuccess && ref.mounted) state = profile;
    return result;
  }
}
