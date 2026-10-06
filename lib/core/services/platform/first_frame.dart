import 'first_frame_native.dart'
    if (dart.library.js_interop) 'first_frame_web.dart'
    as platform;

/// Completes once the app's first frame is actually visible to the user —
/// or after [timeout] at the latest, so callers can never hang on a
/// platform that fails to report it.
///
/// * Native: the engine's first-frame rasterization report.
/// * Web: the engine's `flutter-first-frame` DOM event (frame timings are
///   not reliably reported on the web).
Future<void> waitForFirstFrameShown({
  Duration timeout = const Duration(seconds: 3),
}) => Future.any([platform.firstFrameShown(), Future<void>.delayed(timeout)]);
