// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoogleConfig implements DiagnosticableTreeMixin {

/// Android: the *Web application* client ID, used as `serverClientId`.
 String get serverClientId;/// iOS and macOS client ID.
 String get appleClientId;/// Web client ID.
 String get webClientId;/// Windows/Linux *Desktop app* client ID.
 String get desktopClientId;/// Windows/Linux *Desktop app* client secret. Google documents that for
/// installed apps this value is not treated as confidential.
 String get desktopClientSecret;
/// Create a copy of GoogleConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoogleConfigCopyWith<GoogleConfig> get copyWith => _$GoogleConfigCopyWithImpl<GoogleConfig>(this as GoogleConfig, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  final _this = this as GoogleConfig;
  properties
    ..add(DiagnosticsProperty('type', 'GoogleConfig'))
    ..add(DiagnosticsProperty('serverClientId', _this.serverClientId))..add(DiagnosticsProperty('appleClientId', _this.appleClientId))..add(DiagnosticsProperty('webClientId', _this.webClientId))..add(DiagnosticsProperty('desktopClientId', _this.desktopClientId))..add(DiagnosticsProperty('desktopClientSecret', _this.desktopClientSecret));
}

@override
bool operator ==(Object other) {
  final _this = this as GoogleConfig;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleConfig&&(identical(other.serverClientId, _this.serverClientId) || other.serverClientId == _this.serverClientId)&&(identical(other.appleClientId, _this.appleClientId) || other.appleClientId == _this.appleClientId)&&(identical(other.webClientId, _this.webClientId) || other.webClientId == _this.webClientId)&&(identical(other.desktopClientId, _this.desktopClientId) || other.desktopClientId == _this.desktopClientId)&&(identical(other.desktopClientSecret, _this.desktopClientSecret) || other.desktopClientSecret == _this.desktopClientSecret));
}


@override
int get hashCode {
  final _this = this as GoogleConfig;
  return Object.hash(runtimeType,_this.serverClientId,_this.appleClientId,_this.webClientId,_this.desktopClientId,_this.desktopClientSecret);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  final _this = this as GoogleConfig;
  return 'GoogleConfig(serverClientId: ${_this.serverClientId}, appleClientId: ${_this.appleClientId}, webClientId: ${_this.webClientId}, desktopClientId: ${_this.desktopClientId}, desktopClientSecret: ${_this.desktopClientSecret})';
}


}

/// @nodoc
abstract mixin class $GoogleConfigCopyWith<$Res>  {
  factory $GoogleConfigCopyWith(GoogleConfig value, $Res Function(GoogleConfig) _then) = _$GoogleConfigCopyWithImpl;
@useResult
$Res call({
 String serverClientId, String appleClientId, String webClientId, String desktopClientId, String desktopClientSecret
});




}
/// @nodoc
class _$GoogleConfigCopyWithImpl<$Res>
    implements $GoogleConfigCopyWith<$Res> {
  _$GoogleConfigCopyWithImpl(this._self, this._then);

  final GoogleConfig _self;
  final $Res Function(GoogleConfig) _then;

/// Create a copy of GoogleConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serverClientId = null,Object? appleClientId = null,Object? webClientId = null,Object? desktopClientId = null,Object? desktopClientSecret = null,}) {
  return _then(GoogleConfig(
serverClientId: null == serverClientId ? _self.serverClientId : serverClientId // ignore: cast_nullable_to_non_nullable
as String,appleClientId: null == appleClientId ? _self.appleClientId : appleClientId // ignore: cast_nullable_to_non_nullable
as String,webClientId: null == webClientId ? _self.webClientId : webClientId // ignore: cast_nullable_to_non_nullable
as String,desktopClientId: null == desktopClientId ? _self.desktopClientId : desktopClientId // ignore: cast_nullable_to_non_nullable
as String,desktopClientSecret: null == desktopClientSecret ? _self.desktopClientSecret : desktopClientSecret // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GoogleConfig].
extension GoogleConfigPatterns on GoogleConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoogleConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoogleConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoogleConfig value)  $default,){
final _that = this;
switch (_that) {
case _GoogleConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoogleConfig value)?  $default,){
final _that = this;
switch (_that) {
case _GoogleConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String serverClientId,  String appleClientId,  String webClientId,  String desktopClientId,  String desktopClientSecret)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoogleConfig() when $default != null:
return $default(_that.serverClientId,_that.appleClientId,_that.webClientId,_that.desktopClientId,_that.desktopClientSecret);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String serverClientId,  String appleClientId,  String webClientId,  String desktopClientId,  String desktopClientSecret)  $default,) {final _that = this;
switch (_that) {
case _GoogleConfig():
return $default(_that.serverClientId,_that.appleClientId,_that.webClientId,_that.desktopClientId,_that.desktopClientSecret);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String serverClientId,  String appleClientId,  String webClientId,  String desktopClientId,  String desktopClientSecret)?  $default,) {final _that = this;
switch (_that) {
case _GoogleConfig() when $default != null:
return $default(_that.serverClientId,_that.appleClientId,_that.webClientId,_that.desktopClientId,_that.desktopClientSecret);case _:
  return null;

}
}

}

/// @nodoc


class _GoogleConfig extends GoogleConfig with DiagnosticableTreeMixin {
  const _GoogleConfig({this.serverClientId = '', this.appleClientId = '', this.webClientId = '', this.desktopClientId = '', this.desktopClientSecret = ''}): super._();
  

/// Android: the *Web application* client ID, used as `serverClientId`.
@override@JsonKey() final  String serverClientId;
/// iOS and macOS client ID.
@override@JsonKey() final  String appleClientId;
/// Web client ID.
@override@JsonKey() final  String webClientId;
/// Windows/Linux *Desktop app* client ID.
@override@JsonKey() final  String desktopClientId;
/// Windows/Linux *Desktop app* client secret. Google documents that for
/// installed apps this value is not treated as confidential.
@override@JsonKey() final  String desktopClientSecret;

/// Create a copy of GoogleConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoogleConfigCopyWith<_GoogleConfig> get copyWith => __$GoogleConfigCopyWithImpl<_GoogleConfig>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
    ..add(DiagnosticsProperty('type', 'GoogleConfig'))
    ..add(DiagnosticsProperty('serverClientId', serverClientId))..add(DiagnosticsProperty('appleClientId', appleClientId))..add(DiagnosticsProperty('webClientId', webClientId))..add(DiagnosticsProperty('desktopClientId', desktopClientId))..add(DiagnosticsProperty('desktopClientSecret', desktopClientSecret));
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoogleConfig&&(identical(other.serverClientId, serverClientId) || other.serverClientId == serverClientId)&&(identical(other.appleClientId, appleClientId) || other.appleClientId == appleClientId)&&(identical(other.webClientId, webClientId) || other.webClientId == webClientId)&&(identical(other.desktopClientId, desktopClientId) || other.desktopClientId == desktopClientId)&&(identical(other.desktopClientSecret, desktopClientSecret) || other.desktopClientSecret == desktopClientSecret));
}


@override
int get hashCode {
    return Object.hash(runtimeType,serverClientId,appleClientId,webClientId,desktopClientId,desktopClientSecret);
}

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
    return 'GoogleConfig(serverClientId: $serverClientId, appleClientId: $appleClientId, webClientId: $webClientId, desktopClientId: $desktopClientId, desktopClientSecret: $desktopClientSecret)';
}


}

/// @nodoc
abstract mixin class _$GoogleConfigCopyWith<$Res> implements $GoogleConfigCopyWith<$Res> {
  factory _$GoogleConfigCopyWith(_GoogleConfig value, $Res Function(_GoogleConfig) _then) = __$GoogleConfigCopyWithImpl;
@override @useResult
$Res call({
 String serverClientId, String appleClientId, String webClientId, String desktopClientId, String desktopClientSecret
});




}
/// @nodoc
class __$GoogleConfigCopyWithImpl<$Res>
    implements _$GoogleConfigCopyWith<$Res> {
  __$GoogleConfigCopyWithImpl(this._self, this._then);

  final _GoogleConfig _self;
  final $Res Function(_GoogleConfig) _then;

/// Create a copy of GoogleConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serverClientId = null,Object? appleClientId = null,Object? webClientId = null,Object? desktopClientId = null,Object? desktopClientSecret = null,}) {
  return _then(_GoogleConfig(
serverClientId: null == serverClientId ? _self.serverClientId : serverClientId // ignore: cast_nullable_to_non_nullable
as String,appleClientId: null == appleClientId ? _self.appleClientId : appleClientId // ignore: cast_nullable_to_non_nullable
as String,webClientId: null == webClientId ? _self.webClientId : webClientId // ignore: cast_nullable_to_non_nullable
as String,desktopClientId: null == desktopClientId ? _self.desktopClientId : desktopClientId // ignore: cast_nullable_to_non_nullable
as String,desktopClientSecret: null == desktopClientSecret ? _self.desktopClientSecret : desktopClientSecret // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
