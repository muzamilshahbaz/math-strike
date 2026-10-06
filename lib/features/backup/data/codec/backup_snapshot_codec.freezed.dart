// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_snapshot_codec.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupSnapshot {

 int get formatVersion; DateTime get createdAt; String get appVersion;/// Box name → key → value (see [DatabaseSnapshot]).
 DatabaseSnapshot get boxes;
/// Create a copy of BackupSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupSnapshotCopyWith<BackupSnapshot> get copyWith => _$BackupSnapshotCopyWithImpl<BackupSnapshot>(this as BackupSnapshot, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BackupSnapshot;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupSnapshot&&(identical(other.formatVersion, _this.formatVersion) || other.formatVersion == _this.formatVersion)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.appVersion, _this.appVersion) || other.appVersion == _this.appVersion)&&const DeepCollectionEquality().equals(other.boxes, _this.boxes));
}


@override
int get hashCode {
  final _this = this as BackupSnapshot;
  return Object.hash(runtimeType,_this.formatVersion,_this.createdAt,_this.appVersion,const DeepCollectionEquality().hash(_this.boxes));
}

@override
String toString() {
  final _this = this as BackupSnapshot;
  return 'BackupSnapshot(formatVersion: ${_this.formatVersion}, createdAt: ${_this.createdAt}, appVersion: ${_this.appVersion}, boxes: ${_this.boxes})';
}


}

/// @nodoc
abstract mixin class $BackupSnapshotCopyWith<$Res>  {
  factory $BackupSnapshotCopyWith(BackupSnapshot value, $Res Function(BackupSnapshot) _then) = _$BackupSnapshotCopyWithImpl;
@useResult
$Res call({
 int formatVersion, DateTime createdAt, String appVersion, DatabaseSnapshot boxes
});




}
/// @nodoc
class _$BackupSnapshotCopyWithImpl<$Res>
    implements $BackupSnapshotCopyWith<$Res> {
  _$BackupSnapshotCopyWithImpl(this._self, this._then);

  final BackupSnapshot _self;
  final $Res Function(BackupSnapshot) _then;

/// Create a copy of BackupSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? formatVersion = null,Object? createdAt = null,Object? appVersion = null,Object? boxes = null,}) {
  return _then(BackupSnapshot(
formatVersion: null == formatVersion ? _self.formatVersion : formatVersion // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,boxes: null == boxes ? _self.boxes : boxes // ignore: cast_nullable_to_non_nullable
as DatabaseSnapshot,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupSnapshot].
extension BackupSnapshotPatterns on BackupSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _BackupSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _BackupSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int formatVersion,  DateTime createdAt,  String appVersion,  DatabaseSnapshot boxes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupSnapshot() when $default != null:
return $default(_that.formatVersion,_that.createdAt,_that.appVersion,_that.boxes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int formatVersion,  DateTime createdAt,  String appVersion,  DatabaseSnapshot boxes)  $default,) {final _that = this;
switch (_that) {
case _BackupSnapshot():
return $default(_that.formatVersion,_that.createdAt,_that.appVersion,_that.boxes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int formatVersion,  DateTime createdAt,  String appVersion,  DatabaseSnapshot boxes)?  $default,) {final _that = this;
switch (_that) {
case _BackupSnapshot() when $default != null:
return $default(_that.formatVersion,_that.createdAt,_that.appVersion,_that.boxes);case _:
  return null;

}
}

}

/// @nodoc


class _BackupSnapshot implements BackupSnapshot {
  const _BackupSnapshot({required this.formatVersion, required this.createdAt, required this.appVersion, required  DatabaseSnapshot boxes}): _boxes = boxes;
  

@override final  int formatVersion;
@override final  DateTime createdAt;
@override final  String appVersion;
/// Box name → key → value (see [DatabaseSnapshot]).
 final  DatabaseSnapshot _boxes;
/// Box name → key → value (see [DatabaseSnapshot]).
@override DatabaseSnapshot get boxes {
  if (_boxes is EqualUnmodifiableMapView) return _boxes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_boxes);
}


/// Create a copy of BackupSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupSnapshotCopyWith<_BackupSnapshot> get copyWith => __$BackupSnapshotCopyWithImpl<_BackupSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupSnapshot&&(identical(other.formatVersion, formatVersion) || other.formatVersion == formatVersion)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&const DeepCollectionEquality().equals(other.boxes, _boxes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,formatVersion,createdAt,appVersion,const DeepCollectionEquality().hash(_boxes));
}

@override
String toString() {
    return 'BackupSnapshot(formatVersion: $formatVersion, createdAt: $createdAt, appVersion: $appVersion, boxes: $boxes)';
}


}

/// @nodoc
abstract mixin class _$BackupSnapshotCopyWith<$Res> implements $BackupSnapshotCopyWith<$Res> {
  factory _$BackupSnapshotCopyWith(_BackupSnapshot value, $Res Function(_BackupSnapshot) _then) = __$BackupSnapshotCopyWithImpl;
@override @useResult
$Res call({
 int formatVersion, DateTime createdAt, String appVersion, DatabaseSnapshot boxes
});




}
/// @nodoc
class __$BackupSnapshotCopyWithImpl<$Res>
    implements _$BackupSnapshotCopyWith<$Res> {
  __$BackupSnapshotCopyWithImpl(this._self, this._then);

  final _BackupSnapshot _self;
  final $Res Function(_BackupSnapshot) _then;

/// Create a copy of BackupSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? formatVersion = null,Object? createdAt = null,Object? appVersion = null,Object? boxes = null,}) {
  return _then(_BackupSnapshot(
formatVersion: null == formatVersion ? _self.formatVersion : formatVersion // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,boxes: null == boxes ? _self._boxes : boxes // ignore: cast_nullable_to_non_nullable
as DatabaseSnapshot,
  ));
}


}

// dart format on
