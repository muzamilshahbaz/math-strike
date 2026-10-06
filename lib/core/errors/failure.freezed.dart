// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {

 String get message;
/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FailureCopyWith<Failure> get copyWith => _$FailureCopyWithImpl<Failure>(this as Failure, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Failure;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as Failure;
  return Object.hash(runtimeType,_this.message);
}

@override
String toString() {
  final _this = this as Failure;
  return 'Failure(message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $FailureCopyWith<$Res>  {
  factory $FailureCopyWith(Failure value, $Res Function(Failure) _then) = _$FailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FailureCopyWithImpl<$Res>
    implements $FailureCopyWith<$Res> {
  _$FailureCopyWithImpl(this._self, this._then);

  final Failure _self;
  final $Res Function(Failure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( StorageFailure value)?  storage,TResult Function( NetworkFailure value)?  network,TResult Function( AuthFailure value)?  auth,TResult Function( AuthCancelledFailure value)?  authCancelled,TResult Function( DataFormatFailure value)?  dataFormat,TResult Function( UnexpectedFailure value)?  unexpected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case StorageFailure() when storage != null:
return storage(_that);case NetworkFailure() when network != null:
return network(_that);case AuthFailure() when auth != null:
return auth(_that);case AuthCancelledFailure() when authCancelled != null:
return authCancelled(_that);case DataFormatFailure() when dataFormat != null:
return dataFormat(_that);case UnexpectedFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( StorageFailure value)  storage,required TResult Function( NetworkFailure value)  network,required TResult Function( AuthFailure value)  auth,required TResult Function( AuthCancelledFailure value)  authCancelled,required TResult Function( DataFormatFailure value)  dataFormat,required TResult Function( UnexpectedFailure value)  unexpected,}){
final _that = this;
switch (_that) {
case StorageFailure():
return storage(_that);case NetworkFailure():
return network(_that);case AuthFailure():
return auth(_that);case AuthCancelledFailure():
return authCancelled(_that);case DataFormatFailure():
return dataFormat(_that);case UnexpectedFailure():
return unexpected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( StorageFailure value)?  storage,TResult? Function( NetworkFailure value)?  network,TResult? Function( AuthFailure value)?  auth,TResult? Function( AuthCancelledFailure value)?  authCancelled,TResult? Function( DataFormatFailure value)?  dataFormat,TResult? Function( UnexpectedFailure value)?  unexpected,}){
final _that = this;
switch (_that) {
case StorageFailure() when storage != null:
return storage(_that);case NetworkFailure() when network != null:
return network(_that);case AuthFailure() when auth != null:
return auth(_that);case AuthCancelledFailure() when authCancelled != null:
return authCancelled(_that);case DataFormatFailure() when dataFormat != null:
return dataFormat(_that);case UnexpectedFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  Object? cause)?  storage,TResult Function( String message,  Object? cause)?  network,TResult Function( String message,  Object? cause)?  auth,TResult Function( String message)?  authCancelled,TResult Function( String message,  Object? cause)?  dataFormat,TResult Function( String message,  Object? cause)?  unexpected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case StorageFailure() when storage != null:
return storage(_that.message,_that.cause);case NetworkFailure() when network != null:
return network(_that.message,_that.cause);case AuthFailure() when auth != null:
return auth(_that.message,_that.cause);case AuthCancelledFailure() when authCancelled != null:
return authCancelled(_that.message);case DataFormatFailure() when dataFormat != null:
return dataFormat(_that.message,_that.cause);case UnexpectedFailure() when unexpected != null:
return unexpected(_that.message,_that.cause);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  Object? cause)  storage,required TResult Function( String message,  Object? cause)  network,required TResult Function( String message,  Object? cause)  auth,required TResult Function( String message)  authCancelled,required TResult Function( String message,  Object? cause)  dataFormat,required TResult Function( String message,  Object? cause)  unexpected,}) {final _that = this;
switch (_that) {
case StorageFailure():
return storage(_that.message,_that.cause);case NetworkFailure():
return network(_that.message,_that.cause);case AuthFailure():
return auth(_that.message,_that.cause);case AuthCancelledFailure():
return authCancelled(_that.message);case DataFormatFailure():
return dataFormat(_that.message,_that.cause);case UnexpectedFailure():
return unexpected(_that.message,_that.cause);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  Object? cause)?  storage,TResult? Function( String message,  Object? cause)?  network,TResult? Function( String message,  Object? cause)?  auth,TResult? Function( String message)?  authCancelled,TResult? Function( String message,  Object? cause)?  dataFormat,TResult? Function( String message,  Object? cause)?  unexpected,}) {final _that = this;
switch (_that) {
case StorageFailure() when storage != null:
return storage(_that.message,_that.cause);case NetworkFailure() when network != null:
return network(_that.message,_that.cause);case AuthFailure() when auth != null:
return auth(_that.message,_that.cause);case AuthCancelledFailure() when authCancelled != null:
return authCancelled(_that.message);case DataFormatFailure() when dataFormat != null:
return dataFormat(_that.message,_that.cause);case UnexpectedFailure() when unexpected != null:
return unexpected(_that.message,_that.cause);case _:
  return null;

}
}

}

/// @nodoc


class StorageFailure implements Failure {
  const StorageFailure(this.message, {this.cause});
  

@override final  String message;
 final  Object? cause;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageFailureCopyWith<StorageFailure> get copyWith => _$StorageFailureCopyWithImpl<StorageFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));
}

@override
String toString() {
    return 'Failure.storage(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $StorageFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $StorageFailureCopyWith(StorageFailure value, $Res Function(StorageFailure) _then) = _$StorageFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$StorageFailureCopyWithImpl<$Res>
    implements $StorageFailureCopyWith<$Res> {
  _$StorageFailureCopyWithImpl(this._self, this._then);

  final StorageFailure _self;
  final $Res Function(StorageFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(StorageFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class NetworkFailure implements Failure {
  const NetworkFailure(this.message, {this.cause});
  

@override final  String message;
 final  Object? cause;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkFailureCopyWith<NetworkFailure> get copyWith => _$NetworkFailureCopyWithImpl<NetworkFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));
}

@override
String toString() {
    return 'Failure.network(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $NetworkFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NetworkFailureCopyWith(NetworkFailure value, $Res Function(NetworkFailure) _then) = _$NetworkFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$NetworkFailureCopyWithImpl<$Res>
    implements $NetworkFailureCopyWith<$Res> {
  _$NetworkFailureCopyWithImpl(this._self, this._then);

  final NetworkFailure _self;
  final $Res Function(NetworkFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(NetworkFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class AuthFailure implements Failure {
  const AuthFailure(this.message, {this.cause});
  

@override final  String message;
 final  Object? cause;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<AuthFailure> get copyWith => _$AuthFailureCopyWithImpl<AuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));
}

@override
String toString() {
    return 'Failure.auth(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $AuthFailureCopyWith(AuthFailure value, $Res Function(AuthFailure) _then) = _$AuthFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$AuthFailureCopyWithImpl<$Res>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(AuthFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class AuthCancelledFailure implements Failure {
  const AuthCancelledFailure(this.message);
  

@override final  String message;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthCancelledFailureCopyWith<AuthCancelledFailure> get copyWith => _$AuthCancelledFailureCopyWithImpl<AuthCancelledFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthCancelledFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'Failure.authCancelled(message: $message)';
}


}

/// @nodoc
abstract mixin class $AuthCancelledFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $AuthCancelledFailureCopyWith(AuthCancelledFailure value, $Res Function(AuthCancelledFailure) _then) = _$AuthCancelledFailureCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AuthCancelledFailureCopyWithImpl<$Res>
    implements $AuthCancelledFailureCopyWith<$Res> {
  _$AuthCancelledFailureCopyWithImpl(this._self, this._then);

  final AuthCancelledFailure _self;
  final $Res Function(AuthCancelledFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AuthCancelledFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DataFormatFailure implements Failure {
  const DataFormatFailure(this.message, {this.cause});
  

@override final  String message;
 final  Object? cause;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DataFormatFailureCopyWith<DataFormatFailure> get copyWith => _$DataFormatFailureCopyWithImpl<DataFormatFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is DataFormatFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));
}

@override
String toString() {
    return 'Failure.dataFormat(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $DataFormatFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $DataFormatFailureCopyWith(DataFormatFailure value, $Res Function(DataFormatFailure) _then) = _$DataFormatFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$DataFormatFailureCopyWithImpl<$Res>
    implements $DataFormatFailureCopyWith<$Res> {
  _$DataFormatFailureCopyWithImpl(this._self, this._then);

  final DataFormatFailure _self;
  final $Res Function(DataFormatFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(DataFormatFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

/// @nodoc


class UnexpectedFailure implements Failure {
  const UnexpectedFailure(this.message, {this.cause});
  

@override final  String message;
 final  Object? cause;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnexpectedFailureCopyWith<UnexpectedFailure> get copyWith => _$UnexpectedFailureCopyWithImpl<UnexpectedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedFailure&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.cause, cause));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,const DeepCollectionEquality().hash(cause));
}

@override
String toString() {
    return 'Failure.unexpected(message: $message, cause: $cause)';
}


}

/// @nodoc
abstract mixin class $UnexpectedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnexpectedFailureCopyWith(UnexpectedFailure value, $Res Function(UnexpectedFailure) _then) = _$UnexpectedFailureCopyWithImpl;
@override @useResult
$Res call({
 String message, Object? cause
});




}
/// @nodoc
class _$UnexpectedFailureCopyWithImpl<$Res>
    implements $UnexpectedFailureCopyWith<$Res> {
  _$UnexpectedFailureCopyWithImpl(this._self, this._then);

  final UnexpectedFailure _self;
  final $Res Function(UnexpectedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? cause = freezed,}) {
  return _then(UnexpectedFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,cause: freezed == cause ? _self.cause : cause ,
  ));
}


}

// dart format on
