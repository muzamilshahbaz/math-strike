// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The audio settings repository, bound to its implementation.

@ProviderFor(audioSettingsRepository)
final audioSettingsRepositoryProvider = AudioSettingsRepositoryProvider._();

/// The audio settings repository, bound to its implementation.

final class AudioSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AudioSettingsRepository,
          AudioSettingsRepository,
          AudioSettingsRepository
        >
    with $Provider<AudioSettingsRepository> {
  /// The audio settings repository, bound to its implementation.
  AudioSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AudioSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AudioSettingsRepository create(Ref ref) {
    return audioSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioSettingsRepository>(value),
    );
  }
}

String _$audioSettingsRepositoryHash() =>
    r'ef21fb8b988138ba5413b82e99f68a1cc7d2c930';

/// The appearance repository, bound to its implementation.

@ProviderFor(appearanceRepository)
final appearanceRepositoryProvider = AppearanceRepositoryProvider._();

/// The appearance repository, bound to its implementation.

final class AppearanceRepositoryProvider
    extends
        $FunctionalProvider<
          AppearanceRepository,
          AppearanceRepository,
          AppearanceRepository
        >
    with $Provider<AppearanceRepository> {
  /// The appearance repository, bound to its implementation.
  AppearanceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appearanceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appearanceRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppearanceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppearanceRepository create(Ref ref) {
    return appearanceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppearanceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppearanceRepository>(value),
    );
  }
}

String _$appearanceRepositoryHash() =>
    r'80ff874a9be5d753df79b3847a6ef137d2c8697c';
