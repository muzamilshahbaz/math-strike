import 'package:freezed_annotation/freezed_annotation.dart';

part 'reward.freezed.dart';
part 'reward.g.dart';

/// A bundle of currencies and experience granted to the player.
@freezed
abstract class Reward with _$Reward {
  /// Creates a reward. Every amount must be zero or more.
  @Assert('coins >= 0 && diamonds >= 0 && xp >= 0')
  const factory Reward({
    @Default(0) int coins,
    @Default(0) int diamonds,
    @Default(0) int xp,
  }) = _Reward;

  const Reward._();

  /// Deserialises a reward.
  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  /// Whether nothing is granted.
  bool get isEmpty => coins == 0 && diamonds == 0 && xp == 0;
}
