// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the current [AudioSettings] and persists every change.

@ProviderFor(AudioSettingsController)
final audioSettingsControllerProvider = AudioSettingsControllerProvider._();

/// Holds the current [AudioSettings] and persists every change.
final class AudioSettingsControllerProvider
    extends $NotifierProvider<AudioSettingsController, AudioSettings> {
  /// Holds the current [AudioSettings] and persists every change.
  AudioSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioSettingsControllerHash();

  @$internal
  @override
  AudioSettingsController create() => AudioSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioSettings>(value),
    );
  }
}

String _$audioSettingsControllerHash() =>
    r'523b6b94b5c0338fe2d50513dfd8c2ea10c1827e';

/// Holds the current [AudioSettings] and persists every change.

abstract class _$AudioSettingsController extends $Notifier<AudioSettings> {
  AudioSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AudioSettings, AudioSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AudioSettings, AudioSettings>,
              AudioSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
