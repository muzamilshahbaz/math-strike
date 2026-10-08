// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingState {

 OnboardingStep get step;/// Direction of the last step change (+1 forward, -1 back), for
/// transitions.
 int get direction; String get name; String get avatarId; AgeGroup? get ageGroup; Difficulty get difficulty;/// Whether the player chose a difficulty themselves (then picking an
/// age group no longer overrides it).
 bool get difficultyChosen; bool get soundEnabled; bool get musicEnabled; bool get saving; String? get errorMessage;
/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingStateCopyWith<OnboardingState> get copyWith => _$OnboardingStateCopyWithImpl<OnboardingState>(this as OnboardingState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OnboardingState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState&&(identical(other.step, _this.step) || other.step == _this.step)&&(identical(other.direction, _this.direction) || other.direction == _this.direction)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.avatarId, _this.avatarId) || other.avatarId == _this.avatarId)&&(identical(other.ageGroup, _this.ageGroup) || other.ageGroup == _this.ageGroup)&&(identical(other.difficulty, _this.difficulty) || other.difficulty == _this.difficulty)&&(identical(other.difficultyChosen, _this.difficultyChosen) || other.difficultyChosen == _this.difficultyChosen)&&(identical(other.soundEnabled, _this.soundEnabled) || other.soundEnabled == _this.soundEnabled)&&(identical(other.musicEnabled, _this.musicEnabled) || other.musicEnabled == _this.musicEnabled)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as OnboardingState;
  return Object.hash(runtimeType,_this.step,_this.direction,_this.name,_this.avatarId,_this.ageGroup,_this.difficulty,_this.difficultyChosen,_this.soundEnabled,_this.musicEnabled,_this.saving,_this.errorMessage);
}

@override
String toString() {
  final _this = this as OnboardingState;
  return 'OnboardingState(step: ${_this.step}, direction: ${_this.direction}, name: ${_this.name}, avatarId: ${_this.avatarId}, ageGroup: ${_this.ageGroup}, difficulty: ${_this.difficulty}, difficultyChosen: ${_this.difficultyChosen}, soundEnabled: ${_this.soundEnabled}, musicEnabled: ${_this.musicEnabled}, saving: ${_this.saving}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $OnboardingStateCopyWith<$Res>  {
  factory $OnboardingStateCopyWith(OnboardingState value, $Res Function(OnboardingState) _then) = _$OnboardingStateCopyWithImpl;
@useResult
$Res call({
 OnboardingStep step, int direction, String name, String avatarId, AgeGroup? ageGroup, Difficulty difficulty, bool difficultyChosen, bool soundEnabled, bool musicEnabled, bool saving, String? errorMessage
});




}
/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._self, this._then);

  final OnboardingState _self;
  final $Res Function(OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? direction = null,Object? name = null,Object? avatarId = null,Object? ageGroup = freezed,Object? difficulty = null,Object? difficultyChosen = null,Object? soundEnabled = null,Object? musicEnabled = null,Object? saving = null,Object? errorMessage = freezed,}) {
  return _then(OnboardingState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingStep,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,ageGroup: freezed == ageGroup ? _self.ageGroup : ageGroup // ignore: cast_nullable_to_non_nullable
as AgeGroup?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,difficultyChosen: null == difficultyChosen ? _self.difficultyChosen : difficultyChosen // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,musicEnabled: null == musicEnabled ? _self.musicEnabled : musicEnabled // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingState value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingState value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OnboardingStep step,  int direction,  String name,  String avatarId,  AgeGroup? ageGroup,  Difficulty difficulty,  bool difficultyChosen,  bool soundEnabled,  bool musicEnabled,  bool saving,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.step,_that.direction,_that.name,_that.avatarId,_that.ageGroup,_that.difficulty,_that.difficultyChosen,_that.soundEnabled,_that.musicEnabled,_that.saving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OnboardingStep step,  int direction,  String name,  String avatarId,  AgeGroup? ageGroup,  Difficulty difficulty,  bool difficultyChosen,  bool soundEnabled,  bool musicEnabled,  bool saving,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _OnboardingState():
return $default(_that.step,_that.direction,_that.name,_that.avatarId,_that.ageGroup,_that.difficulty,_that.difficultyChosen,_that.soundEnabled,_that.musicEnabled,_that.saving,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OnboardingStep step,  int direction,  String name,  String avatarId,  AgeGroup? ageGroup,  Difficulty difficulty,  bool difficultyChosen,  bool soundEnabled,  bool musicEnabled,  bool saving,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingState() when $default != null:
return $default(_that.step,_that.direction,_that.name,_that.avatarId,_that.ageGroup,_that.difficulty,_that.difficultyChosen,_that.soundEnabled,_that.musicEnabled,_that.saving,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingState extends OnboardingState {
  const _OnboardingState({this.step = OnboardingStep.name, this.direction = 1, this.name = '', required this.avatarId, this.ageGroup, this.difficulty = Difficulty.medium, this.difficultyChosen = false, this.soundEnabled = true, this.musicEnabled = true, this.saving = false, this.errorMessage}): super._();
  

@override@JsonKey() final  OnboardingStep step;
/// Direction of the last step change (+1 forward, -1 back), for
/// transitions.
@override@JsonKey() final  int direction;
@override@JsonKey() final  String name;
@override final  String avatarId;
@override final  AgeGroup? ageGroup;
@override@JsonKey() final  Difficulty difficulty;
/// Whether the player chose a difficulty themselves (then picking an
/// age group no longer overrides it).
@override@JsonKey() final  bool difficultyChosen;
@override@JsonKey() final  bool soundEnabled;
@override@JsonKey() final  bool musicEnabled;
@override@JsonKey() final  bool saving;
@override final  String? errorMessage;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingStateCopyWith<_OnboardingState> get copyWith => __$OnboardingStateCopyWithImpl<_OnboardingState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingState&&(identical(other.step, step) || other.step == step)&&(identical(other.direction, direction) || other.direction == direction)&&(identical(other.name, name) || other.name == name)&&(identical(other.avatarId, avatarId) || other.avatarId == avatarId)&&(identical(other.ageGroup, ageGroup) || other.ageGroup == ageGroup)&&(identical(other.difficulty, difficulty) || other.difficulty == difficulty)&&(identical(other.difficultyChosen, difficultyChosen) || other.difficultyChosen == difficultyChosen)&&(identical(other.soundEnabled, soundEnabled) || other.soundEnabled == soundEnabled)&&(identical(other.musicEnabled, musicEnabled) || other.musicEnabled == musicEnabled)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,step,direction,name,avatarId,ageGroup,difficulty,difficultyChosen,soundEnabled,musicEnabled,saving,errorMessage);
}

@override
String toString() {
    return 'OnboardingState(step: $step, direction: $direction, name: $name, avatarId: $avatarId, ageGroup: $ageGroup, difficulty: $difficulty, difficultyChosen: $difficultyChosen, soundEnabled: $soundEnabled, musicEnabled: $musicEnabled, saving: $saving, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$OnboardingStateCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory _$OnboardingStateCopyWith(_OnboardingState value, $Res Function(_OnboardingState) _then) = __$OnboardingStateCopyWithImpl;
@override @useResult
$Res call({
 OnboardingStep step, int direction, String name, String avatarId, AgeGroup? ageGroup, Difficulty difficulty, bool difficultyChosen, bool soundEnabled, bool musicEnabled, bool saving, String? errorMessage
});




}
/// @nodoc
class __$OnboardingStateCopyWithImpl<$Res>
    implements _$OnboardingStateCopyWith<$Res> {
  __$OnboardingStateCopyWithImpl(this._self, this._then);

  final _OnboardingState _self;
  final $Res Function(_OnboardingState) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? direction = null,Object? name = null,Object? avatarId = null,Object? ageGroup = freezed,Object? difficulty = null,Object? difficultyChosen = null,Object? soundEnabled = null,Object? musicEnabled = null,Object? saving = null,Object? errorMessage = freezed,}) {
  return _then(_OnboardingState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as OnboardingStep,direction: null == direction ? _self.direction : direction // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,avatarId: null == avatarId ? _self.avatarId : avatarId // ignore: cast_nullable_to_non_nullable
as String,ageGroup: freezed == ageGroup ? _self.ageGroup : ageGroup // ignore: cast_nullable_to_non_nullable
as AgeGroup?,difficulty: null == difficulty ? _self.difficulty : difficulty // ignore: cast_nullable_to_non_nullable
as Difficulty,difficultyChosen: null == difficultyChosen ? _self.difficultyChosen : difficultyChosen // ignore: cast_nullable_to_non_nullable
as bool,soundEnabled: null == soundEnabled ? _self.soundEnabled : soundEnabled // ignore: cast_nullable_to_non_nullable
as bool,musicEnabled: null == musicEnabled ? _self.musicEnabled : musicEnabled // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
