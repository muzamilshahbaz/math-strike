// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AudioSettings {

 bool get soundEnabled; bool get musicEnabled;/// Sound-effect volume, 0.0–1.0.
 double get soundVolume;/// Music volume, 0.0–1.0.
 double get musicVolume;
/// Create a copy of AudioSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioSettingsCopyWith<AudioSettings> get copyWith => _$AudioSettingsCopyWithImpl<AudioSettings>(this as AudioSettings, _$identity);

  /// Serializes this AudioSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AudioSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioSettings&&(identical(other.soundEnabled, _this.soundEnabled) || other.soundEnabled == _this.soundEnabled)&&(identical(other.musicEnabled, _this.musicEnabled) || other.musicEnabled == _this.musicEnabled)&&(identical(other.soundVolume, _this.soundVolume) || other.soundVolume == _this.soundVolume)&&(identical(other.musicVolume, _this.musicVolume) || other.musicVolume == _this.musicVolume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AudioSettings;
  return Object.hash(runtimeType,_this.soundEnabled,_this.musicEnabled,_this.soundVolume,_this.musicVolume);
}

@override
String toString() {
  final _this = this as AudioSettings;
  return 'AudioSettings(soundEnabled: ${_this.soundEnabled}, musicEnabled: ${_this.musicEnabled}, soundVolume: ${_this.soundVolume}, musicVolume: ${_this.musicVolume})';
}


}

/// @nodoc
abstract mixin class $AudioSettingsCopyWith<$Res>  {
  factory $AudioSettingsCopyWith(AudioSettings value, $Res Function(AudioSettings) _then) = _$AudioSettingsCopyWithImpl;
@useResult
$Res call({
 bool soundEnabled, bool musicEnabled, double soundVolume, double musicVolume
});




}
/// @nodoc
class _$AudioSettingsCopyWithImpl<$Res>
    implements $AudioSettingsCopyWith<$Res> {
  _$AudioSettingsCopyWithImpl(this._self, this._then);

  final AudioSettings _self;
  final $Res Function(AudioSettings) _then;

/// Create a copy of AudioSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? soundEnabled = null,Object? musicEnabled = null,Object? soundVolume = null,Object? musicVolume = null,}) {
  return _then(AudioSettings(
soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,musicEnabled: null == musicEnabled ? _self.musicEnabled : musicEnabled // ignore: cast_nullable_to_non_nullable
as bool,soundVolume: null == soundVolume ? _self.soundVolume : soundVolume // ignore: cast_nullable_to_non_nullable
as double,musicVolume: null == musicVolume ? _self.musicVolume : musicVolume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioSettings].
extension AudioSettingsPatterns on AudioSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioSettings value)  $default,){
final _that = this;
switch (_that) {
case _AudioSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AudioSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool soundEnabled,  bool musicEnabled,  double soundVolume,  double musicVolume)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioSettings() when $default != null:
return $default(_that.soundEnabled,_that.musicEnabled,_that.soundVolume,_that.musicVolume);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool soundEnabled,  bool musicEnabled,  double soundVolume,  double musicVolume)  $default,) {final _that = this;
switch (_that) {
case _AudioSettings():
return $default(_that.soundEnabled,_that.musicEnabled,_that.soundVolume,_that.musicVolume);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool soundEnabled,  bool musicEnabled,  double soundVolume,  double musicVolume)?  $default,) {final _that = this;
switch (_that) {
case _AudioSettings() when $default != null:
return $default(_that.soundEnabled,_that.musicEnabled,_that.soundVolume,_that.musicVolume);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AudioSettings implements AudioSettings {
  const _AudioSettings({this.soundEnabled = true, this.musicEnabled = true, this.soundVolume = 0.8, this.musicVolume = 0.6});
  factory _AudioSettings.fromJson(Map<String, dynamic> json) => _$AudioSettingsFromJson(json);

@override@JsonKey() final  bool soundEnabled;
@override@JsonKey() final  bool musicEnabled;
/// Sound-effect volume, 0.0–1.0.
@override@JsonKey() final  double soundVolume;
/// Music volume, 0.0–1.0.
@override@JsonKey() final  double musicVolume;

/// Create a copy of AudioSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioSettingsCopyWith<_AudioSettings> get copyWith => __$AudioSettingsCopyWithImpl<_AudioSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AudioSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioSettings&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.musicEnabled, musicEnabled) || other.musicEnabled == musicEnabled)&&(identical(other.soundVolume, soundVolume) || other.soundVolume == soundVolume)&&(identical(other.musicVolume, musicVolume) || other.musicVolume == musicVolume));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,soundEnabled,musicEnabled,soundVolume,musicVolume);
}

@override
String toString() {
    return 'AudioSettings(soundEnabled: $soundEnabled, musicEnabled: $musicEnabled, soundVolume: $soundVolume, musicVolume: $musicVolume)';
}


}

/// @nodoc
abstract mixin class _$AudioSettingsCopyWith<$Res> implements $AudioSettingsCopyWith<$Res> {
  factory _$AudioSettingsCopyWith(_AudioSettings value, $Res Function(_AudioSettings) _then) = __$AudioSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool soundEnabled, bool musicEnabled, double soundVolume, double musicVolume
});




}
/// @nodoc
class __$AudioSettingsCopyWithImpl<$Res>
    implements _$AudioSettingsCopyWith<$Res> {
  __$AudioSettingsCopyWithImpl(this._self, this._then);

  final _AudioSettings _self;
  final $Res Function(_AudioSettings) _then;

/// Create a copy of AudioSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? soundEnabled = null,Object? musicEnabled = null,Object? soundVolume = null,Object? musicVolume = null,}) {
  return _then(_AudioSettings(
soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,musicEnabled: null == musicEnabled ? _self.musicEnabled : musicEnabled // ignore: cast_nullable_to_non_nullable
as bool,soundVolume: null == soundVolume ? _self.soundVolume : soundVolume // ignore: cast_nullable_to_non_nullable
as double,musicVolume: null == musicVolume ? _self.musicVolume : musicVolume // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
