// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The player's coins, diamonds and experience.
///
/// Requires an opened database: only read it after start-up completes.

@ProviderFor(WalletController)
final walletControllerProvider = WalletControllerProvider._();

/// The player's coins, diamonds and experience.
///
/// Requires an opened database: only read it after start-up completes.
final class WalletControllerProvider
    extends $NotifierProvider<WalletController, Wallet> {
  /// The player's coins, diamonds and experience.
  ///
  /// Requires an opened database: only read it after start-up completes.
  WalletControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'walletControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$walletControllerHash();

  @$internal
  @override
  WalletController create() => WalletController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Wallet value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Wallet>(value),
    );
  }
}

String _$walletControllerHash() => r'fc79f42e0fe2ab67ff851bbb4e5333c13cd58418';

/// The player's coins, diamonds and experience.
///
/// Requires an opened database: only read it after start-up completes.

abstract class _$WalletController extends $Notifier<Wallet> {
  Wallet build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Wallet, Wallet>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Wallet, Wallet>,
              Wallet,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
