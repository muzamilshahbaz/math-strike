// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'launch_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LaunchInfo {

 DateTime get firstLaunchAt; DateTime get lastLaunchAt; int get launchCount;/// Version running now.
 String get currentVersion;/// Version that ran on the previous launch, if any.
 String? get previousVersion;
/// Create a copy of LaunchInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LaunchInfoCopyWith<LaunchInfo> get copyWith => _$LaunchInfoCopyWithImpl<LaunchInfo>(this as LaunchInfo, _$identity);

  /// Serializes this LaunchInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LaunchInfo;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LaunchInfo&&(identical(other.firstLaunchAt, _this.firstLaunchAt) || other.firstLaunchAt == _this.firstLaunchAt)&&(identical(other.lastLaunchAt, _this.lastLaunchAt) || other.lastLaunchAt == _this.lastLaunchAt)&&(identical(other.launchCount, _this.launchCount) || other.launchCount == _this.launchCount)&&(identical(other.currentVersion, _this.currentVersion) || other.currentVersion == _this.currentVersion)&&(identical(other.previousVersion, _this.previousVersion) || other.previousVersion == _this.previousVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LaunchInfo;
  return Object.hash(runtimeType,_this.firstLaunchAt,_this.lastLaunchAt,_this.launchCount,_this.currentVersion,_this.previousVersion);
}

@override
String toString() {
  final _this = this as LaunchInfo;
  return 'LaunchInfo(firstLaunchAt: ${_this.firstLaunchAt}, lastLaunchAt: ${_this.lastLaunchAt}, launchCount: ${_this.launchCount}, currentVersion: ${_this.currentVersion}, previousVersion: ${_this.previousVersion})';
}


}

/// @nodoc
abstract mixin class $LaunchInfoCopyWith<$Res>  {
  factory $LaunchInfoCopyWith(LaunchInfo value, $Res Function(LaunchInfo) _then) = _$LaunchInfoCopyWithImpl;
@useResult
$Res call({
 DateTime firstLaunchAt, DateTime lastLaunchAt, int launchCount, String currentVersion, String? previousVersion
});




}
/// @nodoc
class _$LaunchInfoCopyWithImpl<$Res>
    implements $LaunchInfoCopyWith<$Res> {
  _$LaunchInfoCopyWithImpl(this._self, this._then);

  final LaunchInfo _self;
  final $Res Function(LaunchInfo) _then;

/// Create a copy of LaunchInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstLaunchAt = null,Object? lastLaunchAt = null,Object? launchCount = null,Object? currentVersion = null,Object? previousVersion = freezed,}) {
  return _then(LaunchInfo(
firstLaunchAt: null == firstLaunchAt ? _self.firstLaunchAt : firstLaunchAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLaunchAt: null == lastLaunchAt ? _self.lastLaunchAt : lastLaunchAt // ignore: cast_nullable_to_non_nullable
as DateTime,launchCount: null == launchCount ? _self.launchCount : launchCount // ignore: cast_nullable_to_non_nullable
as int,currentVersion: null == currentVersion ? _self.currentVersion : currentVersion // ignore: cast_nullable_to_non_nullable
as String,previousVersion: freezed == previousVersion ? _self.previousVersion : previousVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LaunchInfo].
extension LaunchInfoPatterns on LaunchInfo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LaunchInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LaunchInfo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LaunchInfo value)  $default,){
final _that = this;
switch (_that) {
case _LaunchInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LaunchInfo value)?  $default,){
final _that = this;
switch (_that) {
case _LaunchInfo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime firstLaunchAt,  DateTime lastLaunchAt,  int launchCount,  String currentVersion,  String? previousVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LaunchInfo() when $default != null:
return $default(_that.firstLaunchAt,_that.lastLaunchAt,_that.launchCount,_that.currentVersion,_that.previousVersion);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime firstLaunchAt,  DateTime lastLaunchAt,  int launchCount,  String currentVersion,  String? previousVersion)  $default,) {final _that = this;
switch (_that) {
case _LaunchInfo():
return $default(_that.firstLaunchAt,_that.lastLaunchAt,_that.launchCount,_that.currentVersion,_that.previousVersion);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime firstLaunchAt,  DateTime lastLaunchAt,  int launchCount,  String currentVersion,  String? previousVersion)?  $default,) {final _that = this;
switch (_that) {
case _LaunchInfo() when $default != null:
return $default(_that.firstLaunchAt,_that.lastLaunchAt,_that.launchCount,_that.currentVersion,_that.previousVersion);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LaunchInfo extends LaunchInfo {
  const _LaunchInfo({required this.firstLaunchAt, required this.lastLaunchAt, required this.launchCount, required this.currentVersion, this.previousVersion}): super._();
  factory _LaunchInfo.fromJson(Map<String, dynamic> json) => _$LaunchInfoFromJson(json);

@override final  DateTime firstLaunchAt;
@override final  DateTime lastLaunchAt;
@override final  int launchCount;
/// Version running now.
@override final  String currentVersion;
/// Version that ran on the previous launch, if any.
@override final  String? previousVersion;

/// Create a copy of LaunchInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LaunchInfoCopyWith<_LaunchInfo> get copyWith => __$LaunchInfoCopyWithImpl<_LaunchInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LaunchInfoToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LaunchInfo&&(identical(other.firstLaunchAt, firstLaunchAt) || other.firstLaunchAt == firstLaunchAt)&&(identical(other.lastLaunchAt, lastLaunchAt) || other.lastLaunchAt == lastLaunchAt)&&(identical(other.launchCount, launchCount) || other.launchCount == launchCount)&&(identical(other.currentVersion, currentVersion) || other.currentVersion == currentVersion)&&(identical(other.previousVersion, previousVersion) || other.previousVersion == previousVersion));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,firstLaunchAt,lastLaunchAt,launchCount,currentVersion,previousVersion);
}

@override
String toString() {
    return 'LaunchInfo(firstLaunchAt: $firstLaunchAt, lastLaunchAt: $lastLaunchAt, launchCount: $launchCount, currentVersion: $currentVersion, previousVersion: $previousVersion)';
}


}

/// @nodoc
abstract mixin class _$LaunchInfoCopyWith<$Res> implements $LaunchInfoCopyWith<$Res> {
  factory _$LaunchInfoCopyWith(_LaunchInfo value, $Res Function(_LaunchInfo) _then) = __$LaunchInfoCopyWithImpl;
@override @useResult
$Res call({
 DateTime firstLaunchAt, DateTime lastLaunchAt, int launchCount, String currentVersion, String? previousVersion
});




}
/// @nodoc
class __$LaunchInfoCopyWithImpl<$Res>
    implements _$LaunchInfoCopyWith<$Res> {
  __$LaunchInfoCopyWithImpl(this._self, this._then);

  final _LaunchInfo _self;
  final $Res Function(_LaunchInfo) _then;

/// Create a copy of LaunchInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstLaunchAt = null,Object? lastLaunchAt = null,Object? launchCount = null,Object? currentVersion = null,Object? previousVersion = freezed,}) {
  return _then(_LaunchInfo(
firstLaunchAt: null == firstLaunchAt ? _self.firstLaunchAt : firstLaunchAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLaunchAt: null == lastLaunchAt ? _self.lastLaunchAt : lastLaunchAt // ignore: cast_nullable_to_non_nullable
as DateTime,launchCount: null == launchCount ? _self.launchCount : launchCount // ignore: cast_nullable_to_non_nullable
as int,currentVersion: null == currentVersion ? _self.currentVersion : currentVersion // ignore: cast_nullable_to_non_nullable
as String,previousVersion: freezed == previousVersion ? _self.previousVersion : previousVersion // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
