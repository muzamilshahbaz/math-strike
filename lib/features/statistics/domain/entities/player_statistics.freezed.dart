// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StatTotals {

 int get gamesPlayed; int get questionsAnswered; int get correctAnswers; int get timePlayedMs;/// Sum of per-question reaction times.
 int get reactionTimeMs; int get levelsCompleted;
/// Create a copy of StatTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatTotalsCopyWith<StatTotals> get copyWith => _$StatTotalsCopyWithImpl<StatTotals>(this as StatTotals, _$identity);

  /// Serializes this StatTotals to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StatTotals;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatTotals&&(identical(other.gamesPlayed, _this.gamesPlayed) || other.gamesPlayed == _this.gamesPlayed)&&(identical(other.questionsAnswered, _this.questionsAnswered) || other.questionsAnswered == _this.questionsAnswered)&&(identical(other.correctAnswers, _this.correctAnswers) || other.correctAnswers == _this.correctAnswers)&&(identical(other.timePlayedMs, _this.timePlayedMs) || other.timePlayedMs == _this.timePlayedMs)&&(identical(other.reactionTimeMs, _this.reactionTimeMs) || other.reactionTimeMs == _this.reactionTimeMs)&&(identical(other.levelsCompleted, _this.levelsCompleted) || other.levelsCompleted == _this.levelsCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StatTotals;
  return Object.hash(runtimeType,_this.gamesPlayed,_this.questionsAnswered,_this.correctAnswers,_this.timePlayedMs,_this.reactionTimeMs,_this.levelsCompleted);
}

@override
String toString() {
  final _this = this as StatTotals;
  return 'StatTotals(gamesPlayed: ${_this.gamesPlayed}, questionsAnswered: ${_this.questionsAnswered}, correctAnswers: ${_this.correctAnswers}, timePlayedMs: ${_this.timePlayedMs}, reactionTimeMs: ${_this.reactionTimeMs}, levelsCompleted: ${_this.levelsCompleted})';
}


}

/// @nodoc
abstract mixin class $StatTotalsCopyWith<$Res>  {
  factory $StatTotalsCopyWith(StatTotals value, $Res Function(StatTotals) _then) = _$StatTotalsCopyWithImpl;
@useResult
$Res call({
 int gamesPlayed, int questionsAnswered, int correctAnswers, int timePlayedMs, int reactionTimeMs, int levelsCompleted
});




}
/// @nodoc
class _$StatTotalsCopyWithImpl<$Res>
    implements $StatTotalsCopyWith<$Res> {
  _$StatTotalsCopyWithImpl(this._self, this._then);

  final StatTotals _self;
  final $Res Function(StatTotals) _then;

/// Create a copy of StatTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gamesPlayed = null,Object? questionsAnswered = null,Object? correctAnswers = null,Object? timePlayedMs = null,Object? reactionTimeMs = null,Object? levelsCompleted = null,}) {
  return _then(StatTotals(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,questionsAnswered: null == questionsAnswered ? _self.questionsAnswered : questionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,timePlayedMs: null == timePlayedMs ? _self.timePlayedMs : timePlayedMs // ignore: cast_nullable_to_non_nullable
as int,reactionTimeMs: null == reactionTimeMs ? _self.reactionTimeMs : reactionTimeMs // ignore: cast_nullable_to_non_nullable
as int,levelsCompleted: null == levelsCompleted ? _self.levelsCompleted : levelsCompleted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatTotals].
extension StatTotalsPatterns on StatTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatTotals value)  $default,){
final _that = this;
switch (_that) {
case _StatTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatTotals value)?  $default,){
final _that = this;
switch (_that) {
case _StatTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gamesPlayed,  int questionsAnswered,  int correctAnswers,  int timePlayedMs,  int reactionTimeMs,  int levelsCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatTotals() when $default != null:
return $default(_that.gamesPlayed,_that.questionsAnswered,_that.correctAnswers,_that.timePlayedMs,_that.reactionTimeMs,_that.levelsCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gamesPlayed,  int questionsAnswered,  int correctAnswers,  int timePlayedMs,  int reactionTimeMs,  int levelsCompleted)  $default,) {final _that = this;
switch (_that) {
case _StatTotals():
return $default(_that.gamesPlayed,_that.questionsAnswered,_that.correctAnswers,_that.timePlayedMs,_that.reactionTimeMs,_that.levelsCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gamesPlayed,  int questionsAnswered,  int correctAnswers,  int timePlayedMs,  int reactionTimeMs,  int levelsCompleted)?  $default,) {final _that = this;
switch (_that) {
case _StatTotals() when $default != null:
return $default(_that.gamesPlayed,_that.questionsAnswered,_that.correctAnswers,_that.timePlayedMs,_that.reactionTimeMs,_that.levelsCompleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatTotals extends StatTotals {
  const _StatTotals({this.gamesPlayed = 0, this.questionsAnswered = 0, this.correctAnswers = 0, this.timePlayedMs = 0, this.reactionTimeMs = 0, this.levelsCompleted = 0}): super._();
  factory _StatTotals.fromJson(Map<String, dynamic> json) => _$StatTotalsFromJson(json);

@override@JsonKey() final  int gamesPlayed;
@override@JsonKey() final  int questionsAnswered;
@override@JsonKey() final  int correctAnswers;
@override@JsonKey() final  int timePlayedMs;
/// Sum of per-question reaction times.
@override@JsonKey() final  int reactionTimeMs;
@override@JsonKey() final  int levelsCompleted;

/// Create a copy of StatTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatTotalsCopyWith<_StatTotals> get copyWith => __$StatTotalsCopyWithImpl<_StatTotals>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatTotalsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatTotals&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.questionsAnswered, questionsAnswered) || other.questionsAnswered == questionsAnswered)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.timePlayedMs, timePlayedMs) || other.timePlayedMs == timePlayedMs)&&(identical(other.reactionTimeMs, reactionTimeMs) || other.reactionTimeMs == reactionTimeMs)&&(identical(other.levelsCompleted, levelsCompleted) || other.levelsCompleted == levelsCompleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,gamesPlayed,questionsAnswered,correctAnswers,timePlayedMs,reactionTimeMs,levelsCompleted);
}

@override
String toString() {
    return 'StatTotals(gamesPlayed: $gamesPlayed, questionsAnswered: $questionsAnswered, correctAnswers: $correctAnswers, timePlayedMs: $timePlayedMs, reactionTimeMs: $reactionTimeMs, levelsCompleted: $levelsCompleted)';
}


}

/// @nodoc
abstract mixin class _$StatTotalsCopyWith<$Res> implements $StatTotalsCopyWith<$Res> {
  factory _$StatTotalsCopyWith(_StatTotals value, $Res Function(_StatTotals) _then) = __$StatTotalsCopyWithImpl;
@override @useResult
$Res call({
 int gamesPlayed, int questionsAnswered, int correctAnswers, int timePlayedMs, int reactionTimeMs, int levelsCompleted
});




}
/// @nodoc
class __$StatTotalsCopyWithImpl<$Res>
    implements _$StatTotalsCopyWith<$Res> {
  __$StatTotalsCopyWithImpl(this._self, this._then);

  final _StatTotals _self;
  final $Res Function(_StatTotals) _then;

/// Create a copy of StatTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gamesPlayed = null,Object? questionsAnswered = null,Object? correctAnswers = null,Object? timePlayedMs = null,Object? reactionTimeMs = null,Object? levelsCompleted = null,}) {
  return _then(_StatTotals(
gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,questionsAnswered: null == questionsAnswered ? _self.questionsAnswered : questionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,timePlayedMs: null == timePlayedMs ? _self.timePlayedMs : timePlayedMs // ignore: cast_nullable_to_non_nullable
as int,reactionTimeMs: null == reactionTimeMs ? _self.reactionTimeMs : reactionTimeMs // ignore: cast_nullable_to_non_nullable
as int,levelsCompleted: null == levelsCompleted ? _self.levelsCompleted : levelsCompleted // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PlayerStatistics {

 StatTotals get overall; Map<String, StatTotals> get days;/// Longest run of consecutive correct answers ever.
 int get bestStreak;/// Highest combo ever reached.
 int get highestCombo;/// When the last game ended.
 DateTime? get lastPlayedAt;
/// Create a copy of PlayerStatistics
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerStatisticsCopyWith<PlayerStatistics> get copyWith => _$PlayerStatisticsCopyWithImpl<PlayerStatistics>(this as PlayerStatistics, _$identity);

  /// Serializes this PlayerStatistics to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PlayerStatistics;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerStatistics&&(identical(other.overall, _this.overall) || other.overall == _this.overall)&&const DeepCollectionEquality().equals(other.days, _this.days)&&(identical(other.bestStreak, _this.bestStreak) || other.bestStreak == _this.bestStreak)&&(identical(other.highestCombo, _this.highestCombo) || other.highestCombo == _this.highestCombo)&&(identical(other.lastPlayedAt, _this.lastPlayedAt) || other.lastPlayedAt == _this.lastPlayedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PlayerStatistics;
  return Object.hash(runtimeType,_this.overall,const DeepCollectionEquality().hash(_this.days),_this.bestStreak,_this.highestCombo,_this.lastPlayedAt);
}

@override
String toString() {
  final _this = this as PlayerStatistics;
  return 'PlayerStatistics(overall: ${_this.overall}, days: ${_this.days}, bestStreak: ${_this.bestStreak}, highestCombo: ${_this.highestCombo}, lastPlayedAt: ${_this.lastPlayedAt})';
}


}

/// @nodoc
abstract mixin class $PlayerStatisticsCopyWith<$Res>  {
  factory $PlayerStatisticsCopyWith(PlayerStatistics value, $Res Function(PlayerStatistics) _then) = _$PlayerStatisticsCopyWithImpl;
@useResult
$Res call({
 StatTotals overall, Map<String, StatTotals> days, int bestStreak, int highestCombo, DateTime? lastPlayedAt
});


$StatTotalsCopyWith<$Res> get overall;

}
/// @nodoc
class _$PlayerStatisticsCopyWithImpl<$Res>
    implements $PlayerStatisticsCopyWith<$Res> {
  _$PlayerStatisticsCopyWithImpl(this._self, this._then);

  final PlayerStatistics _self;
  final $Res Function(PlayerStatistics) _then;

/// Create a copy of PlayerStatistics
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? overall = null,Object? days = null,Object? bestStreak = null,Object? highestCombo = null,Object? lastPlayedAt = freezed,}) {
  return _then(PlayerStatistics(
overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as StatTotals,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as Map<String, StatTotals>,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,highestCombo: null == highestCombo ? _self.highestCombo : highestCombo // ignore: cast_nullable_to_non_nullable
as int,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of PlayerStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatTotalsCopyWith<$Res> get overall {
  
  return $StatTotalsCopyWith<$Res>(_self.overall, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerStatistics].
extension PlayerStatisticsPatterns on PlayerStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerStatistics value)  $default,){
final _that = this;
switch (_that) {
case _PlayerStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StatTotals overall,  Map<String, StatTotals> days,  int bestStreak,  int highestCombo,  DateTime? lastPlayedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerStatistics() when $default != null:
return $default(_that.overall,_that.days,_that.bestStreak,_that.highestCombo,_that.lastPlayedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StatTotals overall,  Map<String, StatTotals> days,  int bestStreak,  int highestCombo,  DateTime? lastPlayedAt)  $default,) {final _that = this;
switch (_that) {
case _PlayerStatistics():
return $default(_that.overall,_that.days,_that.bestStreak,_that.highestCombo,_that.lastPlayedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StatTotals overall,  Map<String, StatTotals> days,  int bestStreak,  int highestCombo,  DateTime? lastPlayedAt)?  $default,) {final _that = this;
switch (_that) {
case _PlayerStatistics() when $default != null:
return $default(_that.overall,_that.days,_that.bestStreak,_that.highestCombo,_that.lastPlayedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerStatistics extends PlayerStatistics {
  const _PlayerStatistics({this.overall = const StatTotals(),  Map<String, StatTotals> days = const <String, StatTotals>{}, this.bestStreak = 0, this.highestCombo = 0, this.lastPlayedAt}): _days = days,super._();
  factory _PlayerStatistics.fromJson(Map<String, dynamic> json) => _$PlayerStatisticsFromJson(json);

@override@JsonKey() final  StatTotals overall;
 final  Map<String, StatTotals> _days;
@override@JsonKey() Map<String, StatTotals> get days {
  if (_days is EqualUnmodifiableMapView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_days);
}

/// Longest run of consecutive correct answers ever.
@override@JsonKey() final  int bestStreak;
/// Highest combo ever reached.
@override@JsonKey() final  int highestCombo;
/// When the last game ended.
@override final  DateTime? lastPlayedAt;

/// Create a copy of PlayerStatistics
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerStatisticsCopyWith<_PlayerStatistics> get copyWith => __$PlayerStatisticsCopyWithImpl<_PlayerStatistics>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerStatisticsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerStatistics&&(identical(other.overall, overall) || other.overall == overall)&&const DeepCollectionEquality().equals(other.days, _days)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.highestCombo, highestCombo) || other.highestCombo == highestCombo)&&(identical(other.lastPlayedAt, lastPlayedAt) || other.lastPlayedAt == lastPlayedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,overall,const DeepCollectionEquality().hash(_days),bestStreak,highestCombo,lastPlayedAt);
}

@override
String toString() {
    return 'PlayerStatistics(overall: $overall, days: $days, bestStreak: $bestStreak, highestCombo: $highestCombo, lastPlayedAt: $lastPlayedAt)';
}


}

/// @nodoc
abstract mixin class _$PlayerStatisticsCopyWith<$Res> implements $PlayerStatisticsCopyWith<$Res> {
  factory _$PlayerStatisticsCopyWith(_PlayerStatistics value, $Res Function(_PlayerStatistics) _then) = __$PlayerStatisticsCopyWithImpl;
@override @useResult
$Res call({
 StatTotals overall, Map<String, StatTotals> days, int bestStreak, int highestCombo, DateTime? lastPlayedAt
});


@override $StatTotalsCopyWith<$Res> get overall;

}
/// @nodoc
class __$PlayerStatisticsCopyWithImpl<$Res>
    implements _$PlayerStatisticsCopyWith<$Res> {
  __$PlayerStatisticsCopyWithImpl(this._self, this._then);

  final _PlayerStatistics _self;
  final $Res Function(_PlayerStatistics) _then;

/// Create a copy of PlayerStatistics
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? overall = null,Object? days = null,Object? bestStreak = null,Object? highestCombo = null,Object? lastPlayedAt = freezed,}) {
  return _then(_PlayerStatistics(
overall: null == overall ? _self.overall : overall // ignore: cast_nullable_to_non_nullable
as StatTotals,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as Map<String, StatTotals>,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,highestCombo: null == highestCombo ? _self.highestCombo : highestCombo // ignore: cast_nullable_to_non_nullable
as int,lastPlayedAt: freezed == lastPlayedAt ? _self.lastPlayedAt : lastPlayedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of PlayerStatistics
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StatTotalsCopyWith<$Res> get overall {
  
  return $StatTotalsCopyWith<$Res>(_self.overall, (value) {
    return _then(_self.copyWith(overall: value));
  });
}
}

// dart format on
