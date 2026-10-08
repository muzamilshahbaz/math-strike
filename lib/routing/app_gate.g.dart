// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_gate.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Combines start-up and account state into an [AppGate].

@ProviderFor(appGate)
final appGateProvider = AppGateProvider._();

/// Combines start-up and account state into an [AppGate].

final class AppGateProvider
    extends $FunctionalProvider<AppGate, AppGate, AppGate>
    with $Provider<AppGate> {
  /// Combines start-up and account state into an [AppGate].
  AppGateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appGateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appGateHash();

  @$internal
  @override
  $ProviderElement<AppGate> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppGate create(Ref ref) {
    return appGate(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppGate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppGate>(value),
    );
  }
}

String _$appGateHash() => r'04c1e6631ff2943c2f770927fa5b39aa12b1d0ca';
