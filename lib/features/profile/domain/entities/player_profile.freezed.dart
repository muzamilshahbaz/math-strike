// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerProfile {

 String get name;/// Stable avatar identifier (see the avatar catalogue).
 String get avatarId;@JsonKey(unknownEnumValue: AgeGroup.custom) AgeGroup get ageGroup;@JsonKey(unknownEnumValue: Difficulty.medium) Difficulty get difficulty; DateTime get createdAt;
/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerProfileCopyWith<PlayerProfile> get copyWith => _$PlayerProfileCopyWithImpl<PlayerProfile>(this as PlayerProfile, _$identity);

  /// Serializes this PlayerProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlayerProfile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerProfile&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId)&&(identical(other.ageGroup, _this.ageGroup) || other.ageGroup == _this.ageGroup)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlayerProfile;
  return Object.hash(runtimeType,_this.name,_this.avatarId,_this.ageGroup,_this.difficulty,_this.createdAt);
}

@override
String toString() {
  final _this = this as PlayerProfile;
  return 'PlayerProfile(name: ${_this.name}, avatarId: ${_this.avatarId}, ageGroup: ${_this.ageGroup}, difficulty: ${_this.difficulty}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $PlayerProfileCopyWith<$Res>  {
  factory $PlayerProfileCopyWith(PlayerProfile value, $Res Function(PlayerProfile) _then) = _$PlayerProfileCopyWithImpl;
@useResult
$Res call({
 String name, String avatarId,@JsonKey(unknownEnumValue: AgeGroup.custom) AgeGroup ageGroup,@JsonKey(unknownEnumValue: Difficulty.medium) Difficulty difficulty, DateTime createdAt
});




}
/// @nodoc
class _$PlayerProfileCopyWithImpl<$Res>
    implements $PlayerProfileCopyWith<$Res> {
  _$PlayerProfileCopyWithImpl(this._self, this._then);

  final PlayerProfile _self;
  final $Res Function(PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? avatarId = null,Object? ageGroup = null,Object? difficulty = null,Object? createdAt = null,}) {
  return _then(PlayerProfile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,ageGroup: null == ageGroup ? _self.ageGroup : ageGroup // ignore: cast_nullable_to_non_nullable
as AgeGroup,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerProfile].
extension PlayerProfilePatterns on PlayerProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerProfile value)  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String avatarId, @JsonKey(unknownEnumValue: AgeGroup.custom)  AgeGroup ageGroup, @JsonKey(unknownEnumValue: Difficulty.medium)  Difficulty difficulty,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.name,_that.avatarId,_that.ageGroup,_that.difficulty,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String avatarId, @JsonKey(unknownEnumValue: AgeGroup.custom)  AgeGroup ageGroup, @JsonKey(unknownEnumValue: Difficulty.medium)  Difficulty difficulty,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile():
return $default(_that.name,_that.avatarId,_that.ageGroup,_that.difficulty,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String avatarId, @JsonKey(unknownEnumValue: AgeGroup.custom)  AgeGroup ageGroup, @JsonKey(unknownEnumValue: Difficulty.medium)  Difficulty difficulty,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PlayerProfile() when $default != null:
return $default(_that.name,_that.avatarId,_that.ageGroup,_that.difficulty,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerProfile implements PlayerProfile {
  const _PlayerProfile({required this.name, required this.avatarId, @JsonKey(unknownEnumValue: AgeGroup.custom) required this.ageGroup, @JsonKey(unknownEnumValue: Difficulty.medium) required this.difficulty, required this.createdAt});
  factory _PlayerProfile.fromJson(Map<String, dynamic> json) => _$PlayerProfileFromJson(json);

@override final  String name;
/// Stable avatar identifier (see the avatar catalogue).
@override final  String avatarId;
@override@JsonKey(unknownEnumValue: AgeGroup.custom) final  AgeGroup ageGroup;
@override@JsonKey(unknownEnumValue: Difficulty.medium) final  Difficulty difficulty;
@override final  DateTime createdAt;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerProfileCopyWith<_PlayerProfile> get copyWith => __$PlayerProfileCopyWithImpl<_PlayerProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerProfileToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerProfile&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.ageGroup, ageGroup) || other.ageGroup == ageGroup)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,name,avatarId,ageGroup,difficulty,createdAt);
}

@override
String toString() {
    return 'PlayerProfile(name: $name, avatarId: $avatarId, ageGroup: $ageGroup, difficulty: $difficulty, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerProfileCopyWith<$Res> implements $PlayerProfileCopyWith<$Res> {
  factory _$PlayerProfileCopyWith(_PlayerProfile value, $Res Function(_PlayerProfile) _then) = __$PlayerProfileCopyWithImpl;
@override @useResult
$Res call({
 String name, String avatarId,@JsonKey(unknownEnumValue: AgeGroup.custom) AgeGroup ageGroup,@JsonKey(unknownEnumValue: Difficulty.medium) Difficulty difficulty, DateTime createdAt
});




}
/// @nodoc
class __$PlayerProfileCopyWithImpl<$Res>
    implements _$PlayerProfileCopyWith<$Res> {
  __$PlayerProfileCopyWithImpl(this._self, this._then);

  final _PlayerProfile _self;
  final $Res Function(_PlayerProfile) _then;

/// Create a copy of PlayerProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? avatarId = null,Object? ageGroup = null,Object? difficulty = null,Object? createdAt = null,}) {
  return _then(_PlayerProfile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,ageGroup: null == ageGroup ? _self.ageGroup : ageGroup // ignore: cast_nullable_to_non_nullable
as AgeGroup,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
