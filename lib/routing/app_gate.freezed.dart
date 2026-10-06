// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_gate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppGate {

 bool get startupCompleted;/// First-launch setup stage; `null` when no account is linked yet.
 AccountSetupStage? get stage;
/// Create a copy of AppGate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppGateCopyWith<AppGate> get copyWith => _$AppGateCopyWithImpl<AppGate>(this as AppGate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppGate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppGate&&(identical(other.startupCompleted, _this.startupCompleted) || other.startupCompleted == _this.startupCompleted)&&(identical(other.stage, _this.stage) || other.stage == _this.stage));
}


@override
int get hashCode {
  final _this = this as AppGate;
  return Object.hash(runtimeType,_this.startupCompleted,_this.stage);
}

@override
String toString() {
  final _this = this as AppGate;
  return 'AppGate(startupCompleted: ${_this.startupCompleted}, stage: ${_this.stage})';
}


}

/// @nodoc
abstract mixin class $AppGateCopyWith<$Res>  {
  factory $AppGateCopyWith(AppGate value, $Res Function(AppGate) _then) = _$AppGateCopyWithImpl;
@useResult
$Res call({
 bool startupCompleted, AccountSetupStage? stage
});




}
/// @nodoc
class _$AppGateCopyWithImpl<$Res>
    implements $AppGateCopyWith<$Res> {
  _$AppGateCopyWithImpl(this._self, this._then);

  final AppGate _self;
  final $Res Function(AppGate) _then;

/// Create a copy of AppGate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startupCompleted = null,Object? stage = freezed,}) {
  return _then(AppGate(
startupCompleted: null == startupCompleted ? _self.startupCompleted : startupCompleted // ignore: cast_nullable_to_non_nullable
as bool,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as AccountSetupStage?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppGate].
extension AppGatePatterns on AppGate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppGate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppGate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppGate value)  $default,){
final _that = this;
switch (_that) {
case _AppGate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppGate value)?  $default,){
final _that = this;
switch (_that) {
case _AppGate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool startupCompleted,  AccountSetupStage? stage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppGate() when $default != null:
return $default(_that.startupCompleted,_that.stage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool startupCompleted,  AccountSetupStage? stage)  $default,) {final _that = this;
switch (_that) {
case _AppGate():
return $default(_that.startupCompleted,_that.stage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool startupCompleted,  AccountSetupStage? stage)?  $default,) {final _that = this;
switch (_that) {
case _AppGate() when $default != null:
return $default(_that.startupCompleted,_that.stage);case _:
  return null;

}
}

}

/// @nodoc


class _AppGate implements AppGate {
  const _AppGate({this.startupCompleted = false, this.stage});
  

@override@JsonKey() final  bool startupCompleted;
/// First-launch setup stage; `null` when no account is linked yet.
@override final  AccountSetupStage? stage;

/// Create a copy of AppGate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppGateCopyWith<_AppGate> get copyWith => __$AppGateCopyWithImpl<_AppGate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppGate&&(identical(other.startupCompleted, startupCompleted) || other.startupCompleted == startupCompleted)&&(identical(other.stage, stage) || other.stage == stage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,startupCompleted,stage);
}

@override
String toString() {
    return 'AppGate(startupCompleted: $startupCompleted, stage: $stage)';
}


}

/// @nodoc
abstract mixin class _$AppGateCopyWith<$Res> implements $AppGateCopyWith<$Res> {
  factory _$AppGateCopyWith(_AppGate value, $Res Function(_AppGate) _then) = __$AppGateCopyWithImpl;
@override @useResult
$Res call({
 bool startupCompleted, AccountSetupStage? stage
});




}
/// @nodoc
class __$AppGateCopyWithImpl<$Res>
    implements _$AppGateCopyWith<$Res> {
  __$AppGateCopyWithImpl(this._self, this._then);

  final _AppGate _self;
  final $Res Function(_AppGate) _then;

/// Create a copy of AppGate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startupCompleted = null,Object? stage = freezed,}) {
  return _then(_AppGate(
startupCompleted: null == startupCompleted ? _self.startupCompleted : startupCompleted // ignore: cast_nullable_to_non_nullable
as bool,stage: freezed == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as AccountSetupStage?,
  ));
}


}

// dart format on
