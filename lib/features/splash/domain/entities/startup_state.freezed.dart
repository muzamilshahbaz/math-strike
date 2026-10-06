// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'startup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StartupFailure {

 String get taskId; String get taskLabel; String get message;
/// Create a copy of StartupFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupFailureCopyWith<StartupFailure> get copyWith => _$StartupFailureCopyWithImpl<StartupFailure>(this as StartupFailure, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StartupFailure;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupFailure&&(identical(other.taskId, _this.taskId) || other.taskId == _this.taskId)&&(identical(other.taskLabel, _this.taskLabel) || other.taskLabel == _this.taskLabel)&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as StartupFailure;
  return Object.hash(runtimeType,_this.taskId,_this.taskLabel,_this.message);
}

@override
String toString() {
  final _this = this as StartupFailure;
  return 'StartupFailure(taskId: ${_this.taskId}, taskLabel: ${_this.taskLabel}, message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $StartupFailureCopyWith<$Res>  {
  factory $StartupFailureCopyWith(StartupFailure value, $Res Function(StartupFailure) _then) = _$StartupFailureCopyWithImpl;
@useResult
$Res call({
 String taskId, String taskLabel, String message
});




}
/// @nodoc
class _$StartupFailureCopyWithImpl<$Res>
    implements $StartupFailureCopyWith<$Res> {
  _$StartupFailureCopyWithImpl(this._self, this._then);

  final StartupFailure _self;
  final $Res Function(StartupFailure) _then;

/// Create a copy of StartupFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? taskId = null,Object? taskLabel = null,Object? message = null,}) {
  return _then(StartupFailure(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskLabel: null == taskLabel ? _self.taskLabel : taskLabel // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StartupFailure].
extension StartupFailurePatterns on StartupFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartupFailure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartupFailure() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartupFailure value)  $default,){
final _that = this;
switch (_that) {
case _StartupFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartupFailure value)?  $default,){
final _that = this;
switch (_that) {
case _StartupFailure() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String taskId,  String taskLabel,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartupFailure() when $default != null:
return $default(_that.taskId,_that.taskLabel,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String taskId,  String taskLabel,  String message)  $default,) {final _that = this;
switch (_that) {
case _StartupFailure():
return $default(_that.taskId,_that.taskLabel,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String taskId,  String taskLabel,  String message)?  $default,) {final _that = this;
switch (_that) {
case _StartupFailure() when $default != null:
return $default(_that.taskId,_that.taskLabel,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _StartupFailure implements StartupFailure {
  const _StartupFailure({required this.taskId, required this.taskLabel, required this.message});
  

@override final  String taskId;
@override final  String taskLabel;
@override final  String message;

/// Create a copy of StartupFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartupFailureCopyWith<_StartupFailure> get copyWith => __$StartupFailureCopyWithImpl<_StartupFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartupFailure&&(identical(other.taskId, taskId) || other.taskId == taskId)&&(identical(other.taskLabel, taskLabel) || other.taskLabel == taskLabel)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,taskId,taskLabel,message);
}

@override
String toString() {
    return 'StartupFailure(taskId: $taskId, taskLabel: $taskLabel, message: $message)';
}


}

/// @nodoc
abstract mixin class _$StartupFailureCopyWith<$Res> implements $StartupFailureCopyWith<$Res> {
  factory _$StartupFailureCopyWith(_StartupFailure value, $Res Function(_StartupFailure) _then) = __$StartupFailureCopyWithImpl;
@override @useResult
$Res call({
 String taskId, String taskLabel, String message
});




}
/// @nodoc
class __$StartupFailureCopyWithImpl<$Res>
    implements _$StartupFailureCopyWith<$Res> {
  __$StartupFailureCopyWithImpl(this._self, this._then);

  final _StartupFailure _self;
  final $Res Function(_StartupFailure) _then;

/// Create a copy of StartupFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? taskId = null,Object? taskLabel = null,Object? message = null,}) {
  return _then(_StartupFailure(
taskId: null == taskId ? _self.taskId : taskId // ignore: cast_nullable_to_non_nullable
as String,taskLabel: null == taskLabel ? _self.taskLabel : taskLabel // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$StartupState {

 StartupStatus get status;/// Weighted completion, 0.0–1.0.
 double get progress;/// Label of the task currently running.
 String? get currentTaskLabel;/// The critical failure that stopped start-up, if any.
 StartupFailure? get failure;/// Non-critical failures; start-up continued past these.
 List<StartupFailure> get warnings;
/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StartupStateCopyWith<StartupState> get copyWith => _$StartupStateCopyWithImpl<StartupState>(this as StartupState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StartupState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StartupState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.currentTaskLabel, _this.currentTaskLabel) || other.currentTaskLabel == _this.currentTaskLabel)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&const DeepCollectionEquality().equals(other.warnings, _this.warnings));
}


@override
int get hashCode {
  final _this = this as StartupState;
  return Object.hash(runtimeType,_this.status,_this.progress,_this.currentTaskLabel,_this.failure,const DeepCollectionEquality().hash(_this.warnings));
}

@override
String toString() {
  final _this = this as StartupState;
  return 'StartupState(status: ${_this.status}, progress: ${_this.progress}, currentTaskLabel: ${_this.currentTaskLabel}, failure: ${_this.failure}, warnings: ${_this.warnings})';
}


}

/// @nodoc
abstract mixin class $StartupStateCopyWith<$Res>  {
  factory $StartupStateCopyWith(StartupState value, $Res Function(StartupState) _then) = _$StartupStateCopyWithImpl;
@useResult
$Res call({
 StartupStatus status, double progress, String? currentTaskLabel, StartupFailure? failure, List<StartupFailure> warnings
});


$StartupFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$StartupStateCopyWithImpl<$Res>
    implements $StartupStateCopyWith<$Res> {
  _$StartupStateCopyWithImpl(this._self, this._then);

  final StartupState _self;
  final $Res Function(StartupState) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? progress = null,Object? currentTaskLabel = freezed,Object? failure = freezed,Object? warnings = null,}) {
  return _then(StartupState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StartupStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,currentTaskLabel: freezed == currentTaskLabel ? _self.currentTaskLabel : currentTaskLabel // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as StartupFailure?,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<StartupFailure>,
  ));
}
/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartupFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $StartupFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [StartupState].
extension StartupStatePatterns on StartupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StartupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StartupState value)  $default,){
final _that = this;
switch (_that) {
case _StartupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StartupState value)?  $default,){
final _that = this;
switch (_that) {
case _StartupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StartupStatus status,  double progress,  String? currentTaskLabel,  StartupFailure? failure,  List<StartupFailure> warnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartupState() when $default != null:
return $default(_that.status,_that.progress,_that.currentTaskLabel,_that.failure,_that.warnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StartupStatus status,  double progress,  String? currentTaskLabel,  StartupFailure? failure,  List<StartupFailure> warnings)  $default,) {final _that = this;
switch (_that) {
case _StartupState():
return $default(_that.status,_that.progress,_that.currentTaskLabel,_that.failure,_that.warnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StartupStatus status,  double progress,  String? currentTaskLabel,  StartupFailure? failure,  List<StartupFailure> warnings)?  $default,) {final _that = this;
switch (_that) {
case _StartupState() when $default != null:
return $default(_that.status,_that.progress,_that.currentTaskLabel,_that.failure,_that.warnings);case _:
  return null;

}
}

}

/// @nodoc


class _StartupState extends StartupState {
  const _StartupState({this.status = StartupStatus.idle, this.progress = 0.0, this.currentTaskLabel, this.failure,  List<StartupFailure> warnings = const <StartupFailure>[]}): _warnings = warnings,super._();
  

@override@JsonKey() final  StartupStatus status;
/// Weighted completion, 0.0–1.0.
@override@JsonKey() final  double progress;
/// Label of the task currently running.
@override final  String? currentTaskLabel;
/// The critical failure that stopped start-up, if any.
@override final  StartupFailure? failure;
/// Non-critical failures; start-up continued past these.
 final  List<StartupFailure> _warnings;
/// Non-critical failures; start-up continued past these.
@override@JsonKey() List<StartupFailure> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}


/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartupStateCopyWith<_StartupState> get copyWith => __$StartupStateCopyWithImpl<_StartupState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartupState&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.currentTaskLabel, currentTaskLabel) || other.currentTaskLabel == currentTaskLabel)&&(identical(other.failure, failure) || other.failure == failure)&&const DeepCollectionEquality().equals(other.warnings, _warnings));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,progress,currentTaskLabel,failure,const DeepCollectionEquality().hash(_warnings));
}

@override
String toString() {
    return 'StartupState(status: $status, progress: $progress, currentTaskLabel: $currentTaskLabel, failure: $failure, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class _$StartupStateCopyWith<$Res> implements $StartupStateCopyWith<$Res> {
  factory _$StartupStateCopyWith(_StartupState value, $Res Function(_StartupState) _then) = __$StartupStateCopyWithImpl;
@override @useResult
$Res call({
 StartupStatus status, double progress, String? currentTaskLabel, StartupFailure? failure, List<StartupFailure> warnings
});


@override $StartupFailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$StartupStateCopyWithImpl<$Res>
    implements _$StartupStateCopyWith<$Res> {
  __$StartupStateCopyWithImpl(this._self, this._then);

  final _StartupState _self;
  final $Res Function(_StartupState) _then;

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? progress = null,Object? currentTaskLabel = freezed,Object? failure = freezed,Object? warnings = null,}) {
  return _then(_StartupState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StartupStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,currentTaskLabel: freezed == currentTaskLabel ? _self.currentTaskLabel : currentTaskLabel // ignore: cast_nullable_to_non_nullable
as String?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as StartupFailure?,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<StartupFailure>,
  ));
}

/// Create a copy of StartupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StartupFailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $StartupFailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
