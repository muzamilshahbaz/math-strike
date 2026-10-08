// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The local player's profile, or `null` before onboarding.
///
/// Requires an opened database: only read it after start-up completes.

@ProviderFor(ProfileController)
final profileControllerProvider = ProfileControllerProvider._();

/// The local player's profile, or `null` before onboarding.
///
/// Requires an opened database: only read it after start-up completes.
final class ProfileControllerProvider
    extends $NotifierProvider<ProfileController, PlayerProfile?> {
  /// The local player's profile, or `null` before onboarding.
  ///
  /// Requires an opened database: only read it after start-up completes.
  ProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileControllerHash();

  @$internal
  @override
  ProfileController create() => ProfileController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlayerProfile? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlayerProfile?>(value),
    );
  }
}

String _$profileControllerHash() => r'67f142907f4d7ef1b45bd191413d275bcf576166';

/// The local player's profile, or `null` before onboarding.
///
/// Requires an opened database: only read it after start-up completes.

abstract class _$ProfileController extends $Notifier<PlayerProfile?> {
  PlayerProfile? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PlayerProfile?, PlayerProfile?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PlayerProfile?, PlayerProfile?>,
              PlayerProfile?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
