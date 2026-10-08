import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure_messages.dart';
import '../../../../core/errors/result.dart';
import '../../../authentication/domain/entities/account_link.dart';
import '../../../authentication/presentation/controllers/account_controller.dart';
import '../../../settings/presentation/controllers/audio_settings_controller.dart';
import '../../domain/entities/age_group.dart';
import '../../domain/entities/difficulty.dart';
import '../../domain/entities/player_profile.dart';
import '../avatars/avatar_catalog.dart';
import 'profile_controller.dart';

part 'onboarding_controller.freezed.dart';
part 'onboarding_controller.g.dart';

/// The onboarding wizard's steps, in order.
enum OnboardingStep {
  /// Player name.
  name,

  /// Avatar choice.
  avatar,

  /// Age group.
  age,

  /// Base difficulty.
  difficulty,

  /// Visual theme and light/dark mode.
  theme,

  /// Sound effects and music.
  sound,

  /// Summary and confirmation.
  summary,
}

/// The player's choices while onboarding is in progress.
@freezed
abstract class OnboardingState with _$OnboardingState {
  /// Creates a state.
  const factory OnboardingState({
    @Default(OnboardingStep.name) OnboardingStep step,

    /// Direction of the last step change (+1 forward, -1 back), for
    /// transitions.
    @Default(1) int direction,
    @Default('') String name,
    required String avatarId,
    AgeGroup? ageGroup,
    @Default(Difficulty.medium) Difficulty difficulty,

    /// Whether the player chose a difficulty themselves (then picking an
    /// age group no longer overrides it).
    @Default(false) bool difficultyChosen,
    @Default(true) bool soundEnabled,
    @Default(true) bool musicEnabled,
    @Default(false) bool saving,
    String? errorMessage,
  }) = _OnboardingState;

  const OnboardingState._();

  /// Problem with the current name, or null when valid.
  String? get nameError => PlayerProfile.validateName(name);

  /// Whether the current step is complete enough to move on.
  bool get canProceed => switch (step) {
    OnboardingStep.name => nameError == null,
    OnboardingStep.age => ageGroup != null,
    _ => true,
  };

  /// 1-based position, for "Step 2 of 7".
  int get stepNumber => step.index + 1;
}

/// Drives the onboarding wizard and saves the result.
@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingState build() {
    // Suggest the first name from the linked Google account.
    final displayName = ref
        .read(accountControllerProvider)
        ?.account
        .displayName;
    final firstName = displayName?.trim().split(RegExp(r'\s+')).first ?? '';
    final suggestion = PlayerProfile.validateName(firstName) == null
        ? PlayerProfile.normalizeName(firstName)
        : '';
    return OnboardingState(
      name: suggestion,
      avatarId: AvatarCatalog.starters.first.id,
    );
  }

  /// Updates the name.
  void setName(String name) =>
      state = state.copyWith(name: name, errorMessage: null);

  /// Selects an avatar.
  void setAvatar(String id) => state = state.copyWith(avatarId: id);

  /// Selects an age group, suggesting its difficulty unless the player has
  /// already picked one.
  void setAgeGroup(AgeGroup group) => state = state.copyWith(
    ageGroup: group,
    difficulty: state.difficultyChosen
        ? state.difficulty
        : group.recommendedDifficulty,
  );

  /// Selects a difficulty.
  void setDifficulty(Difficulty difficulty) =>
      state = state.copyWith(difficulty: difficulty, difficultyChosen: true);

  /// Toggles sound effects.
  void setSound({required bool enabled}) =>
      state = state.copyWith(soundEnabled: enabled);

  /// Toggles music.
  void setMusic({required bool enabled}) =>
      state = state.copyWith(musicEnabled: enabled);

  /// Moves to the next step if the current one is complete.
  void next() {
    if (!state.canProceed || state.step == OnboardingStep.summary) return;
    state = state.copyWith(
      step: OnboardingStep.values[state.step.index + 1],
      direction: 1,
    );
  }

  /// Moves to the previous step. Returns false on the first step.
  bool back() {
    if (state.step == OnboardingStep.name || state.saving) return false;
    state = state.copyWith(
      step: OnboardingStep.values[state.step.index - 1],
      direction: -1,
      errorMessage: null,
    );
    return true;
  }

  /// Saves the profile and audio choices and finishes first-launch setup.
  /// (Theme choices are applied live by the theme step.)
  Future<void> complete() async {
    final ageGroup = state.ageGroup;
    if (state.saving || ageGroup == null || state.nameError != null) return;
    state = state.copyWith(saving: true, errorMessage: null);

    final profile = PlayerProfile(
      name: PlayerProfile.normalizeName(state.name),
      avatarId: state.avatarId,
      ageGroup: ageGroup,
      difficulty: state.difficulty,
      createdAt: DateTime.now().toUtc(),
    );
    final audio = ref
        .read(audioSettingsControllerProvider)
        .copyWith(
          soundEnabled: state.soundEnabled,
          musicEnabled: state.musicEnabled,
        );

    final results = [
      await ref.read(audioSettingsControllerProvider.notifier).save(audio),
      await ref.read(profileControllerProvider.notifier).save(profile),
      await ref
          .read(accountControllerProvider.notifier)
          .advanceTo(AccountSetupStage.complete),
    ];
    if (!ref.mounted) return;
    final failure = results.whereType<Err<void>>().firstOrNull?.failure;
    state = state.copyWith(
      saving: false,
      errorMessage: failure == null
          ? null
          : describeFailure(
              failure,
              fallback: "We couldn't save your profile. Please try again.",
            ),
    );
  }
}
