// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'core_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Build-time configuration. Bound in `bootstrap.dart`.

@ProviderFor(appConfig)
final appConfigProvider = AppConfigProvider._();

/// Build-time configuration. Bound in `bootstrap.dart`.

final class AppConfigProvider
    extends $FunctionalProvider<AppConfig, AppConfig, AppConfig>
    with $Provider<AppConfig> {
  /// Build-time configuration. Bound in `bootstrap.dart`.
  AppConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appConfigHash();

  @$internal
  @override
  $ProviderElement<AppConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppConfig create(Ref ref) {
    return appConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppConfig>(value),
    );
  }
}

String _$appConfigHash() => r'549adbd5e67e18e10b0abf9ad110abfa319b72a0';

/// Application logger.

@ProviderFor(appLogger)
final appLoggerProvider = AppLoggerProvider._();

/// Application logger.

final class AppLoggerProvider
    extends $FunctionalProvider<AppLogger, AppLogger, AppLogger>
    with $Provider<AppLogger> {
  /// Application logger.
  AppLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLoggerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLoggerHash();

  @$internal
  @override
  $ProviderElement<AppLogger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLogger create(Ref ref) {
    return appLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLogger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLogger>(value),
    );
  }
}

String _$appLoggerHash() => r'db8da58f3274f7a3444e1844a29e55952d06e902';

/// The local database instance (not necessarily opened yet). Bound in
/// `bootstrap.dart`. Prefer [openedLocalDatabaseProvider] to know when it
/// is ready.

@ProviderFor(localDatabase)
final localDatabaseProvider = LocalDatabaseProvider._();

/// The local database instance (not necessarily opened yet). Bound in
/// `bootstrap.dart`. Prefer [openedLocalDatabaseProvider] to know when it
/// is ready.

final class LocalDatabaseProvider
    extends $FunctionalProvider<LocalDatabase, LocalDatabase, LocalDatabase>
    with $Provider<LocalDatabase> {
  /// The local database instance (not necessarily opened yet). Bound in
  /// `bootstrap.dart`. Prefer [openedLocalDatabaseProvider] to know when it
  /// is ready.
  LocalDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDatabaseHash();

  @$internal
  @override
  $ProviderElement<LocalDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LocalDatabase create(Ref ref) {
    return localDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalDatabase>(value),
    );
  }
}

String _$localDatabaseHash() => r'5a7583418cf772f43418f9c2ae21f7298236d0a9';

/// Opens the local database once. Awaited by the splash pipeline; anything
/// that reads a store must run after this completes.

@ProviderFor(openedLocalDatabase)
final openedLocalDatabaseProvider = OpenedLocalDatabaseProvider._();

/// Opens the local database once. Awaited by the splash pipeline; anything
/// that reads a store must run after this completes.

final class OpenedLocalDatabaseProvider
    extends
        $FunctionalProvider<
          AsyncValue<LocalDatabase>,
          LocalDatabase,
          FutureOr<LocalDatabase>
        >
    with $FutureModifier<LocalDatabase>, $FutureProvider<LocalDatabase> {
  /// Opens the local database once. Awaited by the splash pipeline; anything
  /// that reads a store must run after this completes.
  OpenedLocalDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'openedLocalDatabaseProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openedLocalDatabaseHash();

  @$internal
  @override
  $FutureProviderElement<LocalDatabase> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<LocalDatabase> create(Ref ref) {
    return openedLocalDatabase(ref);
  }
}

String _$openedLocalDatabaseHash() =>
    r'dcef89b0e3126e7810f87fc0c35c00166247e254';

/// Platform app-info reader.

@ProviderFor(appInfoService)
final appInfoServiceProvider = AppInfoServiceProvider._();

/// Platform app-info reader.

final class AppInfoServiceProvider
    extends $FunctionalProvider<AppInfoService, AppInfoService, AppInfoService>
    with $Provider<AppInfoService> {
  /// Platform app-info reader.
  AppInfoServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInfoServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInfoServiceHash();

  @$internal
  @override
  $ProviderElement<AppInfoService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppInfoService create(Ref ref) {
    return appInfoService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppInfoService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppInfoService>(value),
    );
  }
}

String _$appInfoServiceHash() => r'9c315e9484d484ad30b476cae3b18b264f23c2f8';

/// The installed build's name and version.

@ProviderFor(appInfo)
final appInfoProvider = AppInfoProvider._();

/// The installed build's name and version.

final class AppInfoProvider
    extends $FunctionalProvider<AsyncValue<AppInfo>, AppInfo, FutureOr<AppInfo>>
    with $FutureModifier<AppInfo>, $FutureProvider<AppInfo> {
  /// The installed build's name and version.
  AppInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'appInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInfoHash();

  @$internal
  @override
  $FutureProviderElement<AppInfo> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppInfo> create(Ref ref) {
    return appInfo(ref);
  }
}

String _$appInfoHash() => r'6958fb1ba2f1e294d2c7e8c2543923a7f7d08305';

/// Launch history repository. Requires an opened database.

@ProviderFor(launchRepository)
final launchRepositoryProvider = LaunchRepositoryProvider._();

/// Launch history repository. Requires an opened database.

final class LaunchRepositoryProvider
    extends
        $FunctionalProvider<
          LaunchRepository,
          LaunchRepository,
          LaunchRepository
        >
    with $Provider<LaunchRepository> {
  /// Launch history repository. Requires an opened database.
  LaunchRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'launchRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$launchRepositoryHash();

  @$internal
  @override
  $ProviderElement<LaunchRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LaunchRepository create(Ref ref) {
    return launchRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LaunchRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LaunchRepository>(value),
    );
  }
}

String _$launchRepositoryHash() => r'e9b87356e9ed5e2e2a5918d9461a4b48fc8565d4';

/// This run's launch info. Recorded exactly once per app run.

@ProviderFor(launchInfo)
final launchInfoProvider = LaunchInfoProvider._();

/// This run's launch info. Recorded exactly once per app run.

final class LaunchInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<LaunchInfo>,
          LaunchInfo,
          FutureOr<LaunchInfo>
        >
    with $FutureModifier<LaunchInfo>, $FutureProvider<LaunchInfo> {
  /// This run's launch info. Recorded exactly once per app run.
  LaunchInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: noRetry,
        name: r'launchInfoProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$launchInfoHash();

  @$internal
  @override
  $FutureProviderElement<LaunchInfo> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<LaunchInfo> create(Ref ref) {
    return launchInfo(ref);
  }
}

String _$launchInfoHash() => r'dbee821ab249cfeac2db2b22ebafd9fd7a0e9a5f';

/// Incremented whenever local data is replaced wholesale (restore, reset).
///
/// Controllers that cache data read from the local database watch this in
/// `build()`, so they reload automatically after a restore.

@ProviderFor(LocalDataEpoch)
final localDataEpochProvider = LocalDataEpochProvider._();

/// Incremented whenever local data is replaced wholesale (restore, reset).
///
/// Controllers that cache data read from the local database watch this in
/// `build()`, so they reload automatically after a restore.
final class LocalDataEpochProvider
    extends $NotifierProvider<LocalDataEpoch, int> {
  /// Incremented whenever local data is replaced wholesale (restore, reset).
  ///
  /// Controllers that cache data read from the local database watch this in
  /// `build()`, so they reload automatically after a restore.
  LocalDataEpochProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localDataEpochProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localDataEpochHash();

  @$internal
  @override
  LocalDataEpoch create() => LocalDataEpoch();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$localDataEpochHash() => r'0b45b62e0ba42540f4b2b1e1e624082dd7ef23c3';

/// Incremented whenever local data is replaced wholesale (restore, reset).
///
/// Controllers that cache data read from the local database watch this in
/// `build()`, so they reload automatically after a restore.

abstract class _$LocalDataEpoch extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The wall clock. Read the time through this provider (never call
/// `DateTime.now()` directly in features) so date logic is testable.

@ProviderFor(clock)
final clockProvider = ClockProvider._();

/// The wall clock. Read the time through this provider (never call
/// `DateTime.now()` directly in features) so date logic is testable.

final class ClockProvider extends $FunctionalProvider<Clock, Clock, Clock>
    with $Provider<Clock> {
  /// The wall clock. Read the time through this provider (never call
  /// `DateTime.now()` directly in features) so date logic is testable.
  ClockProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'clockProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$clockHash();

  @$internal
  @override
  $ProviderElement<Clock> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Clock create(Ref ref) {
    return clock(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Clock value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Clock>(value),
    );
  }
}

String _$clockHash() => r'ce4c8073e4878f6859ed9a59fae2c1819b4179af';

/// Today's local [CalendarDay], updated automatically at midnight.
///
/// Day-based features (daily rewards, today's statistics) watch this, so
/// they roll over while the app stays open across midnight.

@ProviderFor(CurrentDay)
final currentDayProvider = CurrentDayProvider._();

/// Today's local [CalendarDay], updated automatically at midnight.
///
/// Day-based features (daily rewards, today's statistics) watch this, so
/// they roll over while the app stays open across midnight.
final class CurrentDayProvider
    extends $NotifierProvider<CurrentDay, CalendarDay> {
  /// Today's local [CalendarDay], updated automatically at midnight.
  ///
  /// Day-based features (daily rewards, today's statistics) watch this, so
  /// they roll over while the app stays open across midnight.
  CurrentDayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDayHash();

  @$internal
  @override
  CurrentDay create() => CurrentDay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CalendarDay value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CalendarDay>(value),
    );
  }
}

String _$currentDayHash() => r'f909ade1357f025cdeb60ac5e210493996529a6d';

/// Today's local [CalendarDay], updated automatically at midnight.
///
/// Day-based features (daily rewards, today's statistics) watch this, so
/// they roll over while the app stays open across midnight.

abstract class _$CurrentDay extends $Notifier<CalendarDay> {
  CalendarDay build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CalendarDay, CalendarDay>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CalendarDay, CalendarDay>,
              CalendarDay,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
