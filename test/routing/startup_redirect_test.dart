import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/routing/app_router.dart';
import 'package:math_strike/routing/app_routes.dart';

void main() {
  String? redirect(String location, {required bool done}) =>
      startupRedirect(uri: Uri.parse(location), startupCompleted: done);

  group('before start-up completes', () {
    test('stays on the splash', () {
      expect(redirect(AppRoutes.splash, done: false), isNull);
    });

    test('sends other locations to the splash, remembering them', () {
      expect(redirect('/settings', done: false), '/splash?from=%2Fsettings');
    });
  });

  group('after start-up completes', () {
    test('leaves non-splash locations alone', () {
      expect(redirect('/shop', done: true), isNull);
    });

    test('forwards the splash to the remembered location', () {
      expect(redirect('/splash?from=%2Fsettings', done: true), '/settings');
    });

    test('forwards the splash to home by default', () {
      expect(redirect(AppRoutes.splash, done: true), AppRoutes.home);
    });

    test('rejects unsafe or looping return targets', () {
      for (final from in [
        'https://evil.example',
        '//evil.example',
        '/splash',
      ]) {
        final location = Uri(
          path: AppRoutes.splash,
          queryParameters: {AppRoutes.fromParam: from},
        ).toString();
        expect(redirect(location, done: true), AppRoutes.home, reason: from);
      }
    });
  });
}
