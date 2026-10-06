// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppConfig {

 AppEnvironment get environment; String get appName;/// When true, AdMob test unit IDs are used (Phase 12). Always true
/// outside [AppEnvironment.production].
 bool get useTestAds;/// Enables debug-level log output.
 bool get verboseLogging;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&(identical(other.environment, _this.environment) || other.environment == _this.environment)&&(identical(other.appName, _this.appName) || other.appName == _this.appName)&&(identical(other.useTestAds, _this.useTestAds) || other.useTestAds == _this.useTestAds)&&(identical(other.verboseLogging, _this.verboseLogging) || other.verboseLogging == _this.verboseLogging));
}


@override
int get hashCode {
  final _this = this as AppConfig;
  return Object.hash(runtimeType,_this.environment,_this.appName,_this.useTestAds,_this.verboseLogging);
}

@override
String toString() {
  final _this = this as AppConfig;
  return 'AppConfig(environment: ${_this.environment}, appName: ${_this.appName}, useTestAds: ${_this.useTestAds}, verboseLogging: ${_this.verboseLogging})';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
 AppEnvironment environment, String appName, bool useTestAds, bool verboseLogging
});




}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? environment = null,Object? appName = null,Object? useTestAds = null,Object? verboseLogging = null,}) {
  return _then(AppConfig(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as AppEnvironment,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,useTestAds: null == useTestAds ? _self.useTestAds : useTestAds // ignore: cast_nullable_to_non_nullable
as bool,verboseLogging: null == verboseLogging ? _self.verboseLogging : verboseLogging // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AppEnvironment environment,  String appName,  bool useTestAds,  bool verboseLogging)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.environment,_that.appName,_that.useTestAds,_that.verboseLogging);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AppEnvironment environment,  String appName,  bool useTestAds,  bool verboseLogging)  $default,) {final _that = this;
switch (_that) {
case _AppConfig():
return $default(_that.environment,_that.appName,_that.useTestAds,_that.verboseLogging);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AppEnvironment environment,  String appName,  bool useTestAds,  bool verboseLogging)?  $default,) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.environment,_that.appName,_that.useTestAds,_that.verboseLogging);case _:
  return null;

}
}

}

/// @nodoc


class _AppConfig extends AppConfig {
  const _AppConfig({required this.environment, this.appName = AppConstants.appName, this.useTestAds = true, this.verboseLogging = false}): super._();
  

@override final  AppEnvironment environment;
@override@JsonKey() final  String appName;
/// When true, AdMob test unit IDs are used (Phase 12). Always true
/// outside [AppEnvironment.production].
@override@JsonKey() final  bool useTestAds;
/// Enables debug-level log output.
@override@JsonKey() final  bool verboseLogging;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppConfigCopyWith<_AppConfig> get copyWith => __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppConfig&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.appName, appName) || other.appName == appName)&&(identical(other.useTestAds, useTestAds) || other.useTestAds == useTestAds)&&(identical(other.verboseLogging, verboseLogging) || other.verboseLogging == verboseLogging));
}


@override
int get hashCode {
    return Object.hash(runtimeType,environment,appName,useTestAds,verboseLogging);
}

@override
String toString() {
    return 'AppConfig(environment: $environment, appName: $appName, useTestAds: $useTestAds, verboseLogging: $verboseLogging)';
}


}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) _then) = __$AppConfigCopyWithImpl;
@override @useResult
$Res call({
 AppEnvironment environment, String appName, bool useTestAds, bool verboseLogging
});




}
/// @nodoc
class __$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? environment = null,Object? appName = null,Object? useTestAds = null,Object? verboseLogging = null,}) {
  return _then(_AppConfig(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as AppEnvironment,appName: null == appName ? _self.appName : appName // ignore: cast_nullable_to_non_nullable
as String,useTestAds: null == useTestAds ? _self.useTestAds : useTestAds // ignore: cast_nullable_to_non_nullable
as bool,verboseLogging: null == verboseLogging ? _self.verboseLogging : verboseLogging // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
