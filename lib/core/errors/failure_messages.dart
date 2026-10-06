import 'failure.dart';

/// Friendly, non-technical text for showing a [Failure] to the player.
///
/// [offline] and [fallback] let a screen tailor the most common cases.
String describeFailure(
  Failure failure, {
  String offline =
      "You're offline. Check your internet connection and try "
      'again.',
  String fallback = 'Something went wrong. Please try again.',
}) => switch (failure) {
  NetworkFailure() => offline,
  // Auth and data-format messages are written for players already.
  AuthFailure(:final message) || DataFormatFailure(:final message) => message,
  AuthCancelledFailure() => 'Sign-in was cancelled.',
  StorageFailure() || UnexpectedFailure() => fallback,
};
