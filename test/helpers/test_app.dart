import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/config/app_config.dart';
import 'package:math_strike/core/config/app_environment.dart';
import 'package:math_strike/core/di/core_providers.dart';
import 'package:math_strike/core/services/app_info/app_info.dart';
import 'package:math_strike/core/services/logging/app_logger.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/local_database.dart';
import 'package:math_strike/features/splash/splash_providers.dart';
import 'package:math_strike/routing/app_router.dart';
import 'package:math_strike/routing/app_routes.dart';

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
];

/// A [ProviderContainer] wired with [testOverrides], disposed after the test.
ProviderContainer createTestContainer({
  LocalDatabase? database,
  Duration splashMinimum = Duration.zero,
  List<Override> overrides = const [],
}) {
  final container = ProviderContainer(
    retry: noRetry,
    overrides: [
      ...testOverrides(database: database, splashMinimum: splashMinimum),
      ...overrides,
    ],
  );
  addTearDown(container.dispose);
  return container;
}

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
  /// The splash plays looping animations, so this does not settle; use
  /// [pumpMathStrikeApp] to get past start-up.
  Future<void> pumpMathStrikeAppAtSplash({
    Size size = const Size(400, 800),
    LocalDatabase? database,
    Future<void> Function()? firstFrameSignal,
    List<Override> overrides = const [],
  }) async {
    setWindowSize(size);
    await pumpWidget(
      ProviderScope(
        retry: noRetry,
        overrides: [
          ...testOverrides(
            database: database,
            firstFrameSignal: firstFrameSignal,
          ),
          ...overrides,
        ],
        child: const MathStrikeApp(),
      ),
    );
    await pump();
  }

  /// Pumps the app and waits until start-up has completed and the home
  /// screen is showing.
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
