/// Core dependency-injection bindings.
///
/// Riverpod is the DI container: every service is exposed as a provider and
/// consumed through its *interface*. Platform-bound services (config,
/// database) are declared here as "must override" and bound in
/// `bootstrap.dart`; tests override them with fakes.
///
/// Services that need asynchronous initialisation are exposed as
/// `Future` providers that the splash pipeline awaits ("warms up"), so the
/// rest of the app can read their values synchronously afterwards.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../services/app_info/app_info.dart';
import '../services/app_info/launch_info.dart';
import '../services/logging/app_logger.dart';
import '../services/storage/local_database.dart';

part 'core_providers.g.dart';

/// Retry policy that disables Riverpod's automatic retries. Start-up
/// failures are retried explicitly by the user from the splash screen.
Duration? noRetry(int retryCount, Object error) => null;

/// Build-time configuration. Bound in `bootstrap.dart`.
@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) =>
    throw UnimplementedError('appConfigProvider must be overridden');

/// Application logger.
@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) =>
    ConsoleAppLogger(verbose: ref.watch(appConfigProvider).verboseLogging);

/// The local database instance (not necessarily opened yet). Bound in
/// `bootstrap.dart`. Prefer [openedLocalDatabaseProvider] to know when it
/// is ready.
@Riverpod(keepAlive: true)
LocalDatabase localDatabase(Ref ref) =>
    throw UnimplementedError('localDatabaseProvider must be overridden');

/// Opens the local database once. Awaited by the splash pipeline; anything
/// that reads a store must run after this completes.
@Riverpod(keepAlive: true, retry: noRetry)
Future<LocalDatabase> openedLocalDatabase(Ref ref) async {
  final database = ref.watch(localDatabaseProvider);
  await database.init();
  return database;
}

/// Platform app-info reader.
@Riverpod(keepAlive: true)
AppInfoService appInfoService(Ref ref) => const PackageInfoAppInfoService();

/// The installed build's name and version.
@Riverpod(keepAlive: true, retry: noRetry)
Future<AppInfo> appInfo(Ref ref) => ref.watch(appInfoServiceProvider).load();

/// Launch history repository. Requires an opened database.
@Riverpod(keepAlive: true)
LaunchRepository launchRepository(Ref ref) => LaunchRepositoryImpl(
  store: ref.watch(localDatabaseProvider).store(StorageBox.device),
  logger: ref.watch(appLoggerProvider),
);

/// This run's launch info. Recorded exactly once per app run.
@Riverpod(keepAlive: true, retry: noRetry)
Future<LaunchInfo> launchInfo(Ref ref) async {
  final repository = ref.watch(launchRepositoryProvider);
  final app = await ref.watch(appInfoProvider.future);
  return repository.recordLaunch(app);
}

/// Incremented whenever local data is replaced wholesale (restore, reset).
///
/// Controllers that cache data read from the local database watch this in
/// `build()`, so they reload automatically after a restore.
@Riverpod(keepAlive: true)
class LocalDataEpoch extends _$LocalDataEpoch {
  @override
  int build() => 0;

  /// Signals that local data was replaced.
  void bump() => state++;
}
