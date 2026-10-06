import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/authentication/domain/entities/account_link.dart';
import '../features/authentication/presentation/controllers/account_controller.dart';
import '../features/splash/presentation/controllers/startup_controller.dart';
import 'app_routes.dart';

part 'app_gate.freezed.dart';
part 'app_gate.g.dart';

/// Everything the router needs to decide whether the player may enter the
/// app yet.
@freezed
abstract class AppGate with _$AppGate {
  /// Creates a gate state.
  const factory AppGate({
    @Default(false) bool startupCompleted,

    /// First-launch setup stage; `null` when no account is linked yet.
    AccountSetupStage? stage,
  }) = _AppGate;
}

/// Combines start-up and account state into an [AppGate].
@Riverpod(keepAlive: true)
AppGate appGate(Ref ref) {
  if (!ref.watch(startupControllerProvider).isCompleted) return const AppGate();
  // The account link lives in the database, which is open from here on.
  return AppGate(
    startupCompleted: true,
    stage: ref.watch(accountControllerProvider)?.stage,
  );
}

/// Routes that belong to the start-up / first-launch flow.
const Set<String> _gateRoutes = {
  AppRoutes.splash,
  AppRoutes.signIn,
  AppRoutes.accountSetup,
  AppRoutes.onboarding,
};

/// The app's navigation guard, in order:
///
/// 1. start-up not finished → splash (remembering the requested location);
/// 2. no linked account → mandatory sign-in;
/// 3. backup not checked yet → backup check / restore;
/// 4. no profile yet → onboarding;
/// 5. otherwise gate routes forward to the remembered location or home.
///
/// The remembered location must be an in-app path outside the gate flow,
/// so crafted links cannot redirect elsewhere.
String? appRedirect({required Uri uri, required AppGate gate}) {
  final path = uri.path;
  if (!gate.startupCompleted) {
    if (path == AppRoutes.splash) return null;
    return Uri(
      path: AppRoutes.splash,
      queryParameters: {AppRoutes.fromParam: uri.toString()},
    ).toString();
  }

  final requiredRoute = switch (gate.stage) {
    null => AppRoutes.signIn,
    AccountSetupStage.restoreCheck => AppRoutes.accountSetup,
    AccountSetupStage.onboarding => AppRoutes.onboarding,
    AccountSetupStage.complete => null,
  };
  if (requiredRoute != null) {
    return path == requiredRoute ? null : requiredRoute;
  }

  if (!_gateRoutes.contains(path)) return null;
  final from = uri.queryParameters[AppRoutes.fromParam];
  final isSafe =
      from != null &&
      from.startsWith('/') &&
      !from.startsWith('//') &&
      !_gateRoutes.contains(Uri.parse(from).path);
  return isSafe ? from : AppRoutes.home;
}
