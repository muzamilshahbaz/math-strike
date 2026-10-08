// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'question.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Question {

 MathTopic get topic;/// Difficulty level, 1–10.
 int get level;/// The question text, e.g. `7 + 5 = ?`.
 String get prompt;/// Answer options in display order.
 List<String> get choices;/// Index of the correct option in [choices].
 int get answerIndex;/// A nudge in the right direction, shown on request.
 String get hint;/// How to get the answer, shown after answering.
 String get explanation;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Question;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.topic, _this.topic) || other.topic == _this.topic)&&(identical(other.level, _this.level) || other.level == _this.level)&&(identical(other.prompt, _this.prompt) || other.prompt == _this.prompt)&&const DeepCollectionEquality().equals(other.choices, _this.choices)&&(identical(other.answerIndex, _this.answerIndex) || other.answerIndex == _this.answerIndex)&&(identical(other.hint, _this.hint) || other.hint == _this.hint)&&(identical(other.explanation, _this.explanation) || other.explanation == _this.explanation));
}


@override
int get hashCode {
  final _this = this as Question;
  return Object.hash(runtimeType,_this.topic,_this.level,_this.prompt,const DeepCollectionEquality().hash(_this.choices),_this.answerIndex,_this.hint,_this.explanation);
}

@override
String toString() {
  final _this = this as Question;
  return 'Question(topic: ${_this.topic}, level: ${_this.level}, prompt: ${_this.prompt}, choices: ${_this.choices}, answerIndex: ${_this.answerIndex}, hint: ${_this.hint}, explanation: ${_this.explanation})';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 MathTopic topic, int level, String prompt, List<String> choices, int answerIndex, String hint, String explanation
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topic = null,Object? level = null,Object? prompt = null,Object? choices = null,Object? answerIndex = null,Object? hint = null,Object? explanation = null,}) {
  return _then(Question(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as MathTopic,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self.choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MathTopic topic,  int level,  String prompt,  List<String> choices,  int answerIndex,  String hint,  String explanation)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.topic,_that.level,_that.prompt,_that.choices,_that.answerIndex,_that.hint,_that.explanation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MathTopic topic,  int level,  String prompt,  List<String> choices,  int answerIndex,  String hint,  String explanation)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.topic,_that.level,_that.prompt,_that.choices,_that.answerIndex,_that.hint,_that.explanation);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MathTopic topic,  int level,  String prompt,  List<String> choices,  int answerIndex,  String hint,  String explanation)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.topic,_that.level,_that.prompt,_that.choices,_that.answerIndex,_that.hint,_that.explanation);case _:
  return null;

}
}

}

/// @nodoc


class _Question extends Question {
  const _Question({required this.topic, required this.level, required this.prompt, required  List<String> choices, required this.answerIndex, required this.hint, required this.explanation}): assert(answerIndex >= 0 && answerIndex < choices.length),_choices = choices,super._();
  

@override final  MathTopic topic;
/// Difficulty level, 1–10.
@override final  int level;
/// The question text, e.g. `7 + 5 = ?`.
@override final  String prompt;
/// Answer options in display order.
 final  List<String> _choices;
/// Answer options in display order.
@override List<String> get choices {
  if (_choices is EqualUnmodifiableListView) return _choices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_choices);
}

/// Index of the correct option in [choices].
@override final  int answerIndex;
/// A nudge in the right direction, shown on request.
@override final  String hint;
/// How to get the answer, shown after answering.
@override final  String explanation;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.topic, topic) || other.topic == topic)&&(identical(other.level, level) || other.level == level)&&(identical(other.prompt, prompt) || other.prompt == prompt)&&const DeepCollectionEquality().equals(other.choices, _choices)&&(identical(other.answerIndex, answerIndex) || other.answerIndex == answerIndex)&&(identical(other.hint, hint) || other.hint == hint)&&(identical(other.explanation, explanation) || other.explanation == explanation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,topic,level,prompt,const DeepCollectionEquality().hash(_choices),answerIndex,hint,explanation);
}

@override
String toString() {
    return 'Question(topic: $topic, level: $level, prompt: $prompt, choices: $choices, answerIndex: $answerIndex, hint: $hint, explanation: $explanation)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 MathTopic topic, int level, String prompt, List<String> choices, int answerIndex, String hint, String explanation
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topic = null,Object? level = null,Object? prompt = null,Object? choices = null,Object? answerIndex = null,Object? hint = null,Object? explanation = null,}) {
  return _then(_Question(
topic: null == topic ? _self.topic : topic // ignore: cast_nullable_to_non_nullable
as MathTopic,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as int,prompt: null == prompt ? _self.prompt : prompt // ignore: cast_nullable_to_non_nullable
as String,choices: null == choices ? _self._choices : choices // ignore: cast_nullable_to_non_nullable
as List<String>,answerIndex: null == answerIndex ? _self.answerIndex : answerIndex // ignore: cast_nullable_to_non_nullable
as int,hint: null == hint ? _self.hint : hint // ignore: cast_nullable_to_non_nullable
as String,explanation: null == explanation ? _self.explanation : explanation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
