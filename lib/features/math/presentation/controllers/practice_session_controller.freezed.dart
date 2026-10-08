// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'practice_session_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PracticeAnswer {

 Question get question; int get selectedIndex; Duration get reactionTime; bool get usedHint;
/// Create a copy of PracticeAnswer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeAnswerCopyWith<PracticeAnswer> get copyWith => _$PracticeAnswerCopyWithImpl<PracticeAnswer>(this as PracticeAnswer, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PracticeAnswer;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeAnswer&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.selectedIndex, _this.selectedIndex) || other.selectedIndex == _this.selectedIndex)&&(identical(other.reactionTime, _this.reactionTime) || other.reactionTime == _this.reactionTime)&&(identical(other.usedHint, _this.usedHint) || other.usedHint == _this.usedHint));
}


@override
int get hashCode {
  final _this = this as PracticeAnswer;
  return Object.hash(runtimeType,_this.question,_this.selectedIndex,_this.reactionTime,_this.usedHint);
}

@override
String toString() {
  final _this = this as PracticeAnswer;
  return 'PracticeAnswer(question: ${_this.question}, selectedIndex: ${_this.selectedIndex}, reactionTime: ${_this.reactionTime}, usedHint: ${_this.usedHint})';
}


}

/// @nodoc
abstract mixin class $PracticeAnswerCopyWith<$Res>  {
  factory $PracticeAnswerCopyWith(PracticeAnswer value, $Res Function(PracticeAnswer) _then) = _$PracticeAnswerCopyWithImpl;
@useResult
$Res call({
 Question question, int selectedIndex, Duration reactionTime, bool usedHint
});


$QuestionCopyWith<$Res> get question;

}
/// @nodoc
class _$PracticeAnswerCopyWithImpl<$Res>
    implements $PracticeAnswerCopyWith<$Res> {
  _$PracticeAnswerCopyWithImpl(this._self, this._then);

  final PracticeAnswer _self;
  final $Res Function(PracticeAnswer) _then;

/// Create a copy of PracticeAnswer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? question = null,Object? selectedIndex = null,Object? reactionTime = null,Object? usedHint = null,}) {
  return _then(PracticeAnswer(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as Question,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,reactionTime: null == reactionTime ? _self.reactionTime : reactionTime // ignore: cast_nullable_to_non_nullable
as Duration,usedHint: null == usedHint ? _self.usedHint : usedHint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PracticeAnswer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionCopyWith<$Res> get question {
  
  return $QuestionCopyWith<$Res>(_self.question, (value) {
    return _then(_self.copyWith(question: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeAnswer].
extension PracticeAnswerPatterns on PracticeAnswer {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeAnswer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeAnswer() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeAnswer value)  $default,){
final _that = this;
switch (_that) {
case _PracticeAnswer():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeAnswer value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeAnswer() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Question question,  int selectedIndex,  Duration reactionTime,  bool usedHint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeAnswer() when $default != null:
return $default(_that.question,_that.selectedIndex,_that.reactionTime,_that.usedHint);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Question question,  int selectedIndex,  Duration reactionTime,  bool usedHint)  $default,) {final _that = this;
switch (_that) {
case _PracticeAnswer():
return $default(_that.question,_that.selectedIndex,_that.reactionTime,_that.usedHint);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Question question,  int selectedIndex,  Duration reactionTime,  bool usedHint)?  $default,) {final _that = this;
switch (_that) {
case _PracticeAnswer() when $default != null:
return $default(_that.question,_that.selectedIndex,_that.reactionTime,_that.usedHint);case _:
  return null;

}
}

}

/// @nodoc


class _PracticeAnswer extends PracticeAnswer {
  const _PracticeAnswer({required this.question, required this.selectedIndex, required this.reactionTime, this.usedHint = false}): super._();
  

@override final  Question question;
@override final  int selectedIndex;
@override final  Duration reactionTime;
@override@JsonKey() final  bool usedHint;

/// Create a copy of PracticeAnswer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeAnswerCopyWith<_PracticeAnswer> get copyWith => __$PracticeAnswerCopyWithImpl<_PracticeAnswer>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeAnswer&&(identical(other.question, question) || other.question == question)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.reactionTime, reactionTime) || other.reactionTime == reactionTime)&&(identical(other.usedHint, usedHint) || other.usedHint == usedHint));
}


@override
int get hashCode {
    return Object.hash(runtimeType,question,selectedIndex,reactionTime,usedHint);
}

@override
String toString() {
    return 'PracticeAnswer(question: $question, selectedIndex: $selectedIndex, reactionTime: $reactionTime, usedHint: $usedHint)';
}


}

/// @nodoc
abstract mixin class _$PracticeAnswerCopyWith<$Res> implements $PracticeAnswerCopyWith<$Res> {
  factory _$PracticeAnswerCopyWith(_PracticeAnswer value, $Res Function(_PracticeAnswer) _then) = __$PracticeAnswerCopyWithImpl;
@override @useResult
$Res call({
 Question question, int selectedIndex, Duration reactionTime, bool usedHint
});


@override $QuestionCopyWith<$Res> get question;

}
/// @nodoc
class __$PracticeAnswerCopyWithImpl<$Res>
    implements _$PracticeAnswerCopyWith<$Res> {
  __$PracticeAnswerCopyWithImpl(this._self, this._then);

  final _PracticeAnswer _self;
  final $Res Function(_PracticeAnswer) _then;

/// Create a copy of PracticeAnswer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? question = null,Object? selectedIndex = null,Object? reactionTime = null,Object? usedHint = null,}) {
  return _then(_PracticeAnswer(
question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as Question,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,reactionTime: null == reactionTime ? _self.reactionTime : reactionTime // ignore: cast_nullable_to_non_nullable
as Duration,usedHint: null == usedHint ? _self.usedHint : usedHint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PracticeAnswer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionCopyWith<$Res> get question {
  
  return $QuestionCopyWith<$Res>(_self.question, (value) {
    return _then(_self.copyWith(question: value));
  });
}
}

/// @nodoc
mixin _$PracticeSession {

/// The topic being practised, or `null` for a recommended mix.
 MathTopic? get focus; Question get question;/// 1-based number of the current question.
 int get number; int get total;/// The option chosen for the current question, once answered.
 int? get selected; bool get hintShown; List<PracticeAnswer> get answers; int get streak; int get bestStreak;/// Each practised topic's level before its first answer this session.
 Map<MathTopic, int> get startLevels; DateTime get startedAt; DateTime get questionShownAt; bool get finished;
/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PracticeSessionCopyWith<PracticeSession> get copyWith => _$PracticeSessionCopyWithImpl<PracticeSession>(this as PracticeSession, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PracticeSession;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PracticeSession&&(identical(other.focus, _this.focus) || other.focus == _this.focus)&&(identical(other.question, _this.question) || other.question == _this.question)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.selected, _this.selected) || other.selected == _this.selected)&&(identical(other.hintShown, _this.hintShown) || other.hintShown == _this.hintShown)&&const DeepCollectionEquality().equals(other.answers, _this.answers)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.bestStreak, _this.bestStreak) || other.bestStreak == _this.bestStreak)&&const DeepCollectionEquality().equals(other.startLevels, _this.startLevels)&&(identical(other.startedAt, _this.startedAt) || other.startedAt == _this.startedAt)&&(identical(other.questionShownAt, _this.questionShownAt) || other.questionShownAt == _this.questionShownAt)&&(identical(other.finished, _this.finished) || other.finished == _this.finished));
}


@override
int get hashCode {
  final _this = this as PracticeSession;
  return Object.hash(runtimeType,_this.focus,_this.question,_this.number,_this.total,_this.selected,_this.hintShown,const DeepCollectionEquality().hash(_this.answers),_this.streak,_this.bestStreak,const DeepCollectionEquality().hash(_this.startLevels),_this.startedAt,_this.questionShownAt,_this.finished);
}

@override
String toString() {
  final _this = this as PracticeSession;
  return 'PracticeSession(focus: ${_this.focus}, question: ${_this.question}, number: ${_this.number}, total: ${_this.total}, selected: ${_this.selected}, hintShown: ${_this.hintShown}, answers: ${_this.answers}, streak: ${_this.streak}, bestStreak: ${_this.bestStreak}, startLevels: ${_this.startLevels}, startedAt: ${_this.startedAt}, questionShownAt: ${_this.questionShownAt}, finished: ${_this.finished})';
}


}

/// @nodoc
abstract mixin class $PracticeSessionCopyWith<$Res>  {
  factory $PracticeSessionCopyWith(PracticeSession value, $Res Function(PracticeSession) _then) = _$PracticeSessionCopyWithImpl;
@useResult
$Res call({
 MathTopic? focus, Question question, int number, int total, int? selected, bool hintShown, List<PracticeAnswer> answers, int streak, int bestStreak, Map<MathTopic, int> startLevels, DateTime startedAt, DateTime questionShownAt, bool finished
});


$QuestionCopyWith<$Res> get question;

}
/// @nodoc
class _$PracticeSessionCopyWithImpl<$Res>
    implements $PracticeSessionCopyWith<$Res> {
  _$PracticeSessionCopyWithImpl(this._self, this._then);

  final PracticeSession _self;
  final $Res Function(PracticeSession) _then;

/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? focus = freezed,Object? question = null,Object? number = null,Object? total = null,Object? selected = freezed,Object? hintShown = null,Object? answers = null,Object? streak = null,Object? bestStreak = null,Object? startLevels = null,Object? startedAt = null,Object? questionShownAt = null,Object? finished = null,}) {
  return _then(PracticeSession(
focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as MathTopic?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as Question,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as int?,hintShown: null == hintShown ? _self.hintShown : hintShown // ignore: cast_nullable_to_non_nullable
as bool,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as List<PracticeAnswer>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,startLevels: null == startLevels ? _self.startLevels : startLevels // ignore: cast_nullable_to_non_nullable
as Map<MathTopic, int>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,questionShownAt: null == questionShownAt ? _self.questionShownAt : questionShownAt // ignore: cast_nullable_to_non_nullable
as DateTime,finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionCopyWith<$Res> get question {
  
  return $QuestionCopyWith<$Res>(_self.question, (value) {
    return _then(_self.copyWith(question: value));
  });
}
}


/// Adds pattern-matching-related methods to [PracticeSession].
extension PracticeSessionPatterns on PracticeSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PracticeSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PracticeSession value)  $default,){
final _that = this;
switch (_that) {
case _PracticeSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PracticeSession value)?  $default,){
final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MathTopic? focus,  Question question,  int number,  int total,  int? selected,  bool hintShown,  List<PracticeAnswer> answers,  int streak,  int bestStreak,  Map<MathTopic, int> startLevels,  DateTime startedAt,  DateTime questionShownAt,  bool finished)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
return $default(_that.focus,_that.question,_that.number,_that.total,_that.selected,_that.hintShown,_that.answers,_that.streak,_that.bestStreak,_that.startLevels,_that.startedAt,_that.questionShownAt,_that.finished);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MathTopic? focus,  Question question,  int number,  int total,  int? selected,  bool hintShown,  List<PracticeAnswer> answers,  int streak,  int bestStreak,  Map<MathTopic, int> startLevels,  DateTime startedAt,  DateTime questionShownAt,  bool finished)  $default,) {final _that = this;
switch (_that) {
case _PracticeSession():
return $default(_that.focus,_that.question,_that.number,_that.total,_that.selected,_that.hintShown,_that.answers,_that.streak,_that.bestStreak,_that.startLevels,_that.startedAt,_that.questionShownAt,_that.finished);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MathTopic? focus,  Question question,  int number,  int total,  int? selected,  bool hintShown,  List<PracticeAnswer> answers,  int streak,  int bestStreak,  Map<MathTopic, int> startLevels,  DateTime startedAt,  DateTime questionShownAt,  bool finished)?  $default,) {final _that = this;
switch (_that) {
case _PracticeSession() when $default != null:
return $default(_that.focus,_that.question,_that.number,_that.total,_that.selected,_that.hintShown,_that.answers,_that.streak,_that.bestStreak,_that.startLevels,_that.startedAt,_that.questionShownAt,_that.finished);case _:
  return null;

}
}

}

/// @nodoc


class _PracticeSession extends PracticeSession {
  const _PracticeSession({this.focus, required this.question, this.number = 1, required this.total, this.selected, this.hintShown = false,  List<PracticeAnswer> answers = const <PracticeAnswer>[], this.streak = 0, this.bestStreak = 0,  Map<MathTopic, int> startLevels = const <MathTopic, int>{}, required this.startedAt, required this.questionShownAt, this.finished = false}): _answers = answers,_startLevels = startLevels,super._();
  

/// The topic being practised, or `null` for a recommended mix.
@override final  MathTopic? focus;
@override final  Question question;
/// 1-based number of the current question.
@override@JsonKey() final  int number;
@override final  int total;
/// The option chosen for the current question, once answered.
@override final  int? selected;
@override@JsonKey() final  bool hintShown;
 final  List<PracticeAnswer> _answers;
@override@JsonKey() List<PracticeAnswer> get answers {
  if (_answers is EqualUnmodifiableListView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_answers);
}

@override@JsonKey() final  int streak;
@override@JsonKey() final  int bestStreak;
/// Each practised topic's level before its first answer this session.
 final  Map<MathTopic, int> _startLevels;
/// Each practised topic's level before its first answer this session.
@override@JsonKey() Map<MathTopic, int> get startLevels {
  if (_startLevels is EqualUnmodifiableMapView) return _startLevels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_startLevels);
}

@override final  DateTime startedAt;
@override final  DateTime questionShownAt;
@override@JsonKey() final  bool finished;

/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PracticeSessionCopyWith<_PracticeSession> get copyWith => __$PracticeSessionCopyWithImpl<_PracticeSession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PracticeSession&&(identical(other.focus, focus) || other.focus == focus)&&(identical(other.question, question) || other.question == question)&&(identical(other.number, number) || other.number == number)&&(identical(other.total, total) || other.total == total)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.hintShown, hintShown) || other.hintShown == hintShown)&&const DeepCollectionEquality().equals(other.answers, _answers)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&const DeepCollectionEquality().equals(other.startLevels, _startLevels)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.questionShownAt, questionShownAt) || other.questionShownAt == questionShownAt)&&(identical(other.finished, finished) || other.finished == finished));
}


@override
int get hashCode {
    return Object.hash(runtimeType,focus,question,number,total,selected,hintShown,const DeepCollectionEquality().hash(_answers),streak,bestStreak,const DeepCollectionEquality().hash(_startLevels),startedAt,questionShownAt,finished);
}

@override
String toString() {
    return 'PracticeSession(focus: $focus, question: $question, number: $number, total: $total, selected: $selected, hintShown: $hintShown, answers: $answers, streak: $streak, bestStreak: $bestStreak, startLevels: $startLevels, startedAt: $startedAt, questionShownAt: $questionShownAt, finished: $finished)';
}


}

/// @nodoc
abstract mixin class _$PracticeSessionCopyWith<$Res> implements $PracticeSessionCopyWith<$Res> {
  factory _$PracticeSessionCopyWith(_PracticeSession value, $Res Function(_PracticeSession) _then) = __$PracticeSessionCopyWithImpl;
@override @useResult
$Res call({
 MathTopic? focus, Question question, int number, int total, int? selected, bool hintShown, List<PracticeAnswer> answers, int streak, int bestStreak, Map<MathTopic, int> startLevels, DateTime startedAt, DateTime questionShownAt, bool finished
});


@override $QuestionCopyWith<$Res> get question;

}
/// @nodoc
class __$PracticeSessionCopyWithImpl<$Res>
    implements _$PracticeSessionCopyWith<$Res> {
  __$PracticeSessionCopyWithImpl(this._self, this._then);

  final _PracticeSession _self;
  final $Res Function(_PracticeSession) _then;

/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? focus = freezed,Object? question = null,Object? number = null,Object? total = null,Object? selected = freezed,Object? hintShown = null,Object? answers = null,Object? streak = null,Object? bestStreak = null,Object? startLevels = null,Object? startedAt = null,Object? questionShownAt = null,Object? finished = null,}) {
  return _then(_PracticeSession(
focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as MathTopic?,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as Question,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as int?,hintShown: null == hintShown ? _self.hintShown : hintShown // ignore: cast_nullable_to_non_nullable
as bool,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as List<PracticeAnswer>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,bestStreak: null == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as int,startLevels: null == startLevels ? _self._startLevels : startLevels // ignore: cast_nullable_to_non_nullable
as Map<MathTopic, int>,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,questionShownAt: null == questionShownAt ? _self.questionShownAt : questionShownAt // ignore: cast_nullable_to_non_nullable
as DateTime,finished: null == finished ? _self.finished : finished // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PracticeSession
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuestionCopyWith<$Res> get question {
  
  return $QuestionCopyWith<$Res>(_self.question, (value) {
    return _then(_self.copyWith(question: value));
  });
}
}

// dart format on
