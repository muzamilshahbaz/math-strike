import 'package:freezed_annotation/freezed_annotation.dart';

import 'player_level.dart';
import 'reward.dart';

part 'wallet.freezed.dart';
part 'wallet.g.dart';

/// The player's balances: coins and diamonds to spend, and lifetime
/// experience that determines their [level].
@freezed
abstract class Wallet with _$Wallet {
  /// Creates a wallet.
  const factory Wallet({
    @Default(0) int coins,
    @Default(0) int diamonds,

    /// Lifetime experience points; never spent.
    @Default(0) int xp,
  }) = _Wallet;

  const Wallet._();

  /// Deserialises a wallet.
  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  /// This wallet with [reward] added.
  Wallet credit(Reward reward) => copyWith(
    coins: coins + reward.coins,
    diamonds: diamonds + reward.diamonds,
    xp: xp + reward.xp,
  );

  /// The player level reached with [xp].
  PlayerLevel get level => PlayerLevel.fromXp(xp);
}
