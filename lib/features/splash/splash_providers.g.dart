// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The ordered list of start-up tasks.
///
/// Tasks run sequentially because later ones depend on earlier ones (the
/// theme and launch record need the database). Later phases register their
/// own tasks here:
///
/// * Phase 3 – Google account & Drive backup detection
/// * Phase 8 – audio preloading
/// * Phase 12 – ads SDK (non-critical: the game must start offline)

@ProviderFor(startupTasks)
final startupTasksProvider = StartupTasksProvider._();

/// The ordered list of start-up tasks.
///
/// Tasks run sequentially because later ones depend on earlier ones (the
/// theme and launch record need the database). Later phases register their
/// own tasks here:
///
/// * Phase 3 – Google account & Drive backup detection
/// * Phase 8 – audio preloading
/// * Phase 12 – ads SDK (non-critical: the game must start offline)

final class StartupTasksProvider
    extends
        $FunctionalProvider<
          List<StartupTask>,
          List<StartupTask>,
          List<StartupTask>
        >
    with $Provider<List<StartupTask>> {
  /// The ordered list of start-up tasks.
  ///
  /// Tasks run sequentially because later ones depend on earlier ones (the
  /// theme and launch record need the database). Later phases register their
  /// own tasks here:
  ///
  /// * Phase 3 – Google account & Drive backup detection
  /// * Phase 8 – audio preloading
  /// * Phase 12 – ads SDK (non-critical: the game must start offline)
  StartupTasksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startupTasksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startupTasksHash();

  @$internal
  @override
  $ProviderElement<List<StartupTask>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<StartupTask> create(Ref ref) {
    return startupTasks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StartupTask> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<StartupTask>>(value),
    );
  }
}

String _$startupTasksHash() => r'37d548cef458472853e5762f4be3b2220248bc48';

/// Minimum time the splash stays visible, so the brand animation can play
/// even when start-up is instant: the 1.8 s logo sequence plus a short hold.
/// Overridden with zero in tests.

@ProviderFor(splashMinimumDuration)
final splashMinimumDurationProvider = SplashMinimumDurationProvider._();

/// Minimum time the splash stays visible, so the brand animation can play
/// even when start-up is instant: the 1.8 s logo sequence plus a short hold.
/// Overridden with zero in tests.

final class SplashMinimumDurationProvider
    extends $FunctionalProvider<Duration, Duration, Duration>
    with $Provider<Duration> {
  /// Minimum time the splash stays visible, so the brand animation can play
  /// even when start-up is instant: the 1.8 s logo sequence plus a short hold.
  /// Overridden with zero in tests.
  SplashMinimumDurationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'splashMinimumDurationProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$splashMinimumDurationHash();

  @$internal
  @override
  $ProviderElement<Duration> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration create(Ref ref) {
    return splashMinimumDuration(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration>(value),
    );
  }
}

String _$splashMinimumDurationHash() =>
    r'9a19ebeeec31d39b91ce9e2513ed873ce2d7fa67';

/// Resolves when the first frame is actually visible (bounded by a timeout,
/// see [waitForFirstFrameShown]).
///
/// On the web the engine can still be loading fonts and shaders behind the
/// HTML pre-loader well after the first build, so the splash waits for this
/// before animating. Widget tests have no engine and override this with an
/// immediately-completing signal.

@ProviderFor(firstFrameRasterizedSignal)
final firstFrameRasterizedSignalProvider =
    FirstFrameRasterizedSignalProvider._();

/// Resolves when the first frame is actually visible (bounded by a timeout,
/// see [waitForFirstFrameShown]).
///
/// On the web the engine can still be loading fonts and shaders behind the
/// HTML pre-loader well after the first build, so the splash waits for this
/// before animating. Widget tests have no engine and override this with an
/// immediately-completing signal.

final class FirstFrameRasterizedSignalProvider
    extends
        $FunctionalProvider<
          Future<void> Function(),
          Future<void> Function(),
          Future<void> Function()
        >
    with $Provider<Future<void> Function()> {
  /// Resolves when the first frame is actually visible (bounded by a timeout,
  /// see [waitForFirstFrameShown]).
  ///
  /// On the web the engine can still be loading fonts and shaders behind the
  /// HTML pre-loader well after the first build, so the splash waits for this
  /// before animating. Widget tests have no engine and override this with an
  /// immediately-completing signal.
  FirstFrameRasterizedSignalProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firstFrameRasterizedSignalProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firstFrameRasterizedSignalHash();

  @$internal
  @override
  $ProviderElement<Future<void> Function()> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Future<void> Function() create(Ref ref) {
    return firstFrameRasterizedSignal(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Future<void> Function() value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Future<void> Function()>(value),
    );
  }
}

String _$firstFrameRasterizedSignalHash() =>
    r'65ca0a6047803bb75bd07f4780818366c290b21f';
