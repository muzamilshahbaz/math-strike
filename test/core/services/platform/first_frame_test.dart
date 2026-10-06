import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/services/platform/first_frame.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Regression: on the web the engine never reported a rasterized first
  // frame, so the splash waited forever. This uses the real (un-mocked)
  // signal, which the test environment likewise never reports: the timeout
  // must still let callers proceed.
  test(
    'never hangs when the platform does not report the first frame',
    () async {
      final stopwatch = Stopwatch()..start();

      await waitForFirstFrameShown(timeout: const Duration(milliseconds: 50));

      expect(stopwatch.elapsedMilliseconds, lessThan(2000));
    },
  );
}
