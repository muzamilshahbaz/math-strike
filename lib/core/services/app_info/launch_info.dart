import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants/app_constants.dart';
import '../logging/app_logger.dart';
import '../storage/key_value_store.dart';
import 'app_info.dart';

part 'launch_info.freezed.dart';
part 'launch_info.g.dart';

/// Facts about app launches on this device, recorded once per run.
///
/// Used by the first-launch flow (Phase 3), "what's new" notes and data
/// migrations after an upgrade.
@freezed
abstract class LaunchInfo with _$LaunchInfo {
  /// Creates launch info.
  const factory LaunchInfo({
    required DateTime firstLaunchAt,
    required DateTime lastLaunchAt,
    required int launchCount,

    /// Version running now.
    required String currentVersion,

    /// Version that ran on the previous launch, if any.
    String? previousVersion,
  }) = _LaunchInfo;

  const LaunchInfo._();

  /// Deserialises launch info.
  factory LaunchInfo.fromJson(Map<String, dynamic> json) =>
      _$LaunchInfoFromJson(json);

  /// True on the very first launch on this device (or after a reset).
  bool get isFirstLaunch => launchCount == 1;

  /// True when the app version changed since the previous launch.
  bool get isVersionChange =>
      previousVersion != null && previousVersion != currentVersion;
}

/// Records and reports app launches.
abstract interface class LaunchRepository {
  /// Records the current launch of [app] and returns the updated info.
  Future<LaunchInfo> recordLaunch(AppInfo app);
}

/// [LaunchRepository] stored in the encrypted `settings` box.
final class LaunchRepositoryImpl implements LaunchRepository {
  /// Creates the repository. [clock] is injectable for tests.
  LaunchRepositoryImpl({
    required this._store,
    required this._logger,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final KeyValueStore _store;
  final AppLogger _logger;
  final DateTime Function() _clock;

  @override
  Future<LaunchInfo> recordLaunch(AppInfo app) async {
    final now = _clock();
    final previous = _readPrevious();
    final info = previous == null
        ? LaunchInfo(
            firstLaunchAt: now,
            lastLaunchAt: now,
            launchCount: 1,
            currentVersion: app.version,
          )
        : LaunchInfo(
            firstLaunchAt: previous.firstLaunchAt,
            lastLaunchAt: now,
            launchCount: previous.launchCount + 1,
            currentVersion: app.version,
            previousVersion: previous.currentVersion,
          );
    await _store.writeJson(SettingsKeys.launchInfo, info.toJson());
    if (info.isVersionChange) {
      _logger.info(
        'App updated ${info.previousVersion} → ${info.currentVersion}',
      );
    }
    return info;
  }

  LaunchInfo? _readPrevious() {
    try {
      final json = _store.readJson(SettingsKeys.launchInfo);
      return json == null ? null : LaunchInfo.fromJson(json);
    } on Object catch (e, st) {
      _logger.warning(
        'Launch info unreadable; starting fresh',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }
}
