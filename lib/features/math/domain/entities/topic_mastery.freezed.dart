// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic_mastery.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TopicMastery {

/// Continuous skill estimate; the whole part is the level (1–10).
 double get rating; int get attempts; int get correct;/// Most recent results, oldest first (at most [recentWindow]).
 List<bool> get recent;/// Current run of correct answers.
 int get streak; DateTime? get lastPracticedAt;
/// Create a copy of TopicMastery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TopicMasteryCopyWith<TopicMastery> get copyWith => _$TopicMasteryCopyWithImpl<TopicMastery>(this as TopicMastery, _$identity);

  /// Serializes this TopicMastery to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TopicMastery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TopicMastery&&(identical(other.rating, _this.rating) || other.rating == _this.rating)&&(identical(other.attempts, _this.attempts) || other.attempts == _this.attempts)&&(identical(other.correct, _this.correct) || other.correct == _this.correct)&&const DeepCollectionEquality().equals(other.recent, _this.recent)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.lastPracticedAt, _this.lastPracticedAt) || other.lastPracticedAt == _this.lastPracticedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TopicMastery;
  return Object.hash(runtimeType,_this.rating,_this.attempts,_this.correct,const DeepCollectionEquality().hash(_this.recent),_this.streak,_this.lastPracticedAt);
}

@override
String toString() {
  final _this = this as TopicMastery;
  return 'TopicMastery(rating: ${_this.rating}, attempts: ${_this.attempts}, correct: ${_this.correct}, recent: ${_this.recent}, streak: ${_this.streak}, lastPracticedAt: ${_this.lastPracticedAt})';
}


}

/// @nodoc
abstract mixin class $TopicMasteryCopyWith<$Res>  {
  factory $TopicMasteryCopyWith(TopicMastery value, $Res Function(TopicMastery) _then) = _$TopicMasteryCopyWithImpl;
@useResult
$Res call({
 double rating, int attempts, int correct, List<bool> recent, int streak, DateTime? lastPracticedAt
});




}
/// @nodoc
class _$TopicMasteryCopyWithImpl<$Res>
    implements $TopicMasteryCopyWith<$Res> {
  _$TopicMasteryCopyWithImpl(this._self, this._then);

  final TopicMastery _self;
  final $Res Function(TopicMastery) _then;

/// Create a copy of TopicMastery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rating = null,Object? attempts = null,Object? correct = null,Object? recent = null,Object? streak = null,Object? lastPracticedAt = freezed,}) {
  return _then(TopicMastery(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,recent: null == recent ? _self.recent : recent // ignore: cast_nullable_to_non_nullable
as List<bool>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,lastPracticedAt: freezed == lastPracticedAt ? _self.lastPracticedAt : lastPracticedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TopicMastery].
extension TopicMasteryPatterns on TopicMastery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TopicMastery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TopicMastery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TopicMastery value)  $default,){
final _that = this;
switch (_that) {
case _TopicMastery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TopicMastery value)?  $default,){
final _that = this;
switch (_that) {
case _TopicMastery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double rating,  int attempts,  int correct,  List<bool> recent,  int streak,  DateTime? lastPracticedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TopicMastery() when $default != null:
return $default(_that.rating,_that.attempts,_that.correct,_that.recent,_that.streak,_that.lastPracticedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double rating,  int attempts,  int correct,  List<bool> recent,  int streak,  DateTime? lastPracticedAt)  $default,) {final _that = this;
switch (_that) {
case _TopicMastery():
return $default(_that.rating,_that.attempts,_that.correct,_that.recent,_that.streak,_that.lastPracticedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double rating,  int attempts,  int correct,  List<bool> recent,  int streak,  DateTime? lastPracticedAt)?  $default,) {final _that = this;
switch (_that) {
case _TopicMastery() when $default != null:
return $default(_that.rating,_that.attempts,_that.correct,_that.recent,_that.streak,_that.lastPracticedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TopicMastery extends TopicMastery {
  const _TopicMastery({required this.rating, this.attempts = 0, this.correct = 0,  List<bool> recent = const <bool>[], this.streak = 0, this.lastPracticedAt}): _recent = recent,super._();
  factory _TopicMastery.fromJson(Map<String, dynamic> json) => _$TopicMasteryFromJson(json);

/// Continuous skill estimate; the whole part is the level (1–10).
@override final  double rating;
@override@JsonKey() final  int attempts;
@override@JsonKey() final  int correct;
/// Most recent results, oldest first (at most [recentWindow]).
 final  List<bool> _recent;
/// Most recent results, oldest first (at most [recentWindow]).
@override@JsonKey() List<bool> get recent {
  if (_recent is EqualUnmodifiableListView) return _recent;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recent);
}

/// Current run of correct answers.
@override@JsonKey() final  int streak;
@override final  DateTime? lastPracticedAt;

/// Create a copy of TopicMastery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TopicMasteryCopyWith<_TopicMastery> get copyWith => __$TopicMasteryCopyWithImpl<_TopicMastery>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TopicMasteryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TopicMastery&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.attempts, attempts) || other.attempts == attempts)&&(identical(other.correct, correct) || other.correct == correct)&&const DeepCollectionEquality().equals(other.recent, _recent)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.lastPracticedAt, lastPracticedAt) || other.lastPracticedAt == lastPracticedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,rating,attempts,correct,const DeepCollectionEquality().hash(_recent),streak,lastPracticedAt);
}

@override
String toString() {
    return 'TopicMastery(rating: $rating, attempts: $attempts, correct: $correct, recent: $recent, streak: $streak, lastPracticedAt: $lastPracticedAt)';
}


}

/// @nodoc
abstract mixin class _$TopicMasteryCopyWith<$Res> implements $TopicMasteryCopyWith<$Res> {
  factory _$TopicMasteryCopyWith(_TopicMastery value, $Res Function(_TopicMastery) _then) = __$TopicMasteryCopyWithImpl;
@override @useResult
$Res call({
 double rating, int attempts, int correct, List<bool> recent, int streak, DateTime? lastPracticedAt
});




}
/// @nodoc
class __$TopicMasteryCopyWithImpl<$Res>
    implements _$TopicMasteryCopyWith<$Res> {
  __$TopicMasteryCopyWithImpl(this._self, this._then);

  final _TopicMastery _self;
  final $Res Function(_TopicMastery) _then;

/// Create a copy of TopicMastery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rating = null,Object? attempts = null,Object? correct = null,Object? recent = null,Object? streak = null,Object? lastPracticedAt = freezed,}) {
  return _then(_TopicMastery(
rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,attempts: null == attempts ? _self.attempts : attempts // ignore: cast_nullable_to_non_nullable
as int,correct: null == correct ? _self.correct : correct // ignore: cast_nullable_to_non_nullable
as int,recent: null == recent ? _self._recent : recent // ignore: cast_nullable_to_non_nullable
as List<bool>,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as int,lastPracticedAt: freezed == lastPracticedAt ? _self.lastPracticedAt : lastPracticedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$LearningProgress {

/// Keyed by [MathTopic.name]; unknown names (from newer app versions)
/// are kept but ignored.
 Map<String, TopicMastery> get topics;
/// Create a copy of LearningProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LearningProgressCopyWith<LearningProgress> get copyWith => _$LearningProgressCopyWithImpl<LearningProgress>(this as LearningProgress, _$identity);

  /// Serializes this LearningProgress to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as LearningProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LearningProgress&&const DeepCollectionEquality().equals(other.topics, _this.topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as LearningProgress;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.topics));
}

@override
String toString() {
  final _this = this as LearningProgress;
  return 'LearningProgress(topics: ${_this.topics})';
}


}

/// @nodoc
abstract mixin class $LearningProgressCopyWith<$Res>  {
  factory $LearningProgressCopyWith(LearningProgress value, $Res Function(LearningProgress) _then) = _$LearningProgressCopyWithImpl;
@useResult
$Res call({
 Map<String, TopicMastery> topics
});




}
/// @nodoc
class _$LearningProgressCopyWithImpl<$Res>
    implements $LearningProgressCopyWith<$Res> {
  _$LearningProgressCopyWithImpl(this._self, this._then);

  final LearningProgress _self;
  final $Res Function(LearningProgress) _then;

/// Create a copy of LearningProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topics = null,}) {
  return _then(LearningProgress(
topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as Map<String, TopicMastery>,
  ));
}

}


/// Adds pattern-matching-related methods to [LearningProgress].
extension LearningProgressPatterns on LearningProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LearningProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LearningProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LearningProgress value)  $default,){
final _that = this;
switch (_that) {
case _LearningProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LearningProgress value)?  $default,){
final _that = this;
switch (_that) {
case _LearningProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, TopicMastery> topics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LearningProgress() when $default != null:
return $default(_that.topics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, TopicMastery> topics)  $default,) {final _that = this;
switch (_that) {
case _LearningProgress():
return $default(_that.topics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, TopicMastery> topics)?  $default,) {final _that = this;
switch (_that) {
case _LearningProgress() when $default != null:
return $default(_that.topics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LearningProgress extends LearningProgress {
  const _LearningProgress({ Map<String, TopicMastery> topics = const <String, TopicMastery>{}}): _topics = topics,super._();
  factory _LearningProgress.fromJson(Map<String, dynamic> json) => _$LearningProgressFromJson(json);

/// Keyed by [MathTopic.name]; unknown names (from newer app versions)
/// are kept but ignored.
 final  Map<String, TopicMastery> _topics;
/// Keyed by [MathTopic.name]; unknown names (from newer app versions)
/// are kept but ignored.
@override@JsonKey() Map<String, TopicMastery> get topics {
  if (_topics is EqualUnmodifiableMapView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_topics);
}


/// Create a copy of LearningProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LearningProgressCopyWith<_LearningProgress> get copyWith => __$LearningProgressCopyWithImpl<_LearningProgress>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LearningProgressToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LearningProgress&&const DeepCollectionEquality().equals(other.topics, _topics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_topics));
}

@override
String toString() {
    return 'LearningProgress(topics: $topics)';
}


}

/// @nodoc
abstract mixin class _$LearningProgressCopyWith<$Res> implements $LearningProgressCopyWith<$Res> {
  factory _$LearningProgressCopyWith(_LearningProgress value, $Res Function(_LearningProgress) _then) = __$LearningProgressCopyWithImpl;
@override @useResult
$Res call({
 Map<String, TopicMastery> topics
});




}
/// @nodoc
class __$LearningProgressCopyWithImpl<$Res>
    implements _$LearningProgressCopyWith<$Res> {
  __$LearningProgressCopyWithImpl(this._self, this._then);

  final _LearningProgress _self;
  final $Res Function(_LearningProgress) _then;

/// Create a copy of LearningProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topics = null,}) {
  return _then(_LearningProgress(
topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as Map<String, TopicMastery>,
  ));
}


}

// dart format on
