/// Core dependency-injection bindings.
///
/// Riverpod is the DI container: every service is exposed as a provider and
/// consumed through its *interface*. Platform-bound services that must be
/// initialised asynchronously before `runApp` (config, database) are
/// declared here as "must override" and bound in `bootstrap.dart`; tests
/// override them with fakes.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../config/app_config.dart';
import '../services/logging/app_logger.dart';
import '../services/storage/local_database.dart';

part 'core_providers.g.dart';

/// Build-time configuration. Bound in `bootstrap.dart`.
@Riverpod(keepAlive: true)
AppConfig appConfig(Ref ref) =>
    throw UnimplementedError('appConfigProvider must be overridden');

/// Application logger.
@Riverpod(keepAlive: true)
AppLogger appLogger(Ref ref) =>
    ConsoleAppLogger(verbose: ref.watch(appConfigProvider).verboseLogging);

/// The opened local database. Bound in `bootstrap.dart` after `init()`.
@Riverpod(keepAlive: true)
LocalDatabase localDatabase(Ref ref) =>
    throw UnimplementedError('localDatabaseProvider must be overridden');
