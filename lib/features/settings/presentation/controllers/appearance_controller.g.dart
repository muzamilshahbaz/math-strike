// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appearance_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Holds the current [AppearanceSettings] and persists every change.
///
/// Updates are optimistic: the UI changes immediately and reverts if the
/// write fails.

@ProviderFor(AppearanceController)
final appearanceControllerProvider = AppearanceControllerProvider._();

/// Holds the current [AppearanceSettings] and persists every change.
///
/// Updates are optimistic: the UI changes immediately and reverts if the
/// write fails.
final class AppearanceControllerProvider
    extends $NotifierProvider<AppearanceController, AppearanceSettings> {
  /// Holds the current [AppearanceSettings] and persists every change.
  ///
  /// Updates are optimistic: the UI changes immediately and reverts if the
  /// write fails.
  AppearanceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appearanceControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appearanceControllerHash();

  @$internal
  @override
  AppearanceController create() => AppearanceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppearanceSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppearanceSettings>(value),
    );
  }
}

String _$appearanceControllerHash() =>
    r'3bb9831a7fafe4d7865aab0c4a08ab1c609cf204';

/// Holds the current [AppearanceSettings] and persists every change.
///
/// Updates are optimistic: the UI changes immediately and reverts if the
/// write fails.

abstract class _$AppearanceController extends $Notifier<AppearanceSettings> {
  AppearanceSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppearanceSettings, AppearanceSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppearanceSettings, AppearanceSettings>,
              AppearanceSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
