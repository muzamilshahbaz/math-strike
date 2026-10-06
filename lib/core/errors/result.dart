import 'failure.dart';

/// The outcome of an operation that can fail: either [Success] or [Err].
///
/// Repositories return `Result`s instead of throwing, which forces callers
/// to handle the failure path explicitly (exhaustive `switch`).
sealed class Result<T> {
  const Result();

  /// Runs [action] and captures any thrown error as a [Failure].
  static Future<Result<T>> guard<T>(Future<T> Function() action) async {
    try {
      return Success(await action());
    } on Object catch (error) {
      return Err(Failure.fromError(error));
    }
  }

  /// Synchronous variant of [guard].
  static Result<T> guardSync<T>(T Function() action) {
    try {
      return Success(action());
    } on Object catch (error) {
      return Err(Failure.fromError(error));
    }
  }

  /// Whether this is a [Success].
  bool get isSuccess => this is Success<T>;

  /// The success value, or `null` for an [Err].
  T? get valueOrNull => switch (this) {
    Success(:final value) => value,
    Err() => null,
  };

  /// The failure, or `null` for a [Success].
  Failure? get failureOrNull => switch (this) {
    Success() => null,
    Err(:final failure) => failure,
  };

  /// Collapses both branches into a single value.
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) => switch (this) {
    Success(:final value) => onSuccess(value),
    Err(:final failure) => onFailure(failure),
  };

  /// Transforms the success value, leaving failures untouched.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success(:final value) => Success(transform(value)),
    Err(:final failure) => Err(failure),
  };
}

/// A successful [Result] carrying [value].
final class Success<T> extends Result<T> {
  /// Creates a successful result.
  const Success(this.value);

  /// The produced value.
  final T value;

  @override
  bool operator ==(Object other) => other is Success<T> && other.value == value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

/// A failed [Result] carrying a [Failure].
final class Err<T> extends Result<T> {
  /// Creates a failed result.
  const Err(this.failure);

  /// Why the operation failed.
  final Failure failure;

  @override
  bool operator ==(Object other) => other is Err<T> && other.failure == failure;

  @override
  int get hashCode => failure.hashCode;

  @override
  String toString() => 'Err($failure)';
}
