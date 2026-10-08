// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_session_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameSessionSummary {

/// When the game ended; decides which day it counts towards.
 DateTime get endedAt;/// Time actually spent playing.
 Duration get duration; int get questionsAnswered; int get correctAnswers;/// Sum of the time taken to answer each question.
 Duration get totalReactionTime;/// Longest run of consecutive correct answers.
 int get bestStreak;/// Highest combo multiplier reached.
 int get highestCombo;/// Whether the level was completed.
 bool get levelCompleted;
/// Create a copy of GameSessionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameSessionSummaryCopyWith<GameSessionSummary> get copyWith => _$GameSessionSummaryCopyWithImpl<GameSessionSummary>(this as GameSessionSummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GameSessionSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameSessionSummary&&(identical(other.endedAt, _this.endedAt) || other.endedAt == _this.endedAt)&&(identical(other.duration, _this.duration) || other.duration == _this.duration)&&(identical(other.questionsAnswered, _this.questionsAnswered) || other.questionsAnswered == _this.questionsAnswered)&&(identical(other.correctAnswers, _this.correctAnswers) || other.correctAnswers == _this.correctAnswers)&&(identical(other.totalReactionTime, _this.totalReactionTime) || other.totalReactionTime == _this.totalReactionTime)&&(identical(other.bestStreak, _this.bestStreak) || other.bestStreak == _this.bestStreak)&&(identical(other.highestCombo, _this.highestCombo) || other.highestCombo == _this.highestCombo)&&(identical(other.levelCompleted, _this.levelCompleted) || other.levelCompleted == _this.levelCompleted));
}


@override
int get hashCode {
  final _this = this as GameSessionSummary;
  return Object.hash(runtimeType,_this.endedAt,_this.duration,_this.questionsAnswered,_this.correctAnswers,_this.totalReactionTime,_this.bestStreak,_this.highestCombo,_this.levelCompleted);
}

@override
String toString() {
  final _this = this as GameSessionSummary;
  return 'GameSessionSummary(endedAt: ${_this.endedAt}, duration: ${_this.duration}, questionsAnswered: ${_this.questionsAnswered}, correctAnswers: ${_this.correctAnswers}, totalReactionTime: ${_this.totalReactionTime}, bestStreak: ${_this.bestStreak}, highestCombo: ${_this.highestCombo}, levelCompleted: ${_this.levelCompleted})';
}


}

/// @nodoc
abstract mixin class $GameSessionSummaryCopyWith<$Res>  {
  factory $GameSessionSummaryCopyWith(GameSessionSummary value, $Res Function(GameSessionSummary) _then) = _$GameSessionSummaryCopyWithImpl;
@useResult
$Res call({
 DateTime endedAt, Duration duration, int questionsAnswered, int correctAnswers, Duration totalReactionTime, int bestStreak, int highestCombo, bool levelCompleted
});




}
/// @nodoc
class _$GameSessionSummaryCopyWithImpl<$Res>
    implements $GameSessionSummaryCopyWith<$Res> {
  _$GameSessionSummaryCopyWithImpl(this._self, this._then);

  final GameSessionSummary _self;
  final $Res Function(GameSessionSummary) _then;

/// Create a copy of GameSessionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? endedAt = null,Object? duration = null,Object? questionsAnswered = null,Object? correctAnswers = null,Object? totalReactionTime = null,Object? bestStreak = null,Object? highestCombo = null,Object? levelCompleted = null,}) {
  return _then(GameSessionSummary(
endedAt: null == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,questionsAnswered: null == questionsAnswered ? _self.questionsAnswered : questionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,totalReactionTime: null == totalReactionTime ? _self.totalReactionTime : totalReactionTime // ignore: cast_nullable_to_non_nullable
as Duration,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,highestCombo: null == highestCombo ? _self.highestCombo : highestCombo // ignore: cast_nullable_to_non_nullable
as int,levelCompleted: null == levelCompleted ? _self.levelCompleted : levelCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [GameSessionSummary].
extension GameSessionSummaryPatterns on GameSessionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameSessionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameSessionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameSessionSummary value)  $default,){
final _that = this;
switch (_that) {
case _GameSessionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameSessionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _GameSessionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime endedAt,  Duration duration,  int questionsAnswered,  int correctAnswers,  Duration totalReactionTime,  int bestStreak,  int highestCombo,  bool levelCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameSessionSummary() when $default != null:
return $default(_that.endedAt,_that.duration,_that.questionsAnswered,_that.correctAnswers,_that.totalReactionTime,_that.bestStreak,_that.highestCombo,_that.levelCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime endedAt,  Duration duration,  int questionsAnswered,  int correctAnswers,  Duration totalReactionTime,  int bestStreak,  int highestCombo,  bool levelCompleted)  $default,) {final _that = this;
switch (_that) {
case _GameSessionSummary():
return $default(_that.endedAt,_that.duration,_that.questionsAnswered,_that.correctAnswers,_that.totalReactionTime,_that.bestStreak,_that.highestCombo,_that.levelCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime endedAt,  Duration duration,  int questionsAnswered,  int correctAnswers,  Duration totalReactionTime,  int bestStreak,  int highestCombo,  bool levelCompleted)?  $default,) {final _that = this;
switch (_that) {
case _GameSessionSummary() when $default != null:
return $default(_that.endedAt,_that.duration,_that.questionsAnswered,_that.correctAnswers,_that.totalReactionTime,_that.bestStreak,_that.highestCombo,_that.levelCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _GameSessionSummary implements GameSessionSummary {
  const _GameSessionSummary({required this.endedAt, required this.duration, required this.questionsAnswered, required this.correctAnswers, this.totalReactionTime = Duration.zero, this.bestStreak = 0, this.highestCombo = 0, this.levelCompleted = false}): assert(correctAnswers >= 0 && correctAnswers <= questionsAnswered);
  

/// When the game ended; decides which day it counts towards.
@override final  DateTime endedAt;
/// Time actually spent playing.
@override final  Duration duration;
@override final  int questionsAnswered;
@override final  int correctAnswers;
/// Sum of the time taken to answer each question.
@override@JsonKey() final  Duration totalReactionTime;
/// Longest run of consecutive correct answers.
@override@JsonKey() final  int bestStreak;
/// Highest combo multiplier reached.
@override@JsonKey() final  int highestCombo;
/// Whether the level was completed.
@override@JsonKey() final  bool levelCompleted;

/// Create a copy of GameSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameSessionSummaryCopyWith<_GameSessionSummary> get copyWith => __$GameSessionSummaryCopyWithImpl<_GameSessionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameSessionSummary&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.questionsAnswered, questionsAnswered) || other.questionsAnswered == questionsAnswered)&&(identical(other.correctAnswers, correctAnswers) || other.correctAnswers == correctAnswers)&&(identical(other.totalReactionTime, totalReactionTime) || other.totalReactionTime == totalReactionTime)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.highestCombo, highestCombo) || other.highestCombo == highestCombo)&&(identical(other.levelCompleted, levelCompleted) || other.levelCompleted == levelCompleted));
}


@override
int get hashCode {
    return Object.hash(runtimeType,endedAt,duration,questionsAnswered,correctAnswers,totalReactionTime,bestStreak,highestCombo,levelCompleted);
}

@override
String toString() {
    return 'GameSessionSummary(endedAt: $endedAt, duration: $duration, questionsAnswered: $questionsAnswered, correctAnswers: $correctAnswers, totalReactionTime: $totalReactionTime, bestStreak: $bestStreak, highestCombo: $highestCombo, levelCompleted: $levelCompleted)';
}


}

/// @nodoc
abstract mixin class _$GameSessionSummaryCopyWith<$Res> implements $GameSessionSummaryCopyWith<$Res> {
  factory _$GameSessionSummaryCopyWith(_GameSessionSummary value, $Res Function(_GameSessionSummary) _then) = __$GameSessionSummaryCopyWithImpl;
@override @useResult
$Res call({
 DateTime endedAt, Duration duration, int questionsAnswered, int correctAnswers, Duration totalReactionTime, int bestStreak, int highestCombo, bool levelCompleted
});




}
/// @nodoc
class __$GameSessionSummaryCopyWithImpl<$Res>
    implements _$GameSessionSummaryCopyWith<$Res> {
  __$GameSessionSummaryCopyWithImpl(this._self, this._then);

  final _GameSessionSummary _self;
  final $Res Function(_GameSessionSummary) _then;

/// Create a copy of GameSessionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? endedAt = null,Object? duration = null,Object? questionsAnswered = null,Object? correctAnswers = null,Object? totalReactionTime = null,Object? bestStreak = null,Object? highestCombo = null,Object? levelCompleted = null,}) {
  return _then(_GameSessionSummary(
endedAt: null == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,questionsAnswered: null == questionsAnswered ? _self.questionsAnswered : questionsAnswered // ignore: cast_nullable_to_non_nullable
as int,correctAnswers: null == correctAnswers ? _self.correctAnswers : correctAnswers // ignore: cast_nullable_to_non_nullable
as int,totalReactionTime: null == totalReactionTime ? _self.totalReactionTime : totalReactionTime // ignore: cast_nullable_to_non_nullable
as Duration,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,highestCombo: null == highestCombo ? _self.highestCombo : highestCombo // ignore: cast_nullable_to_non_nullable
as int,levelCompleted: null == levelCompleted ? _self.levelCompleted : levelCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
