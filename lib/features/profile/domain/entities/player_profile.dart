import 'package:freezed_annotation/freezed_annotation.dart';

import 'age_group.dart';
import 'difficulty.dart';

part 'player_profile.freezed.dart';
part 'player_profile.g.dart';

/// The local player. Created by onboarding, stored on the device and
/// included in backups.
@freezed
abstract class PlayerProfile with _$PlayerProfile {
  /// Creates a profile.
  const factory PlayerProfile({
    required String name,

    /// Stable avatar identifier (see the avatar catalogue).
    required String avatarId,
    @JsonKey(unknownEnumValue: AgeGroup.custom) required AgeGroup ageGroup,
    @JsonKey(unknownEnumValue: Difficulty.medium)
    required Difficulty difficulty,
    required DateTime createdAt,
  }) = _PlayerProfile;

  /// Deserialises a profile.
  factory PlayerProfile.fromJson(Map<String, dynamic> json) =>
      _$PlayerProfileFromJson(json);

  /// Maximum player-name length.
  static const int maxNameLength = 16;

  static final RegExp _allowedName = RegExp(
    r"^[\p{L}\p{N} '\-.]+$",
    unicode: true,
  );

  /// Returns a player-facing problem with [name], or `null` if it is valid.
  static String? validateName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return 'Please enter a name';
    if (trimmed.length > maxNameLength) {
      return 'Use $maxNameLength characters or fewer';
    }
    if (!_allowedName.hasMatch(trimmed)) {
      return 'Use letters, numbers and spaces only';
    }
    return null;
  }

  /// Normalises whitespace in a (valid) name.
  static String normalizeName(String name) =>
      name.trim().replaceAll(RegExp(r'\s+'), ' ');
}
