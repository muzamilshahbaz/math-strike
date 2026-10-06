import 'package:freezed_annotation/freezed_annotation.dart';

import 'google_account.dart';

part 'account_link.freezed.dart';
part 'account_link.g.dart';

/// Where this installation is in the mandatory first-launch flow.
enum AccountSetupStage {
  /// Signed in; Drive must be checked for an existing backup.
  restoreCheck,

  /// No backup was restored; the player must create a profile (Phase 4).
  onboarding,

  /// Setup finished; the app is fully usable (offline included).
  complete,
}

/// The Google account this installation is linked to, persisted on the
/// device (never backed up).
///
/// Being *linked* is what the mandatory sign-in requires. After the first
/// sign-in the game works fully offline: a live Google session is only
/// needed again for Drive backup and restore.
@freezed
abstract class AccountLink with _$AccountLink {
  /// Creates a link.
  const factory AccountLink({
    required GoogleAccount account,
    required DateTime linkedAt,
    @JsonKey(unknownEnumValue: AccountSetupStage.restoreCheck)
    @Default(AccountSetupStage.restoreCheck)
    AccountSetupStage stage,
  }) = _AccountLink;

  /// Deserialises a link.
  factory AccountLink.fromJson(Map<String, dynamic> json) =>
      _$AccountLinkFromJson(json);
}
