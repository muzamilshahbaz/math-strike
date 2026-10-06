import 'package:freezed_annotation/freezed_annotation.dart';

import 'app_exception.dart';

part 'failure.freezed.dart';

/// A domain-level description of an operation that did not succeed.
///
/// Failures are values (not thrown) and are returned inside a `Result`.
/// The presentation layer maps them to user-facing messages.
@freezed
sealed class Failure with _$Failure {
  /// Reading or writing local data failed.
  const factory Failure.storage(String message, {Object? cause}) =
      StorageFailure;

  /// A network call failed or the device is offline.
  const factory Failure.network(String message, {Object? cause}) =
      NetworkFailure;

  /// Sign-in failed, was cancelled, or credentials expired.
  const factory Failure.auth(String message, {Object? cause}) = AuthFailure;

  /// The user dismissed a sign-in or consent prompt.
  const factory Failure.authCancelled(String message) = AuthCancelledFailure;

  /// Data was malformed or failed validation.
  const factory Failure.dataFormat(String message, {Object? cause}) =
      DataFormatFailure;

  /// Anything not covered above. Always logged as an error.
  const factory Failure.unexpected(String message, {Object? cause}) =
      UnexpectedFailure;

  /// Maps any thrown object to the most specific [Failure].
  factory Failure.fromError(Object error) => switch (error) {
    StorageException(:final message, :final cause) => Failure.storage(
      message,
      cause: cause,
    ),
    NetworkException(:final message, :final cause) => Failure.network(
      message,
      cause: cause,
    ),
    AuthCancelledException(:final message) => Failure.authCancelled(message),
    AuthException(:final message, :final cause) => Failure.auth(
      message,
      cause: cause,
    ),
    DataFormatException(:final message, :final cause) => Failure.dataFormat(
      message,
      cause: cause,
    ),
    FormatException(:final message) => Failure.dataFormat(
      message,
      cause: error,
    ),
    _ => Failure.unexpected(error.toString(), cause: error),
  };
}
