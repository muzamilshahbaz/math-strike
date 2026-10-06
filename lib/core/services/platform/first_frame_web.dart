import 'dart:async';
import 'dart:js_interop';

import 'package:web/web.dart' as web;

/// Set by `web/index.html` when the engine dispatches `flutter-first-frame`,
/// so a listener registered after the event can still observe it.
@JS('__msFirstFrameShown')
external JSBoolean? get _firstFrameShownFlag;

/// Web implementation: waits for the engine's `flutter-first-frame` event.
Future<void> firstFrameShown() {
  if (_firstFrameShownFlag?.toDart ?? false) return Future.value();

  final completer = Completer<void>();
  late final JSFunction listener;
  listener = ((web.Event _) {
    web.window.removeEventListener('flutter-first-frame', listener);
    if (!completer.isCompleted) completer.complete();
  }).toJS;
  web.window.addEventListener('flutter-first-frame', listener);
  return completer.future;
}
