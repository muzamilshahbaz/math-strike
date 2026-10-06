import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/config/app_config.dart';
import 'package:math_strike/core/config/app_environment.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/di/core_providers.dart';
import 'package:math_strike/core/services/app_info/app_info.dart';
import 'package:math_strike/core/services/logging/app_logger.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/key_value_store.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/features/authentication/authentication_providers.dart';
import 'package:math_strike/features/authentication/domain/entities/account_link.dart';
import 'package:math_strike/features/backup/backup_providers.dart';
import 'package:math_strike/features/backup/data/datasources/backup_remote_data_source.dart';
import 'package:math_strike/features/backup/data/datasources/in_memory_backup_data_source.dart';
import 'package:math_strike/features/splash/splash_providers.dart';
import 'package:math_strike/routing/app_router.dart';
import 'package:math_strike/routing/app_routes.dart';

import 'fake_google_auth_gateway.dart';

/// [AppInfoService] returning fixed values.
class FakeAppInfoService implements AppInfoService {
  /// Creates the fake.
  const FakeAppInfoService([this.version = '1.0.0']);

  /// Version to report.
  final String version;

  @override
  Future<AppInfo> load() async => AppInfo(
    packageName: 'com.mathstrike.test',
    version: version,
    buildNumber: '1',
  );
}

/// Provider overrides that replace every platform-bound service with an
/// in-memory fake and remove the splash minimum duration.
List<Override> testOverrides({
  LocalDatabase? database,
  Duration splashMinimum = Duration.zero,
  Future<void> Function()? firstFrameSignal,
  FakeGoogleAuthGateway? gateway,
  BackupRemoteDataSource? drive,
}) => [
  appConfigProvider.overrideWithValue(
    const AppConfig(environment: AppEnvironment.development),
  ),
  appLoggerProvider.overrideWithValue(const SilentAppLogger()),
  localDatabaseProvider.overrideWithValue(database ?? InMemoryLocalDatabase()),
  appInfoServiceProvider.overrideWithValue(const FakeAppInfoService()),
  splashMinimumDurationProvider.overrideWithValue(splashMinimum),
  // No engine in widget tests, so frames are never "rasterized".
  firstFrameRasterizedSignalProvider.overrideWithValue(
    firstFrameSignal ?? () async {},
  ),
  googleIntegrationModeProvider.overrideWithValue(GoogleIntegrationMode.live),
  googleAuthGatewayProvider.overrideWithValue(
    gateway ?? FakeGoogleAuthGateway(),
  ),
  backupRemoteDataSourceProvider.overrideWithValue(
    drive ?? InMemoryBackupDataSource(),
  ),
];

/// A [ProviderContainer] wired with [testOverrides], disposed after the test.
ProviderContainer createTestContainer({
  LocalDatabase? database,
  Duration splashMinimum = Duration.zero,
  FakeGoogleAuthGateway? gateway,
  BackupRemoteDataSource? drive,
  List<Override> overrides = const [],
}) {
  final container = ProviderContainer(
    retry: noRetry,
    overrides: [
      ...testOverrides(
        database: database,
        splashMinimum: splashMinimum,
        gateway: gateway,
        drive: drive,
      ),
      ...overrides,
    ],
  );
  addTearDown(container.dispose);
  return container;
}

/// Links [database] to the fake account at [stage], as if the player had
/// already been through first-launch setup.
Future<void> linkTestAccount(
  LocalDatabase database, {
  AccountSetupStage stage = AccountSetupStage.complete,
}) => database
    .store(StorageBox.device)
    .writeJson(
      DeviceKeys.accountLink,
      AccountLink(
        account: FakeGoogleAuthGateway.defaultAccount,
        linkedAt: DateTime.utc(2026),
        stage: stage,
      ).toJson(),
    );

/// Test helpers for pumping the full app.
extension PumpApp on WidgetTester {
  /// Sets the logical window size for this test.
  void setWindowSize(Size size) {
    view.physicalSize = size;
    view.devicePixelRatio = 1;
    addTearDown(view.reset);
  }

  /// Pumps [MathStrikeApp] with in-memory services and [overrides].
  ///
  /// Unless [linked] is false, the device is pre-linked to a Google account
  /// with setup complete, so start-up leads straight into the app.
  ///
  /// The splash plays looping animations, so this does not settle; use
  /// [pumpMathStrikeApp] to get past start-up.
  Future<void> pumpMathStrikeAppAtSplash({
    Size size = const Size(400, 800),
    LocalDatabase? database,
    bool linked = true,
    Future<void> Function()? firstFrameSignal,
    FakeGoogleAuthGateway? gateway,
    BackupRemoteDataSource? drive,
    List<Override> overrides = const [],
  }) async {
    setWindowSize(size);
    final db = database ?? InMemoryLocalDatabase();
    if (linked &&
        db.store(StorageBox.device).read(DeviceKeys.accountLink) == null) {
      await linkTestAccount(db);
    }
    await pumpWidget(
      ProviderScope(
        retry: noRetry,
        overrides: [
          ...testOverrides(
            database: db,
            firstFrameSignal: firstFrameSignal,
            gateway: gateway,
            drive: drive,
          ),
          ...overrides,
        ],
        child: const MathStrikeApp(),
      ),
    );
    await pump();
  }

  /// Pumps the app (pre-linked) and waits until start-up has completed and
  /// the home screen is showing.
  Future<void> pumpMathStrikeApp({
    Size size = const Size(400, 800),
    LocalDatabase? database,
    List<Override> overrides = const [],
  }) async {
    await pumpMathStrikeAppAtSplash(
      size: size,
      database: database,
      overrides: overrides,
    );
    await pumpAndSettle();
    expect(currentLocation, AppRoutes.home);
  }

  /// The [ProviderContainer] of the pumped app.
  ProviderContainer get container =>
      ProviderScope.containerOf(element(find.byType(MathStrikeApp)));

  /// The router's current location.
  String get currentLocation => container
      .read(appRouterProvider)
      .routerDelegate
      .currentConfiguration
      .uri
      .toString();
}
