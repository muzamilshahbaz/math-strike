import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../errors/app_exception.dart';

part 'app_info.freezed.dart';

/// Identity and version of the installed build.
@freezed
abstract class AppInfo with _$AppInfo {
  /// Creates app info.
  const factory AppInfo({
    required String packageName,
    required String version,
    required String buildNumber,
  }) = _AppInfo;

  const AppInfo._();

  /// Human-readable version, e.g. `v1.2.0 (14)`.
  String get displayVersion =>
      buildNumber.isEmpty ? 'v$version' : 'v$version ($buildNumber)';
}

/// Reads [AppInfo] from the platform.
abstract interface class AppInfoService {
  /// Loads the installed build's info.
  Future<AppInfo> load();
}

/// [AppInfoService] backed by `package_info_plus`.
final class PackageInfoAppInfoService implements AppInfoService {
  /// Creates the service.
  const PackageInfoAppInfoService();

  @override
  Future<AppInfo> load() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return AppInfo(
        packageName: info.packageName,
        version: info.version,
        buildNumber: info.buildNumber,
      );
    } on Object catch (e, st) {
      throw DataFormatException(
        'Unable to read app version',
        cause: e,
        stackTrace: st,
      );
    }
  }
}
