// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restore_flow_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Runs the mandatory first-launch backup check:
/// backup found → restore automatically with progress; none → onboarding.

@ProviderFor(RestoreFlowController)
final restoreFlowControllerProvider = RestoreFlowControllerProvider._();

/// Runs the mandatory first-launch backup check:
/// backup found → restore automatically with progress; none → onboarding.
final class RestoreFlowControllerProvider
    extends $NotifierProvider<RestoreFlowController, RestoreFlowState> {
  /// Runs the mandatory first-launch backup check:
  /// backup found → restore automatically with progress; none → onboarding.
  RestoreFlowControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restoreFlowControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restoreFlowControllerHash();

  @$internal
  @override
  RestoreFlowController create() => RestoreFlowController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestoreFlowState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestoreFlowState>(value),
    );
  }
}

String _$restoreFlowControllerHash() =>
    r'e672ea97d3287aaf74fdd292dab8e6812ee2eae4';

/// Runs the mandatory first-launch backup check:
/// backup found → restore automatically with progress; none → onboarding.

abstract class _$RestoreFlowController extends $Notifier<RestoreFlowState> {
  RestoreFlowState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RestoreFlowState, RestoreFlowState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RestoreFlowState, RestoreFlowState>,
              RestoreFlowState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
