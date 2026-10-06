import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_messages.dart';
import '../../../../core/errors/result.dart';
import 'account_controller.dart';

part 'sign_in_controller.freezed.dart';
part 'sign_in_controller.g.dart';

/// UI state of the sign-in screen.
@freezed
abstract class SignInState with _$SignInState {
  /// Creates a state.
  const factory SignInState({
    /// A sign-in attempt is in progress.
    @Default(false) bool busy,

    /// The last attempt was dismissed by the user.
    @Default(false) bool cancelled,

    /// The last attempt failed with this player-facing message.
    String? errorMessage,
  }) = _SignInState;
}

/// Drives the mandatory sign-in screen. On success the account controller
/// links the device and the router moves on by itself.
@riverpod
class SignInController extends _$SignInController {
  @override
  SignInState build() => const SignInState();

  /// Starts interactive sign-in. Must be called from a user gesture (the web
  /// opens a pop-up).
  Future<void> signIn() async {
    if (state.busy) return;
    state = const SignInState(busy: true);
    final result = await ref.read(accountControllerProvider.notifier).signIn();
    if (!ref.mounted) return;
    state = switch (result) {
      Success() => const SignInState(),
      Err(failure: AuthCancelledFailure()) => const SignInState(
        cancelled: true,
      ),
      Err(:final failure) => SignInState(
        errorMessage: describeFailure(
          failure,
          offline:
              'You need an internet connection to sign in the first '
              'time. After that, Math Strike works offline.',
        ),
      ),
    };
  }
}
