import 'package:freezed_annotation/freezed_annotation.dart';

part 'startup_state.freezed.dart';

/// Lifecycle of the start-up pipeline.
enum StartupStatus {
  /// Not started yet.
  idle,

  /// Tasks are running.
  running,

  /// A critical task failed; waiting for the user to retry.
  failed,

  /// Every task finished (non-critical ones may have failed).
  completed,
}

/// A task that did not complete.
@freezed
abstract class StartupFailure with _$StartupFailure {
  /// Creates a failure record.
  const factory StartupFailure({
    required String taskId,
    required String taskLabel,
    required String message,
  }) = _StartupFailure;
}

/// Observable state of the start-up pipeline.
@freezed
abstract class StartupState with _$StartupState {
  /// Creates a state.
  const factory StartupState({
    @Default(StartupStatus.idle) StartupStatus status,

    /// Weighted completion, 0.0–1.0.
    @Default(0.0) double progress,

    /// Label of the task currently running.
    String? currentTaskLabel,

    /// The critical failure that stopped start-up, if any.
    StartupFailure? failure,

    /// Non-critical failures; start-up continued past these.
    @Default(<StartupFailure>[]) List<StartupFailure> warnings,
  }) = _StartupState;

  const StartupState._();

  /// Whether start-up finished and the app may leave the splash screen.
  bool get isCompleted => status == StartupStatus.completed;
}
