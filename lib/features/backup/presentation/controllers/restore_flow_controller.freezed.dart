// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restore_flow_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RestoreFlowState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RestoreFlowState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RestoreFlowState()';
}


}

/// @nodoc
class $RestoreFlowStateCopyWith<$Res>  {
$RestoreFlowStateCopyWith(RestoreFlowState _, $Res Function(RestoreFlowState) __);
}


/// Adds pattern-matching-related methods to [RestoreFlowState].
extension RestoreFlowStatePatterns on RestoreFlowState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RestoreChecking value)?  checking,TResult Function( RestoreInProgress value)?  restoring,TResult Function( RestoreSucceeded value)?  restored,TResult Function( NoBackupFound value)?  noBackup,TResult Function( RestoreFailed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RestoreChecking() when checking != null:
return checking(_that);case RestoreInProgress() when restoring != null:
return restoring(_that);case RestoreSucceeded() when restored != null:
return restored(_that);case NoBackupFound() when noBackup != null:
return noBackup(_that);case RestoreFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RestoreChecking value)  checking,required TResult Function( RestoreInProgress value)  restoring,required TResult Function( RestoreSucceeded value)  restored,required TResult Function( NoBackupFound value)  noBackup,required TResult Function( RestoreFailed value)  failed,}){
final _that = this;
switch (_that) {
case RestoreChecking():
return checking(_that);case RestoreInProgress():
return restoring(_that);case RestoreSucceeded():
return restored(_that);case NoBackupFound():
return noBackup(_that);case RestoreFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RestoreChecking value)?  checking,TResult? Function( RestoreInProgress value)?  restoring,TResult? Function( RestoreSucceeded value)?  restored,TResult? Function( NoBackupFound value)?  noBackup,TResult? Function( RestoreFailed value)?  failed,}){
final _that = this;
switch (_that) {
case RestoreChecking() when checking != null:
return checking(_that);case RestoreInProgress() when restoring != null:
return restoring(_that);case RestoreSucceeded() when restored != null:
return restored(_that);case NoBackupFound() when noBackup != null:
return noBackup(_that);case RestoreFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checking,TResult Function( BackupMetadata backup,  double progress)?  restoring,TResult Function( BackupMetadata backup)?  restored,TResult Function()?  noBackup,TResult Function( Failure failure,  bool duringRestore)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RestoreChecking() when checking != null:
return checking();case RestoreInProgress() when restoring != null:
return restoring(_that.backup,_that.progress);case RestoreSucceeded() when restored != null:
return restored(_that.backup);case NoBackupFound() when noBackup != null:
return noBackup();case RestoreFailed() when failed != null:
return failed(_that.failure,_that.duringRestore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checking,required TResult Function( BackupMetadata backup,  double progress)  restoring,required TResult Function( BackupMetadata backup)  restored,required TResult Function()  noBackup,required TResult Function( Failure failure,  bool duringRestore)  failed,}) {final _that = this;
switch (_that) {
case RestoreChecking():
return checking();case RestoreInProgress():
return restoring(_that.backup,_that.progress);case RestoreSucceeded():
return restored(_that.backup);case NoBackupFound():
return noBackup();case RestoreFailed():
return failed(_that.failure,_that.duringRestore);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checking,TResult? Function( BackupMetadata backup,  double progress)?  restoring,TResult? Function( BackupMetadata backup)?  restored,TResult? Function()?  noBackup,TResult? Function( Failure failure,  bool duringRestore)?  failed,}) {final _that = this;
switch (_that) {
case RestoreChecking() when checking != null:
return checking();case RestoreInProgress() when restoring != null:
return restoring(_that.backup,_that.progress);case RestoreSucceeded() when restored != null:
return restored(_that.backup);case NoBackupFound() when noBackup != null:
return noBackup();case RestoreFailed() when failed != null:
return failed(_that.failure,_that.duringRestore);case _:
  return null;

}
}

}

/// @nodoc


class RestoreChecking implements RestoreFlowState {
  const RestoreChecking();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RestoreChecking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RestoreFlowState.checking()';
}


}




/// @nodoc


class RestoreInProgress implements RestoreFlowState {
  const RestoreInProgress({required this.backup, required this.progress});
  

 final  BackupMetadata backup;
 final  double progress;

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestoreInProgressCopyWith<RestoreInProgress> get copyWith => _$RestoreInProgressCopyWithImpl<RestoreInProgress>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RestoreInProgress&&(identical(other.backup, backup) || other.backup == backup)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode {
    return Object.hash(runtimeType,backup,progress);
}

@override
String toString() {
    return 'RestoreFlowState.restoring(backup: $backup, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $RestoreInProgressCopyWith<$Res> implements $RestoreFlowStateCopyWith<$Res> {
  factory $RestoreInProgressCopyWith(RestoreInProgress value, $Res Function(RestoreInProgress) _then) = _$RestoreInProgressCopyWithImpl;
@useResult
$Res call({
 BackupMetadata backup, double progress
});


$BackupMetadataCopyWith<$Res> get backup;

}
/// @nodoc
class _$RestoreInProgressCopyWithImpl<$Res>
    implements $RestoreInProgressCopyWith<$Res> {
  _$RestoreInProgressCopyWithImpl(this._self, this._then);

  final RestoreInProgress _self;
  final $Res Function(RestoreInProgress) _then;

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? backup = null,Object? progress = null,}) {
  return _then(RestoreInProgress(
backup: null == backup ? _self.backup : backup // ignore: cast_nullable_to_non_nullable
as BackupMetadata,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupMetadataCopyWith<$Res> get backup {
  
  return $BackupMetadataCopyWith<$Res>(_self.backup, (value) {
    return _then(_self.copyWith(backup: value));
  });
}
}

/// @nodoc


class RestoreSucceeded implements RestoreFlowState {
  const RestoreSucceeded(this.backup);
  

 final  BackupMetadata backup;

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestoreSucceededCopyWith<RestoreSucceeded> get copyWith => _$RestoreSucceededCopyWithImpl<RestoreSucceeded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RestoreSucceeded&&(identical(other.backup, backup) || other.backup == backup));
}


@override
int get hashCode {
    return Object.hash(runtimeType,backup);
}

@override
String toString() {
    return 'RestoreFlowState.restored(backup: $backup)';
}


}

/// @nodoc
abstract mixin class $RestoreSucceededCopyWith<$Res> implements $RestoreFlowStateCopyWith<$Res> {
  factory $RestoreSucceededCopyWith(RestoreSucceeded value, $Res Function(RestoreSucceeded) _then) = _$RestoreSucceededCopyWithImpl;
@useResult
$Res call({
 BackupMetadata backup
});


$BackupMetadataCopyWith<$Res> get backup;

}
/// @nodoc
class _$RestoreSucceededCopyWithImpl<$Res>
    implements $RestoreSucceededCopyWith<$Res> {
  _$RestoreSucceededCopyWithImpl(this._self, this._then);

  final RestoreSucceeded _self;
  final $Res Function(RestoreSucceeded) _then;

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? backup = null,}) {
  return _then(RestoreSucceeded(
null == backup ? _self.backup : backup // ignore: cast_nullable_to_non_nullable
as BackupMetadata,
  ));
}

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupMetadataCopyWith<$Res> get backup {
  
  return $BackupMetadataCopyWith<$Res>(_self.backup, (value) {
    return _then(_self.copyWith(backup: value));
  });
}
}

/// @nodoc


class NoBackupFound implements RestoreFlowState {
  const NoBackupFound();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NoBackupFound);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'RestoreFlowState.noBackup()';
}


}




/// @nodoc


class RestoreFailed implements RestoreFlowState {
  const RestoreFailed({required this.failure, required this.duringRestore});
  

 final  Failure failure;
/// True when a backup was found but could not be restored.
 final  bool duringRestore;

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestoreFailedCopyWith<RestoreFailed> get copyWith => _$RestoreFailedCopyWithImpl<RestoreFailed>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is RestoreFailed&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.duringRestore, duringRestore) || other.duringRestore == duringRestore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,failure,duringRestore);
}

@override
String toString() {
    return 'RestoreFlowState.failed(failure: $failure, duringRestore: $duringRestore)';
}


}

/// @nodoc
abstract mixin class $RestoreFailedCopyWith<$Res> implements $RestoreFlowStateCopyWith<$Res> {
  factory $RestoreFailedCopyWith(RestoreFailed value, $Res Function(RestoreFailed) _then) = _$RestoreFailedCopyWithImpl;
@useResult
$Res call({
 Failure failure, bool duringRestore
});


$FailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$RestoreFailedCopyWithImpl<$Res>
    implements $RestoreFailedCopyWith<$Res> {
  _$RestoreFailedCopyWithImpl(this._self, this._then);

  final RestoreFailed _self;
  final $Res Function(RestoreFailed) _then;

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,Object? duringRestore = null,}) {
  return _then(RestoreFailed(
failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,duringRestore: null == duringRestore ? _self.duringRestore : duringRestore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of RestoreFlowState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res> get failure {
  
  return $FailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
