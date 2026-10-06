import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/startup/startup_task.dart';
import '../../domain/entities/startup_state.dart';
import '../../splash_providers.dart';

part 'startup_controller.g.dart';

/// Runs the start-up pipeline and exposes its progress.
///
/// * Tasks run in registry order with weighted progress.
/// * A failing *critical* task stops the pipeline in [StartupStatus.failed];
///   [retry] resumes from that task (completed tasks are not re-run).
/// * A failing non-critical task is recorded in `warnings` and skipped.
/// * Completion is held back until `splashMinimumDuration` has elapsed.
@Riverpod(keepAlive: true)
class StartupController extends _$StartupController {
  final Set<String> _completed = {};
  Future<void>? _inFlight;

  @override
  StartupState build() => const StartupState();

  /// Starts the pipeline. Safe to call repeatedly: concurrent calls share
  /// the same run, and calls after completion do nothing.
  Future<void> start() {
    if (state.isCompleted) return Future.value();
    return _inFlight ??= _run().whenComplete(() => _inFlight = null);
  }

  /// Re-runs the pipeline after a critical failure.
  Future<void> retry() => start();

  Future<void> _run() async {
    final tasks = ref.read(startupTasksProvider);
    final minimumDuration = ref.read(splashMinimumDurationProvider);
    final logger = ref.read(appLoggerProvider);
    final stopwatch = Stopwatch()..start();

    final totalWeight = tasks.fold<double>(0, (sum, t) => sum + t.weight);
    double progress() => totalWeight == 0
        ? 1
        : tasks
                  .where((t) => _completed.contains(t.id))
                  .fold<double>(0, (sum, t) => sum + t.weight) /
              totalWeight;

    state = state.copyWith(
      status: StartupStatus.running,
      failure: null,
      progress: progress(),
    );

    for (final task in tasks) {
      if (_completed.contains(task.id)) continue;
      state = state.copyWith(currentTaskLabel: task.label);

      final failure = await _execute(task);
      if (!ref.mounted) return;

      if (failure != null) {
        if (task.isCritical) {
          logger.error('Critical start-up task "${task.id}" failed');
          state = state.copyWith(
            status: StartupStatus.failed,
            failure: failure,
          );
          return;
        }
        logger.warning('Start-up task "${task.id}" failed; continuing');
        state = state.copyWith(warnings: [...state.warnings, failure]);
      }
      _completed.add(task.id);
      state = state.copyWith(progress: progress());
    }

    final remaining = minimumDuration - stopwatch.elapsed;
    if (remaining > Duration.zero) await Future<void>.delayed(remaining);
    if (!ref.mounted) return;

    logger.info('Start-up completed in ${stopwatch.elapsedMilliseconds} ms');
    state = state.copyWith(
      status: StartupStatus.completed,
      currentTaskLabel: null,
      progress: 1,
    );
  }

  /// Runs [task], returning a [StartupFailure] instead of throwing.
  Future<StartupFailure?> _execute(StartupTask task) async {
    try {
      await task.run().timeout(task.timeout);
      return null;
    } on Object catch (error, stackTrace) {
      ref
          .read(appLoggerProvider)
          .warning(
            'Task "${task.id}" error',
            error: error,
            stackTrace: stackTrace,
          );
      return StartupFailure(
        taskId: task.id,
        taskLabel: task.label,
        message: error.toString(),
      );
    }
  }
}
