// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effective_appearance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The appearance the app should render with right now.
///
/// Defaults until the local database is open (the splash screen is drawn
/// with fixed brand colours, so the switch is not visible), then the
/// player's saved settings.

@ProviderFor(effectiveAppearance)
final effectiveAppearanceProvider = EffectiveAppearanceProvider._();

/// The appearance the app should render with right now.
///
/// Defaults until the local database is open (the splash screen is drawn
/// with fixed brand colours, so the switch is not visible), then the
/// player's saved settings.

final class EffectiveAppearanceProvider
    extends
        $FunctionalProvider<
          AppearanceSettings,
          AppearanceSettings,
          AppearanceSettings
        >
    with $Provider<AppearanceSettings> {
  /// The appearance the app should render with right now.
  ///
  /// Defaults until the local database is open (the splash screen is drawn
  /// with fixed brand colours, so the switch is not visible), then the
  /// player's saved settings.
  EffectiveAppearanceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'effectiveAppearanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$effectiveAppearanceHash();

  @$internal
  @override
  $ProviderElement<AppearanceSettings> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppearanceSettings create(Ref ref) {
    return effectiveAppearance(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppearanceSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppearanceSettings>(value),
    );
  }
}

String _$effectiveAppearanceHash() =>
    r'33e8c052a2a8b22c15d20d2b69692bcccfe4787f';
