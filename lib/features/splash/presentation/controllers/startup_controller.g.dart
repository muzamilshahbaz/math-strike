// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'startup_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Runs the start-up pipeline and exposes its progress.
///
/// * Tasks run in registry order with weighted progress.
/// * A failing *critical* task stops the pipeline in [StartupStatus.failed];
///   [retry] resumes from that task (completed tasks are not re-run).
/// * A failing non-critical task is recorded in `warnings` and skipped.
/// * Completion is held back until `splashMinimumDuration` has elapsed.

@ProviderFor(StartupController)
final startupControllerProvider = StartupControllerProvider._();

/// Runs the start-up pipeline and exposes its progress.
///
/// * Tasks run in registry order with weighted progress.
/// * A failing *critical* task stops the pipeline in [StartupStatus.failed];
///   [retry] resumes from that task (completed tasks are not re-run).
/// * A failing non-critical task is recorded in `warnings` and skipped.
/// * Completion is held back until `splashMinimumDuration` has elapsed.
final class StartupControllerProvider
    extends $NotifierProvider<StartupController, StartupState> {
  /// Runs the start-up pipeline and exposes its progress.
  ///
  /// * Tasks run in registry order with weighted progress.
  /// * A failing *critical* task stops the pipeline in [StartupStatus.failed];
  ///   [retry] resumes from that task (completed tasks are not re-run).
  /// * A failing non-critical task is recorded in `warnings` and skipped.
  /// * Completion is held back until `splashMinimumDuration` has elapsed.
  StartupControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startupControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startupControllerHash();

  @$internal
  @override
  StartupController create() => StartupController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(StartupState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<StartupState>(value),
    );
  }
}

String _$startupControllerHash() => r'adb2fddd2e0f48978b6864623755f03e9041860c';

/// Runs the start-up pipeline and exposes its progress.
///
/// * Tasks run in registry order with weighted progress.
/// * A failing *critical* task stops the pipeline in [StartupStatus.failed];
///   [retry] resumes from that task (completed tasks are not re-run).
/// * A failing non-critical task is recorded in `warnings` and skipped.
/// * Completion is held back until `splashMinimumDuration` has elapsed.

abstract class _$StartupController extends $Notifier<StartupState> {
  StartupState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<StartupState, StartupState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<StartupState, StartupState>,
              StartupState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
