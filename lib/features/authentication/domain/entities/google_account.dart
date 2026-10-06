import 'package:freezed_annotation/freezed_annotation.dart';

part 'google_account.freezed.dart';
part 'google_account.g.dart';

/// The Google account the player signed in with.
@freezed
abstract class GoogleAccount with _$GoogleAccount {
  /// Creates an account.
  const factory GoogleAccount({
    /// Stable Google user ID (OpenID `sub`).
    required String id,
    required String email,
    String? displayName,
    String? photoUrl,
  }) = _GoogleAccount;

  const GoogleAccount._();

  /// Deserialises an account.
  factory GoogleAccount.fromJson(Map<String, dynamic> json) =>
      _$GoogleAccountFromJson(json);

  /// Best available human-readable name.
  String get label =>
      (displayName?.trim().isNotEmpty ?? false) ? displayName!.trim() : email;
}
