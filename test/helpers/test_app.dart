import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/app.dart';
import 'package:math_strike/core/config/app_config.dart';
import 'package:math_strike/core/config/app_environment.dart';
import 'package:math_strike/core/di/core_providers.dart';
import 'package:math_strike/core/services/logging/app_logger.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';
import 'package:math_strike/core/services/storage/local_database.dart';

/// Provider overrides that replace every platform-bound service with an
/// in-memory fake.
List<Override> testOverrides({LocalDatabase? database}) => [
  appConfigProvider.overrideWithValue(
    const AppConfig(environment: AppEnvironment.development),
  ),
  appLoggerProvider.overrideWithValue(const SilentAppLogger()),
  localDatabaseProvider.overrideWithValue(database ?? InMemoryLocalDatabase()),
];

/// A [ProviderContainer] wired with [testOverrides], disposed after the test.
ProviderContainer createTestContainer({
  LocalDatabase? database,
  List<Override> overrides = const [],
}) {
  final container = ProviderContainer(
    overrides: [
      ...testOverrides(database: database),
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

  /// Pumps [MathStrikeApp] with in-memory services.
  Future<void> pumpMathStrikeApp({
    Size size = const Size(400, 800),
    LocalDatabase? database,
  }) async {
    setWindowSize(size);
    await pumpWidget(
      ProviderScope(
        overrides: testOverrides(database: database),
        child: const MathStrikeApp(),
      ),
    );
    await pumpAndSettle();
  }
}
