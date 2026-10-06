// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Drives the mandatory sign-in screen. On success the account controller
/// links the device and the router moves on by itself.

@ProviderFor(SignInController)
final signInControllerProvider = SignInControllerProvider._();

/// Drives the mandatory sign-in screen. On success the account controller
/// links the device and the router moves on by itself.
final class SignInControllerProvider
    extends $NotifierProvider<SignInController, SignInState> {
  /// Drives the mandatory sign-in screen. On success the account controller
  /// links the device and the router moves on by itself.
  SignInControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInControllerHash();

  @$internal
  @override
  SignInController create() => SignInController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInState>(value),
    );
  }
}

String _$signInControllerHash() => r'1065f65138a0c9367a1b1826bee03f6e1f23b1b7';

/// Drives the mandatory sign-in screen. On success the account controller
/// links the device and the router moves on by itself.

abstract class _$SignInController extends $Notifier<SignInState> {
  SignInState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<SignInState, SignInState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SignInState, SignInState>,
              SignInState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
