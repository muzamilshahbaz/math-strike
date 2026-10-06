// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AccountLink {

 GoogleAccount get account; DateTime get linkedAt;@JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck) AccountSetupStage get stage;
/// Create a copy of AccountLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountLinkCopyWith<AccountLink> get copyWith => _$AccountLinkCopyWithImpl<AccountLink>(this as AccountLink, _$identity);

  /// Serializes this AccountLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AccountLink;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountLink&&(identical(other.account, _this.account) || other.account == _this.account)&&(identical(other.linkedAt, _this.linkedAt) || other.linkedAt == _this.linkedAt)&&(identical(other.stage, _this.stage) || other.stage == _this.stage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AccountLink;
  return Object.hash(runtimeType,_this.account,_this.linkedAt,_this.stage);
}

@override
String toString() {
  final _this = this as AccountLink;
  return 'AccountLink(account: ${_this.account}, linkedAt: ${_this.linkedAt}, stage: ${_this.stage})';
}


}

/// @nodoc
abstract mixin class $AccountLinkCopyWith<$Res>  {
  factory $AccountLinkCopyWith(AccountLink value, $Res Function(AccountLink) _then) = _$AccountLinkCopyWithImpl;
@useResult
$Res call({
 GoogleAccount account, DateTime linkedAt,@JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck) AccountSetupStage stage
});


$GoogleAccountCopyWith<$Res> get account;

}
/// @nodoc
class _$AccountLinkCopyWithImpl<$Res>
    implements $AccountLinkCopyWith<$Res> {
  _$AccountLinkCopyWithImpl(this._self, this._then);

  final AccountLink _self;
  final $Res Function(AccountLink) _then;

/// Create a copy of AccountLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? account = null,Object? linkedAt = null,Object? stage = null,}) {
  return _then(AccountLink(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as GoogleAccount,linkedAt: null == linkedAt ? _self.linkedAt : linkedAt // ignore: cast_nullable_to_non_nullable
as DateTime,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as AccountSetupStage,
  ));
}
/// Create a copy of AccountLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoogleAccountCopyWith<$Res> get account {
  
  return $GoogleAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}


/// Adds pattern-matching-related methods to [AccountLink].
extension AccountLinkPatterns on AccountLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountLink value)  $default,){
final _that = this;
switch (_that) {
case _AccountLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountLink value)?  $default,){
final _that = this;
switch (_that) {
case _AccountLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( GoogleAccount account,  DateTime linkedAt, @JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck)  AccountSetupStage stage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountLink() when $default != null:
return $default(_that.account,_that.linkedAt,_that.stage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( GoogleAccount account,  DateTime linkedAt, @JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck)  AccountSetupStage stage)  $default,) {final _that = this;
switch (_that) {
case _AccountLink():
return $default(_that.account,_that.linkedAt,_that.stage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( GoogleAccount account,  DateTime linkedAt, @JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck)  AccountSetupStage stage)?  $default,) {final _that = this;
switch (_that) {
case _AccountLink() when $default != null:
return $default(_that.account,_that.linkedAt,_that.stage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountLink implements AccountLink {
  const _AccountLink({required this.account, required this.linkedAt, @JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck) this.stage = AccountSetupStage.restoreCheck});
  factory _AccountLink.fromJson(Map<String, dynamic> json) => _$AccountLinkFromJson(json);

@override final  GoogleAccount account;
@override final  DateTime linkedAt;
@override@JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck) final  AccountSetupStage stage;

/// Create a copy of AccountLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountLinkCopyWith<_AccountLink> get copyWith => __$AccountLinkCopyWithImpl<_AccountLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountLinkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountLink&&(identical(other.account, account) || other.account == account)&&(identical(other.linkedAt, linkedAt) || other.linkedAt == linkedAt)&&(identical(other.stage, stage) || other.stage == stage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,account,linkedAt,stage);
}

@override
String toString() {
    return 'AccountLink(account: $account, linkedAt: $linkedAt, stage: $stage)';
}


}

/// @nodoc
abstract mixin class _$AccountLinkCopyWith<$Res> implements $AccountLinkCopyWith<$Res> {
  factory _$AccountLinkCopyWith(_AccountLink value, $Res Function(_AccountLink) _then) = __$AccountLinkCopyWithImpl;
@override @useResult
$Res call({
 GoogleAccount account, DateTime linkedAt,@JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck) AccountSetupStage stage
});


@override $GoogleAccountCopyWith<$Res> get account;

}
/// @nodoc
class __$AccountLinkCopyWithImpl<$Res>
    implements _$AccountLinkCopyWith<$Res> {
  __$AccountLinkCopyWithImpl(this._self, this._then);

  final _AccountLink _self;
  final $Res Function(_AccountLink) _then;

/// Create a copy of AccountLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? account = null,Object? linkedAt = null,Object? stage = null,}) {
  return _then(_AccountLink(
account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as GoogleAccount,linkedAt: null == linkedAt ? _self.linkedAt : linkedAt // ignore: cast_nullable_to_non_nullable
as DateTime,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as AccountSetupStage,
  ));
}

/// Create a copy of AccountLink
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoogleAccountCopyWith<$Res> get account {
  
  return $GoogleAccountCopyWith<$Res>(_self.account, (value) {
    return _then(_self.copyWith(account: value));
  });
}
}

// dart format on
