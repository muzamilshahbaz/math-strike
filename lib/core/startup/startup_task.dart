import 'package:flutter/foundation.dart';

/// One unit of work performed behind the splash screen.
///
/// Features contribute tasks to the start-up pipeline (see
/// `startupTasksProvider`); the pipeline runs them in order, reports
/// weighted progress and decides what a failure means via [isCritical].
@immutable
final class StartupTask {
  /// Creates a task.
  const StartupTask({
    required this.id,
    required this.label,
    required this.run,
    this.weight = 1,
    this.isCritical = false,
    this.timeout = const Duration(seconds: 10),
  }) : assert(weight > 0, 'weight must be positive');

  /// Stable identifier, used for logging and to skip completed work on retry.
  final String id;

  /// User-facing description shown under the progress bar.
  final String label;

  /// The work itself.
  final Future<void> Function() run;

  /// Relative share of the progress bar (slow tasks get a bigger share).
  final double weight;

  /// When true, failure stops start-up and offers a retry. When false, the
  /// failure is logged and start-up continues (e.g. ads, cloud services:
  /// the game must still work offline).
  final bool isCritical;

  /// Maximum time the task may take before it is treated as failed.
  final Duration timeout;
}
