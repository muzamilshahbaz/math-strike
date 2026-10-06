import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/theme/app_tokens.dart';
import '../../../../core/theme/brand_colors.dart';
import '../../../../core/theme/theme_context.dart';
import '../../../../core/widgets/brand/math_strike_logo.dart';
import '../../../../core/widgets/brand/math_strike_wordmark.dart';
import '../../domain/entities/startup_state.dart';
import '../../splash_providers.dart';
import '../controllers/startup_controller.dart';
import '../widgets/particle_field.dart';
import '../widgets/splash_progress.dart';
import '../widgets/startup_error_panel.dart';

/// Animated brand splash that runs the start-up pipeline.
///
/// Choreography (1.8 s, one controller with staggered intervals):
/// 1. the emblem pops in with an elastic scale while the reticle spins
///    into place;
/// 2. the projectile accelerates in and *strikes* the centre — impact
///    flash plus a small kick of the emblem;
/// 3. the wordmark is wiped in by a light sweep;
/// 4. the tagline, then the progress bar, fade in.
///
/// A glow pulse and a particle backdrop loop underneath. With reduced
/// motion the final pose is shown immediately and nothing loops.
///
/// Navigation away is handled by the router once start-up completes.
class SplashScreen extends ConsumerStatefulWidget {
  /// Creates the splash screen.
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );
  late final AnimationController _ambient = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 40),
  );
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  );

  late final Animation<double> _logoScale = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0, 0.4, curve: Curves.elasticOut),
  );
  late final Animation<double> _logoOpacity = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0, 0.12, curve: Curves.easeOut),
  );
  late final Animation<double> _reticleSpin = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0, 0.45, curve: Curves.easeOutCubic),
  );
  // Accelerating projectile: eases *in* so it hits hard.
  late final Animation<double> _strike = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.3, 0.48, curve: Curves.easeInCubic),
  );
  // Impact: instant attack, slow decay.
  late final Animation<double> _flash =
      TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0,
            end: 1,
          ).chain(CurveTween(curve: Curves.easeOut)),
          weight: 12,
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 1,
            end: 0,
          ).chain(CurveTween(curve: Curves.easeIn)),
          weight: 88,
        ),
      ]).animate(
        CurvedAnimation(parent: _entrance, curve: const Interval(0.47, 0.8)),
      );
  late final Animation<double> _wordmark = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.5, 0.8, curve: Curves.easeInOutCubic),
  );
  late final Animation<double> _tagline = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.72, 0.9, curve: Curves.easeOut),
  );
  late final Animation<double> _footer = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.8, 1, curve: Curves.easeOut),
  );

  /// Whether the splash has actually reached the screen.
  bool _onScreen = false;

  @override
  void initState() {
    super.initState();
    // Wait until the first frame is *rasterized*, not merely built: on the
    // web the engine may still be loading fonts/shaders behind the HTML
    // pre-loader for a while after the first build. Starting earlier would
    // play the entrance and burn the minimum splash time while invisible.
    unawaited(
      ref.read(firstFrameRasterizedSignalProvider)().then((_) {
        if (!mounted) return;
        _onScreen = true;
        _syncMotion();
        unawaited(ref.read(startupControllerProvider.notifier).start());
      }),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _syncMotion();
  }

  void _syncMotion() {
    if (!_onScreen) return;
    if (context.reduceMotion) {
      _entrance.value = 1;
      _ambient.stop();
      _pulse
        ..stop()
        ..value = 0.5;
    } else {
      if (!_entrance.isCompleted && !_entrance.isAnimating) {
        unawaited(_entrance.forward());
      }
      if (!_ambient.isAnimating) unawaited(_ambient.repeat());
      if (!_pulse.isAnimating) unawaited(_pulse.repeat(reverse: true));
    }
  }

  @override
  void dispose() {
    _entrance.dispose();
    _ambient.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startup = ref.watch(startupControllerProvider);
    final version = ref.watch(appInfoProvider).value?.displayVersion;
    final screen = MediaQuery.sizeOf(context);
    final logoSize = (screen.shortestSide * 0.28).clamp(96.0, 160.0);
    // Wordmark spans at most ~80% of the width, capped for large screens.
    final wordmarkHeight =
        ((screen.width - 2 * AppSpacing.lg) *
                0.8 /
                MathStrikeWordmark.aspectRatio)
            .clamp(18.0, 40.0);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: BrandColors.midnight,
        body: Stack(
          fit: StackFit.expand,
          children: [
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: BrandColors.backgroundGradient,
              ),
            ),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.25),
                  radius: 0.9,
                  colors: [BrandColors.nebula, Colors.transparent],
                ),
              ),
            ),
            ExcludeSemantics(
              child: RepaintBoundary(child: ParticleField(animation: _ambient)),
            ),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _AnimatedLogo(
                        size: logoSize,
                        scale: _logoScale,
                        opacity: _logoOpacity,
                        spin: _reticleSpin,
                        strike: _strike,
                        flash: _flash,
                        pulse: _pulse,
                      ),
                      SizedBox(height: logoSize * 0.28),
                      AnimatedBuilder(
                        animation: _wordmark,
                        builder: (context, _) => MathStrikeWordmark(
                          height: wordmarkHeight,
                          reveal: _wordmark.value,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.smd),
                      const SizedBox(height: AppSpacing.sm),
                      FadeTransition(
                        opacity: _tagline,
                        child: Text(
                          'Solve it. Aim it. Strike it!',
                          style: TextStyle(
                            color: BrandColors.star.withValues(alpha: 0.7),
                            fontSize: 15,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xxl),
                      FadeTransition(
                        opacity: _footer,
                        child: _StatusArea(
                          startup: startup,
                          onRetry: () => unawaited(
                            ref
                                .read(startupControllerProvider.notifier)
                                .retry(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (version != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: AppSpacing.md,
                child: SafeArea(
                  top: false,
                  child: FadeTransition(
                    opacity: _footer,
                    child: Text(
                      version,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: BrandColors.star.withValues(alpha: 0.45),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedLogo extends StatelessWidget {
  const _AnimatedLogo({
    required this.size,
    required this.scale,
    required this.opacity,
    required this.spin,
    required this.strike,
    required this.flash,
    required this.pulse,
  });

  final double size;
  final Animation<double> scale;
  final Animation<double> opacity;
  final Animation<double> spin;
  final Animation<double> strike;
  final Animation<double> flash;
  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([scale, opacity, spin, strike, flash, pulse]),
      builder: (context, _) => Opacity(
        opacity: opacity.value,
        child: Transform.scale(
          // Elastic curves overshoot below zero at the very start; the
          // impact adds a short kick.
          scale:
              math.max(0, 0.3 + 0.7 * scale.value) * (1 + 0.06 * flash.value),
          child: MathStrikeLogo(
            size: size,
            // Three-quarter turn that settles exactly on the resting pose.
            reticleTurns: (1 - spin.value) * -0.75,
            strike: strike.value,
            flash: flash.value,
            glow: math.min(1, 0.35 + 0.65 * pulse.value + flash.value),
          ),
        ),
      ),
    );
  }
}

class _StatusArea extends StatelessWidget {
  const _StatusArea({required this.startup, required this.onRetry});

  final StartupState startup;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final failure = startup.failure;
    return AnimatedSwitcher(
      duration: context.motion(const Duration(milliseconds: 250)),
      child: startup.status == StartupStatus.failed && failure != null
          ? StartupErrorPanel(failure: failure, onRetry: onRetry)
          : SplashProgress(
              progress: startup.progress,
              label: startup.isCompleted ? 'Ready' : startup.currentTaskLabel,
            ),
    );
  }
}
