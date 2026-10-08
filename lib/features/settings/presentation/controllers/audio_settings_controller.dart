import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/audio_settings.dart';
import '../../settings_providers.dart';

part 'audio_settings_controller.g.dart';

/// Holds the current [AudioSettings] and persists every change.
@Riverpod(keepAlive: true)
class AudioSettingsController extends _$AudioSettingsController {
  @override
  AudioSettings build() {
    ref.watch(localDataEpochProvider);
    return ref.watch(audioSettingsRepositoryProvider).load();
  }

  /// Replaces all audio settings at once (used by onboarding).
  Future<Result<void>> save(AudioSettings settings) async {
    final result = await ref
        .read(audioSettingsRepositoryProvider)
        .save(settings);
    if (result.isSuccess && ref.mounted) state = settings;
    return result;
  }
}
