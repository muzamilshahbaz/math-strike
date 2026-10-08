// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Wallet _$WalletFromJson(Map<String, dynamic> json) => _Wallet(
  coins: (json['coins'] as num?)?.toInt() ?? 0,
  diamonds: (json['diamonds'] as num?)?.toInt() ?? 0,
  xp: (json['xp'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$WalletToJson(_Wallet instance) => <String, dynamic>{
  'coins': instance.coins,
  'diamonds': instance.diamonds,
  'xp': instance.xp,
};
