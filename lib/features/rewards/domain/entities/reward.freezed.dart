// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reward.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reward {

 int get coins; int get diamonds; int get xp;
/// Create a copy of Reward
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RewardCopyWith<Reward> get copyWith => _$RewardCopyWithImpl<Reward>(this as Reward, _$identity);

  /// Serializes this Reward to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Reward;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reward&&(identical(other.coins, _this.coins) || other.coins == _this.coins)&&(identical(other.diamonds, _this.diamonds) || other.diamonds == _this.diamonds)&&(identical(other.xp, _this.xp) || other.xp == _this.xp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Reward;
  return Object.hash(runtimeType,_this.coins,_this.diamonds,_this.xp);
}

@override
String toString() {
  final _this = this as Reward;
  return 'Reward(coins: ${_this.coins}, diamonds: ${_this.diamonds}, xp: ${_this.xp})';
}


}

/// @nodoc
abstract mixin class $RewardCopyWith<$Res>  {
  factory $RewardCopyWith(Reward value, $Res Function(Reward) _then) = _$RewardCopyWithImpl;
@useResult
$Res call({
 int coins, int diamonds, int xp
});




}
/// @nodoc
class _$RewardCopyWithImpl<$Res>
    implements $RewardCopyWith<$Res> {
  _$RewardCopyWithImpl(this._self, this._then);

  final Reward _self;
  final $Res Function(Reward) _then;

/// Create a copy of Reward
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? coins = null,Object? diamonds = null,Object? xp = null,}) {
  return _then(Reward(
coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,diamonds: null == diamonds ? _self.diamonds : diamonds // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Reward].
extension RewardPatterns on Reward {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reward value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reward() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reward value)  $default,){
final _that = this;
switch (_that) {
case _Reward():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reward value)?  $default,){
final _that = this;
switch (_that) {
case _Reward() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int coins,  int diamonds,  int xp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reward() when $default != null:
return $default(_that.coins,_that.diamonds,_that.xp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int coins,  int diamonds,  int xp)  $default,) {final _that = this;
switch (_that) {
case _Reward():
return $default(_that.coins,_that.diamonds,_that.xp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int coins,  int diamonds,  int xp)?  $default,) {final _that = this;
switch (_that) {
case _Reward() when $default != null:
return $default(_that.coins,_that.diamonds,_that.xp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reward extends Reward {
  const _Reward({this.coins = 0, this.diamonds = 0, this.xp = 0}): assert(coins >= 0 && diamonds >= 0 && xp >= 0),super._();
  factory _Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

@override@JsonKey() final  int coins;
@override@JsonKey() final  int diamonds;
@override@JsonKey() final  int xp;

/// Create a copy of Reward
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RewardCopyWith<_Reward> get copyWith => __$RewardCopyWithImpl<_Reward>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RewardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reward&&(identical(other.coins, coins) || other.coins == coins)&&(identical(other.diamonds, diamonds) || other.diamonds == diamonds)&&(identical(other.xp, xp) || other.xp == xp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,coins,diamonds,xp);
}

@override
String toString() {
    return 'Reward(coins: $coins, diamonds: $diamonds, xp: $xp)';
}


}

/// @nodoc
abstract mixin class _$RewardCopyWith<$Res> implements $RewardCopyWith<$Res> {
  factory _$RewardCopyWith(_Reward value, $Res Function(_Reward) _then) = __$RewardCopyWithImpl;
@override @useResult
$Res call({
 int coins, int diamonds, int xp
});




}
/// @nodoc
class __$RewardCopyWithImpl<$Res>
    implements _$RewardCopyWith<$Res> {
  __$RewardCopyWithImpl(this._self, this._then);

  final _Reward _self;
  final $Res Function(_Reward) _then;

/// Create a copy of Reward
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? coins = null,Object? diamonds = null,Object? xp = null,}) {
  return _then(_Reward(
coins: null == coins ? _self.coins : coins // ignore: cast_nullable_to_non_nullable
as int,diamonds: null == diamonds ? _self.diamonds : diamonds // ignore: cast_nullable_to_non_nullable
as int,xp: null == xp ? _self.xp : xp // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
