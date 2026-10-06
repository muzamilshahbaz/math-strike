// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The account this installation is linked to, and the first-launch setup
/// stage. Drives the router's sign-in / setup gates.
///
/// Requires an opened database: only read it after start-up completes.

@ProviderFor(AccountController)
final accountControllerProvider = AccountControllerProvider._();

/// The account this installation is linked to, and the first-launch setup
/// stage. Drives the router's sign-in / setup gates.
///
/// Requires an opened database: only read it after start-up completes.
final class AccountControllerProvider
    extends $NotifierProvider<AccountController, AccountLink?> {
  /// The account this installation is linked to, and the first-launch setup
  /// stage. Drives the router's sign-in / setup gates.
  ///
  /// Requires an opened database: only read it after start-up completes.
  AccountControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountControllerHash();

  @$internal
  @override
  AccountController create() => AccountController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountLink? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountLink?>(value),
    );
  }
}

String _$accountControllerHash() => r'8ea6c726fad0adb6107719868601d41ed94cfa65';

/// The account this installation is linked to, and the first-launch setup
/// stage. Drives the router's sign-in / setup gates.
///
/// Requires an opened database: only read it after start-up completes.

abstract class _$AccountController extends $Notifier<AccountLink?> {
  AccountLink? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AccountLink?, AccountLink?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AccountLink?, AccountLink?>,
              AccountLink?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
