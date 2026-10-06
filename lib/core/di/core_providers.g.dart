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

/// The opened local database. Bound in `bootstrap.dart` after `init()`.

@ProviderFor(localDatabase)
final localDatabaseProvider = LocalDatabaseProvider._();

/// The opened local database. Bound in `bootstrap.dart` after `init()`.

final class LocalDatabaseProvider
    extends $FunctionalProvider<LocalDatabase, LocalDatabase, LocalDatabase>
    with $Provider<LocalDatabase> {
  /// The opened local database. Bound in `bootstrap.dart` after `init()`.
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
