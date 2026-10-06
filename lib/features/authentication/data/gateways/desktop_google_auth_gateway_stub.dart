import '../../../../core/config/google_config.dart';
import '../../../../core/services/logging/app_logger.dart';
import 'google_auth_gateway.dart';

/// Web stand-in for the desktop gateway factory: desktop OAuth needs
/// `dart:io`, which does not exist on the web (the plugin gateway is used
/// there instead).
GoogleAuthGateway createDesktopGoogleAuthGateway({
  required GoogleConfig config,
  required AppLogger logger,
}) => throw UnsupportedError('Desktop Google sign-in is not available here');
