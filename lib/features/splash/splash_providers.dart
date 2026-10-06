/// Dependency-injection bindings for the splash feature, including the
/// start-up task registry.
library;

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/di/core_providers.dart';
import '../../core/errors/result.dart';
import '../../core/services/platform/first_frame.dart';
import '../../core/startup/startup_task.dart';
import '../authentication/authentication_providers.dart';
import '../authentication/presentation/controllers/account_controller.dart';
import '../settings/presentation/controllers/appearance_controller.dart';

part 'splash_providers.g.dart';

/// The ordered list of start-up tasks.
///
/// Tasks run sequentially because later ones depend on earlier ones (the
/// theme and launch record need the database). Later phases register their
/// own tasks here:
///
/// * Phase 8 – audio preloading
/// * Phase 12 – ads SDK (non-critical: the game must start offline)
@Riverpod(keepAlive: true)
List<StartupTask> startupTasks(Ref ref) => [
  StartupTask(
    id: 'database',
    label: 'Opening your save data',
    weight: 3,
    isCritical: true,
    timeout: const Duration(seconds: 20),
    run: () async {
      // After a failed attempt, discard the cached error and try again.
      if (ref.read(openedLocalDatabaseProvider).hasError) {
        ref.invalidate(openedLocalDatabaseProvider);
      }
      await ref.read(openedLocalDatabaseProvider.future);
    },
  ),
  StartupTask(
    id: 'theme',
    label: 'Loading your theme',
    run: () async => ref.read(appearanceControllerProvider),
  ),
  StartupTask(
    id: 'version',
    label: 'Checking app version',
    run: () async {
      final launch = await ref.read(launchInfoProvider.future);
      ref
          .read(appLoggerProvider)
          .info(
            'Launch #${launch.launchCount} of ${launch.currentVersion}'
            '${launch.isVersionChange ? ' (updated)' : ''}',
          );
    },
  ),
  StartupTask(
    id: 'google',
    label: 'Connecting to Google',
    // Non-critical: a linked player must be able to play offline.
    timeout: const Duration(seconds: 10),
    run: () async {
      final auth = ref.read(authRepositoryProvider);
      // Initialise the SDK now so interactive sign-in can open its pop-up
      // straight from the button press (required on the web).
      if (await auth.prepare() case Err(:final failure)) throw failure;
      if (ref.read(accountControllerProvider) == null) return;
      if (await auth.restoreSession() case Err(:final failure)) throw failure;
    },
  ),
];

/// Minimum time the splash stays visible, so the brand animation can play
/// even when start-up is instant: the 1.8 s logo sequence plus a short hold.
/// Overridden with zero in tests.
@Riverpod(keepAlive: true)
Duration splashMinimumDuration(Ref ref) => const Duration(milliseconds: 2200);

/// Resolves when the first frame is actually visible (bounded by a timeout,
/// see [waitForFirstFrameShown]).
///
/// On the web the engine can still be loading fonts and shaders behind the
/// HTML pre-loader well after the first build, so the splash waits for this
/// before animating. Widget tests have no engine and override this with an
/// immediately-completing signal.
@Riverpod(keepAlive: true)
Future<void> Function() firstFrameRasterizedSignal(Ref ref) =>
    waitForFirstFrameShown;
