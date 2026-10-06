// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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
