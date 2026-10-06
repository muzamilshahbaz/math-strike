import 'dart:io';

import 'package:flutter/services.dart';

/// Loads the real Roboto and Material Icons fonts shipped with the Flutter
/// SDK, so golden images show readable text instead of test placeholder
/// glyphs.
///
/// Golden images are platform-sensitive (font hinting differs between
/// Windows, macOS and Linux); regenerate them on the CI platform with
/// `flutter test --update-goldens --tags golden`.
Future<void> loadGoldenFonts() async {
  final root = Platform.environment['FLUTTER_ROOT'];
  if (root == null) return;
  final fonts = '$root/bin/cache/artifacts/material_fonts';

  Future<void> load(String family, List<String> files) async {
    final loader = FontLoader(family);
    for (final file in files) {
      final bytes = File('$fonts/$file').readAsBytesSync();
      loader.addFont(Future.value(ByteData.sublistView(bytes)));
    }
    await loader.load();
  }

  await load('Roboto', [
    'roboto-regular.ttf',
    'roboto-medium.ttf',
    'roboto-bold.ttf',
    'roboto-black.ttf',
  ]);
  await load('MaterialIcons', ['materialicons-regular.otf']);
}
