import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/constants/app_constants.dart';
import 'package:math_strike/core/services/app_info/app_info.dart';
import 'package:math_strike/core/services/app_info/launch_info.dart';
import 'package:math_strike/core/services/logging/app_logger.dart';
import 'package:math_strike/core/services/storage/in_memory_local_database.dart';

void main() {
  const v1 = AppInfo(packageName: 'p', version: '1.0.0', buildNumber: '1');
  const v2 = AppInfo(packageName: 'p', version: '1.1.0', buildNumber: '2');
  final day1 = DateTime.utc(2026, 1, 1);
  final day2 = DateTime.utc(2026, 1, 2);

  LaunchRepositoryImpl repo(InMemoryKeyValueStore store, DateTime now) =>
      LaunchRepositoryImpl(
        store: store,
        logger: const SilentAppLogger(),
        clock: () => now,
      );

  test('first launch', () async {
    final info = await repo(InMemoryKeyValueStore(), day1).recordLaunch(v1);

    expect(info.isFirstLaunch, isTrue);
    expect(info.isVersionChange, isFalse);
    expect(info.firstLaunchAt, day1);
    expect(info.previousVersion, isNull);
  });

  test('subsequent launch keeps first date and increments count', () async {
    final store = InMemoryKeyValueStore();
    await repo(store, day1).recordLaunch(v1);

    final info = await repo(store, day2).recordLaunch(v1);

    expect(info.launchCount, 2);
    expect(info.firstLaunchAt, day1);
    expect(info.lastLaunchAt, day2);
    expect(info.isFirstLaunch, isFalse);
    expect(info.isVersionChange, isFalse);
  });

  test('detects a version change', () async {
    final store = InMemoryKeyValueStore();
    await repo(store, day1).recordLaunch(v1);

    final info = await repo(store, day2).recordLaunch(v2);

    expect(info.isVersionChange, isTrue);
    expect(info.previousVersion, '1.0.0');
    expect(info.currentVersion, '1.1.0');
  });

  test('corrupt record is treated as a first launch', () async {
    final store = InMemoryKeyValueStore({SettingsKeys.launchInfo: 'garbage'});

    final info = await repo(store, day1).recordLaunch(v1);

    expect(info.isFirstLaunch, isTrue);
  });

  test('AppInfo.displayVersion', () {
    expect(v1.displayVersion, 'v1.0.0 (1)');
    expect(
      const AppInfo(
        packageName: 'p',
        version: '2.0.0',
        buildNumber: '',
      ).displayVersion,
      'v2.0.0',
    );
  });
}
