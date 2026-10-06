// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GoogleAccount _$GoogleAccountFromJson(Map<String, dynamic> json) =>
    _GoogleAccount(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
    );

Map<String, dynamic> _$GoogleAccountToJson(_GoogleAccount instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': ?instance.displayName,
      'photoUrl': ?instance.photoUrl,
    };
