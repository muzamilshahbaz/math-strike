// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appearance_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppearanceSettings {

/// Light / dark / follow system ("Auto").
@JsonKey(unknownEnumValue: ThemeMode.system) ThemeMode get themeMode;/// Active visual theme.
@JsonKey(unknownEnumValue: GameThemeId.space) GameThemeId get gameTheme;/// Maximum-contrast colour scheme.
 bool get highContrast;/// Minimise animations, particles and screen shake.
 bool get reduceMotion;/// Multiplier applied on top of the system text size.
 double get textScale;
/// Create a copy of AppearanceSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppearanceSettingsCopyWith<AppearanceSettings> get copyWith => _$AppearanceSettingsCopyWithImpl<AppearanceSettings>(this as AppearanceSettings, _$identity);

  /// Serializes this AppearanceSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AppearanceSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppearanceSettings&&(identical(other.themeMode, _this.themeMode) || other.themeMode == _this.themeMode)&&(identical(other.gameTheme, _this.gameTheme) || other.gameTheme == _this.gameTheme)&&(identical(other.highContrast, _this.highContrast) || other.highContrast == _this.highContrast)&&(identical(other.reduceMotion, _this.reduceMotion) || other.reduceMotion == _this.reduceMotion)&&(identical(other.textScale, _this.textScale) || other.textScale == _this.textScale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AppearanceSettings;
  return Object.hash(runtimeType,_this.themeMode,_this.gameTheme,_this.highContrast,_this.reduceMotion,_this.textScale);
}

@override
String toString() {
  final _this = this as AppearanceSettings;
  return 'AppearanceSettings(themeMode: ${_this.themeMode}, gameTheme: ${_this.gameTheme}, highContrast: ${_this.highContrast}, reduceMotion: ${_this.reduceMotion}, textScale: ${_this.textScale})';
}


}

/// @nodoc
abstract mixin class $AppearanceSettingsCopyWith<$Res>  {
  factory $AppearanceSettingsCopyWith(AppearanceSettings value, $Res Function(AppearanceSettings) _then) = _$AppearanceSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(unknownEnumValue: ThemeMode.system) ThemeMode themeMode,@JsonKey(unknownEnumValue: GameThemeId.space) GameThemeId gameTheme, bool highContrast, bool reduceMotion, double textScale
});




}
/// @nodoc
class _$AppearanceSettingsCopyWithImpl<$Res>
    implements $AppearanceSettingsCopyWith<$Res> {
  _$AppearanceSettingsCopyWithImpl(this._self, this._then);

  final AppearanceSettings _self;
  final $Res Function(AppearanceSettings) _then;

/// Create a copy of AppearanceSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? gameTheme = null,Object? highContrast = null,Object? reduceMotion = null,Object? textScale = null,}) {
  return _then(AppearanceSettings(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,gameTheme: null == gameTheme ? _self.gameTheme : gameTheme // ignore: cast_nullable_to_non_nullable
as GameThemeId,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,reduceMotion: null == reduceMotion ? _self.reduceMotion : reduceMotion // ignore: cast_nullable_to_non_nullable
as bool,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AppearanceSettings].
extension AppearanceSettingsPatterns on AppearanceSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppearanceSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppearanceSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppearanceSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppearanceSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppearanceSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppearanceSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ThemeMode.system)  ThemeMode themeMode, @JsonKey(unknownEnumValue: GameThemeId.space)  GameThemeId gameTheme,  bool highContrast,  bool reduceMotion,  double textScale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppearanceSettings() when $default != null:
return $default(_that.themeMode,_that.gameTheme,_that.highContrast,_that.reduceMotion,_that.textScale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(unknownEnumValue: ThemeMode.system)  ThemeMode themeMode, @JsonKey(unknownEnumValue: GameThemeId.space)  GameThemeId gameTheme,  bool highContrast,  bool reduceMotion,  double textScale)  $default,) {final _that = this;
switch (_that) {
case _AppearanceSettings():
return $default(_that.themeMode,_that.gameTheme,_that.highContrast,_that.reduceMotion,_that.textScale);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(unknownEnumValue: ThemeMode.system)  ThemeMode themeMode, @JsonKey(unknownEnumValue: GameThemeId.space)  GameThemeId gameTheme,  bool highContrast,  bool reduceMotion,  double textScale)?  $default,) {final _that = this;
switch (_that) {
case _AppearanceSettings() when $default != null:
return $default(_that.themeMode,_that.gameTheme,_that.highContrast,_that.reduceMotion,_that.textScale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppearanceSettings implements AppearanceSettings {
  const _AppearanceSettings({@JsonKey(unknownEnumValue: ThemeMode.system) this.themeMode = ThemeMode.system, @JsonKey(unknownEnumValue: GameThemeId.space) this.gameTheme = GameThemeId.space, this.highContrast = false, this.reduceMotion = false, this.textScale = 1.0});
  factory _AppearanceSettings.fromJson(Map<String, dynamic> json) => _$AppearanceSettingsFromJson(json);

/// Light / dark / follow system ("Auto").
@override@JsonKey(unknownEnumValue: ThemeMode.system) final  ThemeMode themeMode;
/// Active visual theme.
@override@JsonKey(unknownEnumValue: GameThemeId.space) final  GameThemeId gameTheme;
/// Maximum-contrast colour scheme.
@override@JsonKey() final  bool highContrast;
/// Minimise animations, particles and screen shake.
@override@JsonKey() final  bool reduceMotion;
/// Multiplier applied on top of the system text size.
@override@JsonKey() final  double textScale;

/// Create a copy of AppearanceSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppearanceSettingsCopyWith<_AppearanceSettings> get copyWith => __$AppearanceSettingsCopyWithImpl<_AppearanceSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppearanceSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppearanceSettings&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.gameTheme, gameTheme) || other.gameTheme == gameTheme)&&(identical(other.highContrast, highContrast) || other.highContrast == highContrast)&&(identical(other.reduceMotion, reduceMotion) || other.reduceMotion == reduceMotion)&&(identical(other.textScale, textScale) || other.textScale == textScale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,themeMode,gameTheme,highContrast,reduceMotion,textScale);
}

@override
String toString() {
    return 'AppearanceSettings(themeMode: $themeMode, gameTheme: $gameTheme, highContrast: $highContrast, reduceMotion: $reduceMotion, textScale: $textScale)';
}


}

/// @nodoc
abstract mixin class _$AppearanceSettingsCopyWith<$Res> implements $AppearanceSettingsCopyWith<$Res> {
  factory _$AppearanceSettingsCopyWith(_AppearanceSettings value, $Res Function(_AppearanceSettings) _then) = __$AppearanceSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(unknownEnumValue: ThemeMode.system) ThemeMode themeMode,@JsonKey(unknownEnumValue: GameThemeId.space) GameThemeId gameTheme, bool highContrast, bool reduceMotion, double textScale
});




}
/// @nodoc
class __$AppearanceSettingsCopyWithImpl<$Res>
    implements _$AppearanceSettingsCopyWith<$Res> {
  __$AppearanceSettingsCopyWithImpl(this._self, this._then);

  final _AppearanceSettings _self;
  final $Res Function(_AppearanceSettings) _then;

/// Create a copy of AppearanceSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? gameTheme = null,Object? highContrast = null,Object? reduceMotion = null,Object? textScale = null,}) {
  return _then(_AppearanceSettings(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as ThemeMode,gameTheme: null == gameTheme ? _self.gameTheme : gameTheme // ignore: cast_nullable_to_non_nullable
as GameThemeId,highContrast: null == highContrast ? _self.highContrast : highContrast // ignore: cast_nullable_to_non_nullable
as bool,reduceMotion: null == reduceMotion ? _self.reduceMotion : reduceMotion // ignore: cast_nullable_to_non_nullable
as bool,textScale: null == textScale ? _self.textScale : textScale // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
