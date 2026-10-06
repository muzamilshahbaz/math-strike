import 'dart:async';
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
import 'screens/error/startup_error_app.dart';

/// Composition root: creates platform-bound services, installs global error
/// handlers and starts the widget tree with the DI container configured.
///
/// Only work that *must* precede the first frame happens here (opening the
/// encrypted database, because the saved theme is needed immediately).
/// Slower start-up tasks (audio, ads, Drive) run behind the splash screen
/// in Phase 2.
Future<void> bootstrap() async {
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

  try {
    await database.init();
  } on Object catch (e, st) {
    logger.error('Start-up failed', error: e, stackTrace: st);
    runApp(StartupErrorApp(onRetry: () => unawaited(bootstrap())));
    return;
  }

  logger.info('Starting ${config.appName} (${config.environment.name})');
  runApp(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        appLoggerProvider.overrideWithValue(logger),
        localDatabaseProvider.overrideWithValue(database),
      ],
      child: const MathStrikeApp(),
    ),
  );
}
