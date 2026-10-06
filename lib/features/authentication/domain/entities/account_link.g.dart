// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AccountLink _$AccountLinkFromJson(Map<String, dynamic> json) => _AccountLink(
  account: GoogleAccount.fromJson(json['account'] as Map<String, dynamic>),
  linkedAt: DateTime.parse(json['linkedAt'] as String),
  stage:
      $enumDecodeNullable(
        _$AccountSetupStageEnumMap,
        json['stage'],
        unknownValue: AccountSetupStage.restoreCheck,
      ) ??
      AccountSetupStage.restoreCheck,
);

Map<String, dynamic> _$AccountLinkToJson(_AccountLink instance) =>
    <String, dynamic>{
      'account': instance.account.toJson(),
      'linkedAt': instance.linkedAt.toIso8601String(),
      'stage': _$AccountSetupStageEnumMap[instance.stage]!,
    };

const _$AccountSetupStageEnumMap = {
  AccountSetupStage.restoreCheck: 'restoreCheck',
  AccountSetupStage.onboarding: 'onboarding',
  AccountSetupStage.complete: 'complete',
};
