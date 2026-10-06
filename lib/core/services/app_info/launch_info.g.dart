// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LaunchInfo _$LaunchInfoFromJson(Map<String, dynamic> json) => _LaunchInfo(
  firstLaunchAt: DateTime.parse(json['firstLaunchAt'] as String),
  lastLaunchAt: DateTime.parse(json['lastLaunchAt'] as String),
  launchCount: (json['launchCount'] as num).toInt(),
  currentVersion: json['currentVersion'] as String,
  previousVersion: json['previousVersion'] as String?,
);

Map<String, dynamic> _$LaunchInfoToJson(_LaunchInfo instance) =>
    <String, dynamic>{
      'firstLaunchAt': instance.firstLaunchAt.toIso8601String(),
      'lastLaunchAt': instance.lastLaunchAt.toIso8601String(),
      'launchCount': instance.launchCount,
      'currentVersion': instance.currentVersion,
      'previousVersion': ?instance.previousVersion,
    };
