// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_reward.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyRewardRecord {

/// The last day a reward was claimed, or `null` if never.
@CalendarDayConverter() CalendarDay? get lastClaimDay;/// Consecutive days claimed, ending on [lastClaimDay].
 int get streak;/// Longest streak ever reached.
 int get longestStreak;/// Total rewards ever claimed.
 int get totalClaims;
/// Create a copy of DailyRewardRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyRewardRecordCopyWith<DailyRewardRecord> get copyWith => _$DailyRewardRecordCopyWithImpl<DailyRewardRecord>(this as DailyRewardRecord, _$identity);

  /// Serializes this DailyRewardRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as DailyRewardRecord;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyRewardRecord&&(identical(other.lastClaimDay, _this.lastClaimDay) || other.lastClaimDay == _this.lastClaimDay)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.longestStreak, _this.longestStreak) || other.longestStreak == _this.longestStreak)&&(identical(other.totalClaims, _this.totalClaims) || other.totalClaims == _this.totalClaims));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DailyRewardRecord;
  return Object.hash(runtimeType,_this.lastClaimDay,_this.streak,_this.longestStreak,_this.totalClaims);
}

@override
String toString() {
  final _this = this as DailyRewardRecord;
  return 'DailyRewardRecord(lastClaimDay: ${_this.lastClaimDay}, streak: ${_this.streak}, longestStreak: ${_this.longestStreak}, totalClaims: ${_this.totalClaims})';
}


}

/// @nodoc
abstract mixin class $DailyRewardRecordCopyWith<$Res>  {
  factory $DailyRewardRecordCopyWith(DailyRewardRecord value, $Res Function(DailyRewardRecord) _then) = _$DailyRewardRecordCopyWithImpl;
@useResult
$Res call({
@CalendarDayConverter() CalendarDay? lastClaimDay, int streak, int longestStreak, int totalClaims
});




}
/// @nodoc
class _$DailyRewardRecordCopyWithImpl<$Res>
    implements $DailyRewardRecordCopyWith<$Res> {
  _$DailyRewardRecordCopyWithImpl(this._self, this._then);

  final DailyRewardRecord _self;
  final $Res Function(DailyRewardRecord) _then;

/// Create a copy of DailyRewardRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastClaimDay = freezed,Object? streak = null,Object? longestStreak = null,Object? totalClaims = null,}) {
  return _then(DailyRewardRecord(
lastClaimDay: freezed == lastClaimDay ? _self.lastClaimDay : lastClaimDay // ignore: cast_nullable_to_non_nullable
as CalendarDay?,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,totalClaims: null == totalClaims ? _self.totalClaims : totalClaims // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyRewardRecord].
extension DailyRewardRecordPatterns on DailyRewardRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyRewardRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyRewardRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyRewardRecord value)  $default,){
final _that = this;
switch (_that) {
case _DailyRewardRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyRewardRecord value)?  $default,){
final _that = this;
switch (_that) {
case _DailyRewardRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@CalendarDayConverter()  CalendarDay? lastClaimDay,  int streak,  int longestStreak,  int totalClaims)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyRewardRecord() when $default != null:
return $default(_that.lastClaimDay,_that.streak,_that.longestStreak,_that.totalClaims);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@CalendarDayConverter()  CalendarDay? lastClaimDay,  int streak,  int longestStreak,  int totalClaims)  $default,) {final _that = this;
switch (_that) {
case _DailyRewardRecord():
return $default(_that.lastClaimDay,_that.streak,_that.longestStreak,_that.totalClaims);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@CalendarDayConverter()  CalendarDay? lastClaimDay,  int streak,  int longestStreak,  int totalClaims)?  $default,) {final _that = this;
switch (_that) {
case _DailyRewardRecord() when $default != null:
return $default(_that.lastClaimDay,_that.streak,_that.longestStreak,_that.totalClaims);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyRewardRecord implements DailyRewardRecord {
  const _DailyRewardRecord({@CalendarDayConverter() this.lastClaimDay, this.streak = 0, this.longestStreak = 0, this.totalClaims = 0});
  factory _DailyRewardRecord.fromJson(Map<String, dynamic> json) => _$DailyRewardRecordFromJson(json);

/// The last day a reward was claimed, or `null` if never.
@override@CalendarDayConverter() final  CalendarDay? lastClaimDay;
/// Consecutive days claimed, ending on [lastClaimDay].
@override@JsonKey() final  int streak;
/// Longest streak ever reached.
@override@JsonKey() final  int longestStreak;
/// Total rewards ever claimed.
@override@JsonKey() final  int totalClaims;

/// Create a copy of DailyRewardRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyRewardRecordCopyWith<_DailyRewardRecord> get copyWith => __$DailyRewardRecordCopyWithImpl<_DailyRewardRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyRewardRecordToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyRewardRecord&&(identical(other.lastClaimDay, lastClaimDay) || other.lastClaimDay == lastClaimDay)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak)&&(identical(other.totalClaims, totalClaims) || other.totalClaims == totalClaims));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,lastClaimDay,streak,longestStreak,totalClaims);
}

@override
String toString() {
    return 'DailyRewardRecord(lastClaimDay: $lastClaimDay, streak: $streak, longestStreak: $longestStreak, totalClaims: $totalClaims)';
}


}

/// @nodoc
abstract mixin class _$DailyRewardRecordCopyWith<$Res> implements $DailyRewardRecordCopyWith<$Res> {
  factory _$DailyRewardRecordCopyWith(_DailyRewardRecord value, $Res Function(_DailyRewardRecord) _then) = __$DailyRewardRecordCopyWithImpl;
@override @useResult
$Res call({
@CalendarDayConverter() CalendarDay? lastClaimDay, int streak, int longestStreak, int totalClaims
});




}
/// @nodoc
class __$DailyRewardRecordCopyWithImpl<$Res>
    implements _$DailyRewardRecordCopyWith<$Res> {
  __$DailyRewardRecordCopyWithImpl(this._self, this._then);

  final _DailyRewardRecord _self;
  final $Res Function(_DailyRewardRecord) _then;

/// Create a copy of DailyRewardRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastClaimDay = freezed,Object? streak = null,Object? longestStreak = null,Object? totalClaims = null,}) {
  return _then(_DailyRewardRecord(
lastClaimDay: freezed == lastClaimDay ? _self.lastClaimDay : lastClaimDay // ignore: cast_nullable_to_non_nullable
as CalendarDay?,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,totalClaims: null == totalClaims ? _self.totalClaims : totalClaims // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$DailyRewardStatus {

/// Whether today's reward is waiting to be claimed.
 bool get canClaim;/// Current unbroken streak (0 once a day has been missed).
 int get streak;/// Day of the cycle (1-based) to highlight: the one claimable today, or
/// the one already claimed today.
 int get cycleDay;/// Rewards for each day of the cycle.
 List<Reward> get cycle;/// Whether a previous streak was lost by missing a day.
 bool get streakLost;/// Longest streak ever reached.
 int get longestStreak;
/// Create a copy of DailyRewardStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyRewardStatusCopyWith<DailyRewardStatus> get copyWith => _$DailyRewardStatusCopyWithImpl<DailyRewardStatus>(this as DailyRewardStatus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailyRewardStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyRewardStatus&&(identical(other.canClaim, _this.canClaim) || other.canClaim == _this.canClaim)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.cycleDay, _this.cycleDay) || other.cycleDay == _this.cycleDay)&&const DeepCollectionEquality().equals(other.cycle, _this.cycle)&&(identical(other.streakLost, _this.streakLost) || other.streakLost == _this.streakLost)&&(identical(other.longestStreak, _this.longestStreak) || other.longestStreak == _this.longestStreak));
}


@override
int get hashCode {
  final _this = this as DailyRewardStatus;
  return Object.hash(runtimeType,_this.canClaim,_this.streak,_this.cycleDay,const DeepCollectionEquality().hash(_this.cycle),_this.streakLost,_this.longestStreak);
}

@override
String toString() {
  final _this = this as DailyRewardStatus;
  return 'DailyRewardStatus(canClaim: ${_this.canClaim}, streak: ${_this.streak}, cycleDay: ${_this.cycleDay}, cycle: ${_this.cycle}, streakLost: ${_this.streakLost}, longestStreak: ${_this.longestStreak})';
}


}

/// @nodoc
abstract mixin class $DailyRewardStatusCopyWith<$Res>  {
  factory $DailyRewardStatusCopyWith(DailyRewardStatus value, $Res Function(DailyRewardStatus) _then) = _$DailyRewardStatusCopyWithImpl;
@useResult
$Res call({
 bool canClaim, int streak, int cycleDay, List<Reward> cycle, bool streakLost, int longestStreak
});




}
/// @nodoc
class _$DailyRewardStatusCopyWithImpl<$Res>
    implements $DailyRewardStatusCopyWith<$Res> {
  _$DailyRewardStatusCopyWithImpl(this._self, this._then);

  final DailyRewardStatus _self;
  final $Res Function(DailyRewardStatus) _then;

/// Create a copy of DailyRewardStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? canClaim = null,Object? streak = null,Object? cycleDay = null,Object? cycle = null,Object? streakLost = null,Object? longestStreak = null,}) {
  return _then(DailyRewardStatus(
canClaim: null == canClaim ? _self.canClaim : canClaim // ignore: cast_nullable_to_non_nullable
as bool,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,cycleDay: null == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int,cycle: null == cycle ? _self.cycle : cycle // ignore: cast_nullable_to_non_nullable
as List<Reward>,streakLost: null == streakLost ? _self.streakLost : streakLost // ignore: cast_nullable_to_non_nullable
as bool,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyRewardStatus].
extension DailyRewardStatusPatterns on DailyRewardStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyRewardStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyRewardStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyRewardStatus value)  $default,){
final _that = this;
switch (_that) {
case _DailyRewardStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyRewardStatus value)?  $default,){
final _that = this;
switch (_that) {
case _DailyRewardStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool canClaim,  int streak,  int cycleDay,  List<Reward> cycle,  bool streakLost,  int longestStreak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyRewardStatus() when $default != null:
return $default(_that.canClaim,_that.streak,_that.cycleDay,_that.cycle,_that.streakLost,_that.longestStreak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool canClaim,  int streak,  int cycleDay,  List<Reward> cycle,  bool streakLost,  int longestStreak)  $default,) {final _that = this;
switch (_that) {
case _DailyRewardStatus():
return $default(_that.canClaim,_that.streak,_that.cycleDay,_that.cycle,_that.streakLost,_that.longestStreak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool canClaim,  int streak,  int cycleDay,  List<Reward> cycle,  bool streakLost,  int longestStreak)?  $default,) {final _that = this;
switch (_that) {
case _DailyRewardStatus() when $default != null:
return $default(_that.canClaim,_that.streak,_that.cycleDay,_that.cycle,_that.streakLost,_that.longestStreak);case _:
  return null;

}
}

}

/// @nodoc


class _DailyRewardStatus extends DailyRewardStatus {
  const _DailyRewardStatus({required this.canClaim, required this.streak, required this.cycleDay, required  List<Reward> cycle, this.streakLost = false, this.longestStreak = 0}): _cycle = cycle,super._();
  

/// Whether today's reward is waiting to be claimed.
@override final  bool canClaim;
/// Current unbroken streak (0 once a day has been missed).
@override final  int streak;
/// Day of the cycle (1-based) to highlight: the one claimable today, or
/// the one already claimed today.
@override final  int cycleDay;
/// Rewards for each day of the cycle.
 final  List<Reward> _cycle;
/// Rewards for each day of the cycle.
@override List<Reward> get cycle {
  if (_cycle is EqualUnmodifiableListView) return _cycle;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cycle);
}

/// Whether a previous streak was lost by missing a day.
@override@JsonKey() final  bool streakLost;
/// Longest streak ever reached.
@override@JsonKey() final  int longestStreak;

/// Create a copy of DailyRewardStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyRewardStatusCopyWith<_DailyRewardStatus> get copyWith => __$DailyRewardStatusCopyWithImpl<_DailyRewardStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyRewardStatus&&(identical(other.canClaim, canClaim) || other.canClaim == canClaim)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.cycleDay, cycleDay) || other.cycleDay == cycleDay)&&const DeepCollectionEquality().equals(other.cycle, _cycle)&&(identical(other.streakLost, streakLost) || other.streakLost == streakLost)&&(identical(other.longestStreak, longestStreak) || other.longestStreak == longestStreak));
}


@override
int get hashCode {
    return Object.hash(runtimeType,canClaim,streak,cycleDay,const DeepCollectionEquality().hash(_cycle),streakLost,longestStreak);
}

@override
String toString() {
    return 'DailyRewardStatus(canClaim: $canClaim, streak: $streak, cycleDay: $cycleDay, cycle: $cycle, streakLost: $streakLost, longestStreak: $longestStreak)';
}


}

/// @nodoc
abstract mixin class _$DailyRewardStatusCopyWith<$Res> implements $DailyRewardStatusCopyWith<$Res> {
  factory _$DailyRewardStatusCopyWith(_DailyRewardStatus value, $Res Function(_DailyRewardStatus) _then) = __$DailyRewardStatusCopyWithImpl;
@override @useResult
$Res call({
 bool canClaim, int streak, int cycleDay, List<Reward> cycle, bool streakLost, int longestStreak
});




}
/// @nodoc
class __$DailyRewardStatusCopyWithImpl<$Res>
    implements _$DailyRewardStatusCopyWith<$Res> {
  __$DailyRewardStatusCopyWithImpl(this._self, this._then);

  final _DailyRewardStatus _self;
  final $Res Function(_DailyRewardStatus) _then;

/// Create a copy of DailyRewardStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? canClaim = null,Object? streak = null,Object? cycleDay = null,Object? cycle = null,Object? streakLost = null,Object? longestStreak = null,}) {
  return _then(_DailyRewardStatus(
canClaim: null == canClaim ? _self.canClaim : canClaim // ignore: cast_nullable_to_non_nullable
as bool,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,cycleDay: null == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int,cycle: null == cycle ? _self._cycle : cycle // ignore: cast_nullable_to_non_nullable
as List<Reward>,streakLost: null == streakLost ? _self.streakLost : streakLost // ignore: cast_nullable_to_non_nullable
as bool,longestStreak: null == longestStreak ? _self.longestStreak : longestStreak // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$DailyRewardClaim {

/// What was granted.
 Reward get reward;/// The record to persist.
 DailyRewardRecord get record;/// Day of the cycle (1-based) that was claimed.
 int get cycleDay;
/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyRewardClaimCopyWith<DailyRewardClaim> get copyWith => _$DailyRewardClaimCopyWithImpl<DailyRewardClaim>(this as DailyRewardClaim, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DailyRewardClaim;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyRewardClaim&&(identical(other.reward, _this.reward) || other.reward == _this.reward)&&(identical(other.record, _this.record) || other.record == _this.record)&&(identical(other.cycleDay, _this.cycleDay) || other.cycleDay == _this.cycleDay));
}


@override
int get hashCode {
  final _this = this as DailyRewardClaim;
  return Object.hash(runtimeType,_this.reward,_this.record,_this.cycleDay);
}

@override
String toString() {
  final _this = this as DailyRewardClaim;
  return 'DailyRewardClaim(reward: ${_this.reward}, record: ${_this.record}, cycleDay: ${_this.cycleDay})';
}


}

/// @nodoc
abstract mixin class $DailyRewardClaimCopyWith<$Res>  {
  factory $DailyRewardClaimCopyWith(DailyRewardClaim value, $Res Function(DailyRewardClaim) _then) = _$DailyRewardClaimCopyWithImpl;
@useResult
$Res call({
 Reward reward, DailyRewardRecord record, int cycleDay
});


$RewardCopyWith<$Res> get reward;$DailyRewardRecordCopyWith<$Res> get record;

}
/// @nodoc
class _$DailyRewardClaimCopyWithImpl<$Res>
    implements $DailyRewardClaimCopyWith<$Res> {
  _$DailyRewardClaimCopyWithImpl(this._self, this._then);

  final DailyRewardClaim _self;
  final $Res Function(DailyRewardClaim) _then;

/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reward = null,Object? record = null,Object? cycleDay = null,}) {
  return _then(DailyRewardClaim(
reward: null == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as Reward,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as DailyRewardRecord,cycleDay: null == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardCopyWith<$Res> get reward {
  
  return $RewardCopyWith<$Res>(_self.reward, (value) {
    return _then(_self.copyWith(reward: value));
  });
}/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailyRewardRecordCopyWith<$Res> get record {
  
  return $DailyRewardRecordCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}


/// Adds pattern-matching-related methods to [DailyRewardClaim].
extension DailyRewardClaimPatterns on DailyRewardClaim {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyRewardClaim value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyRewardClaim() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyRewardClaim value)  $default,){
final _that = this;
switch (_that) {
case _DailyRewardClaim():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyRewardClaim value)?  $default,){
final _that = this;
switch (_that) {
case _DailyRewardClaim() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Reward reward,  DailyRewardRecord record,  int cycleDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyRewardClaim() when $default != null:
return $default(_that.reward,_that.record,_that.cycleDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Reward reward,  DailyRewardRecord record,  int cycleDay)  $default,) {final _that = this;
switch (_that) {
case _DailyRewardClaim():
return $default(_that.reward,_that.record,_that.cycleDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Reward reward,  DailyRewardRecord record,  int cycleDay)?  $default,) {final _that = this;
switch (_that) {
case _DailyRewardClaim() when $default != null:
return $default(_that.reward,_that.record,_that.cycleDay);case _:
  return null;

}
}

}

/// @nodoc


class _DailyRewardClaim implements DailyRewardClaim {
  const _DailyRewardClaim({required this.reward, required this.record, required this.cycleDay});
  

/// What was granted.
@override final  Reward reward;
/// The record to persist.
@override final  DailyRewardRecord record;
/// Day of the cycle (1-based) that was claimed.
@override final  int cycleDay;

/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyRewardClaimCopyWith<_DailyRewardClaim> get copyWith => __$DailyRewardClaimCopyWithImpl<_DailyRewardClaim>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyRewardClaim&&(identical(other.reward, reward) || other.reward == reward)&&(identical(other.record, record) || other.record == record)&&(identical(other.cycleDay, cycleDay) || other.cycleDay == cycleDay));
}


@override
int get hashCode {
    return Object.hash(runtimeType,reward,record,cycleDay);
}

@override
String toString() {
    return 'DailyRewardClaim(reward: $reward, record: $record, cycleDay: $cycleDay)';
}


}

/// @nodoc
abstract mixin class _$DailyRewardClaimCopyWith<$Res> implements $DailyRewardClaimCopyWith<$Res> {
  factory _$DailyRewardClaimCopyWith(_DailyRewardClaim value, $Res Function(_DailyRewardClaim) _then) = __$DailyRewardClaimCopyWithImpl;
@override @useResult
$Res call({
 Reward reward, DailyRewardRecord record, int cycleDay
});


@override $RewardCopyWith<$Res> get reward;@override $DailyRewardRecordCopyWith<$Res> get record;

}
/// @nodoc
class __$DailyRewardClaimCopyWithImpl<$Res>
    implements _$DailyRewardClaimCopyWith<$Res> {
  __$DailyRewardClaimCopyWithImpl(this._self, this._then);

  final _DailyRewardClaim _self;
  final $Res Function(_DailyRewardClaim) _then;

/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reward = null,Object? record = null,Object? cycleDay = null,}) {
  return _then(_DailyRewardClaim(
reward: null == reward ? _self.reward : reward // ignore: cast_nullable_to_non_nullable
as Reward,record: null == record ? _self.record : record // ignore: cast_nullable_to_non_nullable
as DailyRewardRecord,cycleDay: null == cycleDay ? _self.cycleDay : cycleDay // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RewardCopyWith<$Res> get reward {
  
  return $RewardCopyWith<$Res>(_self.reward, (value) {
    return _then(_self.copyWith(reward: value));
  });
}/// Create a copy of DailyRewardClaim
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailyRewardRecordCopyWith<$Res> get record {
  
  return $DailyRewardRecordCopyWith<$Res>(_self.record, (value) {
    return _then(_self.copyWith(record: value));
  });
}
}

// dart format on
