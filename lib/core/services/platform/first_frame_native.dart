import 'package:flutter/widgets.dart';

/// Native implementation: the engine reports when the first frame has been
/// rasterized.
Future<void> firstFrameShown() =>
    WidgetsBinding.instance.waitUntilFirstFrameRasterized;
