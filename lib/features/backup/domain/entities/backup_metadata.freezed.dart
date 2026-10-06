// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupMetadata {

/// Remote file identifier.
 String get id; DateTime get modifiedAt; int get sizeBytes;/// Version of the app that wrote the backup, if recorded.
 String? get appVersion;/// Snapshot format version, if recorded.
 int? get formatVersion;
/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupMetadataCopyWith<BackupMetadata> get copyWith => _$BackupMetadataCopyWithImpl<BackupMetadata>(this as BackupMetadata, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BackupMetadata;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupMetadata&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.modifiedAt, _this.modifiedAt) || other.modifiedAt == _this.modifiedAt)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes)&&(identical(other.appVersion, _this.appVersion) || other.appVersion == _this.appVersion)&&(identical(other.formatVersion, _this.formatVersion) || other.formatVersion == _this.formatVersion));
}


@override
int get hashCode {
  final _this = this as BackupMetadata;
  return Object.hash(runtimeType,_this.id,_this.modifiedAt,_this.sizeBytes,_this.appVersion,_this.formatVersion);
}

@override
String toString() {
  final _this = this as BackupMetadata;
  return 'BackupMetadata(id: ${_this.id}, modifiedAt: ${_this.modifiedAt}, sizeBytes: ${_this.sizeBytes}, appVersion: ${_this.appVersion}, formatVersion: ${_this.formatVersion})';
}


}

/// @nodoc
abstract mixin class $BackupMetadataCopyWith<$Res>  {
  factory $BackupMetadataCopyWith(BackupMetadata value, $Res Function(BackupMetadata) _then) = _$BackupMetadataCopyWithImpl;
@useResult
$Res call({
 String id, DateTime modifiedAt, int sizeBytes, String? appVersion, int? formatVersion
});




}
/// @nodoc
class _$BackupMetadataCopyWithImpl<$Res>
    implements $BackupMetadataCopyWith<$Res> {
  _$BackupMetadataCopyWithImpl(this._self, this._then);

  final BackupMetadata _self;
  final $Res Function(BackupMetadata) _then;

/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? modifiedAt = null,Object? sizeBytes = null,Object? appVersion = freezed,Object? formatVersion = freezed,}) {
  return _then(BackupMetadata(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,formatVersion: freezed == formatVersion ? _self.formatVersion : formatVersion // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupMetadata].
extension BackupMetadataPatterns on BackupMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupMetadata value)  $default,){
final _that = this;
switch (_that) {
case _BackupMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime modifiedAt,  int sizeBytes,  String? appVersion,  int? formatVersion)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
return $default(_that.id,_that.modifiedAt,_that.sizeBytes,_that.appVersion,_that.formatVersion);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime modifiedAt,  int sizeBytes,  String? appVersion,  int? formatVersion)  $default,) {final _that = this;
switch (_that) {
case _BackupMetadata():
return $default(_that.id,_that.modifiedAt,_that.sizeBytes,_that.appVersion,_that.formatVersion);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime modifiedAt,  int sizeBytes,  String? appVersion,  int? formatVersion)?  $default,) {final _that = this;
switch (_that) {
case _BackupMetadata() when $default != null:
return $default(_that.id,_that.modifiedAt,_that.sizeBytes,_that.appVersion,_that.formatVersion);case _:
  return null;

}
}

}

/// @nodoc


class _BackupMetadata implements BackupMetadata {
  const _BackupMetadata({required this.id, required this.modifiedAt, required this.sizeBytes, this.appVersion, this.formatVersion});
  

/// Remote file identifier.
@override final  String id;
@override final  DateTime modifiedAt;
@override final  int sizeBytes;
/// Version of the app that wrote the backup, if recorded.
@override final  String? appVersion;
/// Snapshot format version, if recorded.
@override final  int? formatVersion;

/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupMetadataCopyWith<_BackupMetadata> get copyWith => __$BackupMetadataCopyWithImpl<_BackupMetadata>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupMetadata&&(identical(other.id, id) || other.id == id)&&(identical(other.modifiedAt, modifiedAt) || other.modifiedAt == modifiedAt)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.formatVersion, formatVersion) || other.formatVersion == formatVersion));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,modifiedAt,sizeBytes,appVersion,formatVersion);
}

@override
String toString() {
    return 'BackupMetadata(id: $id, modifiedAt: $modifiedAt, sizeBytes: $sizeBytes, appVersion: $appVersion, formatVersion: $formatVersion)';
}


}

/// @nodoc
abstract mixin class _$BackupMetadataCopyWith<$Res> implements $BackupMetadataCopyWith<$Res> {
  factory _$BackupMetadataCopyWith(_BackupMetadata value, $Res Function(_BackupMetadata) _then) = __$BackupMetadataCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime modifiedAt, int sizeBytes, String? appVersion, int? formatVersion
});




}
/// @nodoc
class __$BackupMetadataCopyWithImpl<$Res>
    implements _$BackupMetadataCopyWith<$Res> {
  __$BackupMetadataCopyWithImpl(this._self, this._then);

  final _BackupMetadata _self;
  final $Res Function(_BackupMetadata) _then;

/// Create a copy of BackupMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? modifiedAt = null,Object? sizeBytes = null,Object? appVersion = freezed,Object? formatVersion = freezed,}) {
  return _then(_BackupMetadata(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,modifiedAt: null == modifiedAt ? _self.modifiedAt : modifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime,sizeBytes: null == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int,appVersion: freezed == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String?,formatVersion: freezed == formatVersion ? _self.formatVersion : formatVersion // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
