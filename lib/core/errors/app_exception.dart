/// Base type for exceptions thrown by the data layer.
///
/// Data sources throw [AppException]s; repositories catch them and convert
/// them into `Failure`s so the domain and presentation layers never deal
/// with raw exceptions.
sealed class AppException implements Exception {
  const AppException(this.message, {this.cause, this.stackTrace});

  /// Developer-facing description of what went wrong.
  final String message;

  /// The underlying error, if any.
  final Object? cause;

  /// Stack trace of [cause], if any.
  final StackTrace? stackTrace;

  @override
  String toString() =>
      '$runtimeType: $message${cause == null ? '' : ' ($cause)'}';
}

/// Local persistence failed (Hive, secure storage, file system).
final class StorageException extends AppException {
  /// Creates a [StorageException].
  const StorageException(super.message, {super.cause, super.stackTrace});
}

/// A network request failed or no connectivity was available.
final class NetworkException extends AppException {
  /// Creates a [NetworkException].
  const NetworkException(super.message, {super.cause, super.stackTrace});
}

/// Authentication (Google Sign-In) failed or was cancelled.
final class AuthException extends AppException {
  /// Creates an [AuthException].
  const AuthException(super.message, {super.cause, super.stackTrace});
}

/// The user dismissed a sign-in or consent prompt. Not an error: callers
/// should simply let the user try again.
final class AuthCancelledException extends AppException {
  /// Creates an [AuthCancelledException].
  const AuthCancelledException([super.message = 'Sign-in was cancelled']);
}

/// Data could not be parsed or failed validation.
final class DataFormatException extends AppException {
  /// Creates a [DataFormatException].
  const DataFormatException(super.message, {super.cause, super.stackTrace});
}
