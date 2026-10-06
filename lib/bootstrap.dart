import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app.dart';
import 'core/config/app_config.dart';
import 'core/di/core_providers.dart';
import 'core/services/logging/app_logger.dart';
import 'core/services/storage/encryption_key_provider.dart';
import 'core/services/storage/hive_local_database.dart';

/// Composition root: creates platform-bound services, installs global error
/// handlers and starts the widget tree with the DI container configured.
///
/// Nothing slow or fallible happens here, so the first frame (the splash
/// screen) appears as fast as possible. All initialisation — database,
/// theme, version check and, in later phases, Drive/audio/ads — runs in
/// the splash pipeline, which also owns error recovery.
void bootstrap() {
  WidgetsFlutterBinding.ensureInitialized();

  final config = AppConfig.fromEnvironment();
  final AppLogger logger = ConsoleAppLogger(verbose: config.verboseLogging);

  FlutterError.onError = (details) {
    logger.error(
      'Flutter framework error',
      error: details.exception,
      stackTrace: details.stack,
    );
    if (!config.isProduction) FlutterError.presentError(details);
  };
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    logger.error('Uncaught error', error: error, stackTrace: stackTrace);
    return true;
  };

  final database = HiveLocalDatabase(
    keyProvider: const SecureStorageEncryptionKeyProvider(
      FlutterSecureStorage(),
    ),
    logger: logger,
  );

  logger.info('Starting ${config.appName} (${config.environment.name})');
  runApp(
    ProviderScope(
      // Failures are surfaced and retried explicitly (splash, repositories);
      // silent background retries would hide problems and waste battery.
      retry: noRetry,
      overrides: [
        appConfigProvider.overrideWithValue(config),
        appLoggerProvider.overrideWithValue(logger),
        localDatabaseProvider.overrideWithValue(database),
      ],
      child: const MathStrikeApp(),
    ),
  );
}
