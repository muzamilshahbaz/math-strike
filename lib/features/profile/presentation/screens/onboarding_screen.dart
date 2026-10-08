import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_durations.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/responsive/window_size.dart';
import '../avatars/avatar_catalog.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/player_card.dart';
import 'onboarding_steps.dart';

/// Profile creation for new players: name, avatar, age group, difficulty,
/// theme, sound — then a summary. Mandatory (the router keeps the player
/// here until a profile exists).
///
/// * Animated, direction-aware transitions between steps.
/// * Enter continues, the system back button goes to the previous step.
/// * On wide screens a live player card previews the choices.
class OnboardingScreen extends ConsumerStatefulWidget {
  /// Creates the screen.
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  OnboardingController get _controller =>
      ref.read(onboardingControllerProvider.notifier);

  /// Receives keyboard shortcuts on steps without a text field.
  final FocusNode _shortcutFocus = FocusNode(debugLabel: 'onboarding');

  @override
  void dispose() {
    _shortcutFocus.dispose();
    super.dispose();
  }

  /// Enter key. The name step's text field submits by itself (this also
  /// covers the "done" key of on-screen keyboards), so the shortcut stands
  /// down there to avoid advancing twice.
  void _onEnter() {
    if (ref.read(onboardingControllerProvider).step != OnboardingStep.name) {
      _primaryAction();
    }
  }

  void _primaryAction() {
    final state = ref.read(onboardingControllerProvider);
    if (state.step == OnboardingStep.summary) {
      unawaited(_controller.complete());
    } else {
      _controller.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final wide = context.windowSize >= WindowSize.expanded;

    // Leaving the name step disposes its text field; move focus back here
    // so Enter keeps working.
    ref.listen(onboardingControllerProvider.select((s) => s.step), (_, step) {
      if (step != OnboardingStep.name) _shortcutFocus.requestFocus();
    });

    final stepView = AnimatedSwitcher(
      duration: context.motion(AppDurations.medium),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final incoming = child.key == ValueKey(state.step);
        final dx = (incoming ? 0.12 : -0.12) * state.direction;
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween(
              begin: Offset(dx, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey(state.step),
        child: OnboardingStepView(step: state.step),
      ),
    );

    return PopScope(
      canPop: false,
      // System back goes to the previous step; it never leaves onboarding.
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _controller.back();
      },
      child: CallbackShortcuts(
        bindings: {
          const SingleActivator(LogicalKeyboardKey.enter): _onEnter,
          const SingleActivator(LogicalKeyboardKey.numpadEnter): _onEnter,
        },
        child: Focus(
          focusNode: _shortcutFocus,
          autofocus: true,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: wide ? 1000 : 600),
                      child: _Header(state: state, onBack: _controller.back),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: wide ? 980 : 560),
                        child: wide
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(child: stepView),
                                  const SizedBox(width: AppSpacing.xl),
                                  SizedBox(
                                    width: 320,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: AppSpacing.xl,
                                      ),
                                      child: _LivePreview(state: state),
                                    ),
                                  ),
                                ],
                              )
                            : stepView,
                      ),
                    ),
                  ),
                  _Footer(state: state, onPressed: _primaryAction),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.state, required this.onBack});

  final OnboardingState state;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final total = OnboardingStep.values.length;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.md,
        0,
      ),
      child: Row(
        children: [
          SizedBox(
            width: AppSizes.minTouchTarget,
            child: state.step == OnboardingStep.name
                ? null
                : IconButton(
                    tooltip: 'Back',
                    onPressed: state.saving ? null : onBack,
                    icon: const Icon(Icons.arrow_back_rounded),
                  ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Semantics(
              label: 'Step ${state.stepNumber} of $total',
              child: ClipRRect(
                borderRadius: const BorderRadius.all(AppRadii.pill),
                child: TweenAnimationBuilder<double>(
                  tween: Tween(end: state.stepNumber / total),
                  duration: context.motion(AppDurations.medium),
                  curve: Curves.easeOutCubic,
                  builder: (context, value, _) =>
                      LinearProgressIndicator(value: value, minHeight: 8),
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.smd),
          ExcludeSemantics(
            child: Text(
              '${state.stepNumber} / $total',
              style: context.textStyles.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.state, required this.onPressed});

  final OnboardingState state;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final isLast = state.step == OnboardingStep.summary;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560, minHeight: 56),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: state.canProceed && !state.saving ? onPressed : null,
              child: state.saving
                  ? SizedBox.square(
                      dimension: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: context.colors.onPrimary,
                        semanticsLabel: 'Saving',
                      ),
                    )
                  : Text(isLast ? "Let's play!" : 'Continue'),
            ),
          ),
        ),
      ),
    );
  }
}

class _LivePreview extends StatelessWidget {
  const _LivePreview({required this.state});

  final OnboardingState state;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Text(
        'Preview',
        style: context.textStyles.titleSmall?.copyWith(
          color: context.colors.primary,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      PlayerCard(
        avatar: AvatarCatalog.byId(state.avatarId),
        name: state.name,
        ageGroup: state.ageGroup,
        difficulty: state.ageGroup == null ? null : state.difficulty,
        avatarSize: 120,
      ),
    ],
  );
}
