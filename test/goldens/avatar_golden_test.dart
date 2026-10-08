@Tags(['golden'])
library;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/features/profile/presentation/avatars/avatar_catalog.dart';
import 'package:math_strike/features/profile/presentation/avatars/avatar_view.dart';

import '../helpers/golden_fonts.dart';
import '../helpers/test_app.dart';

/// Catalogue sheet of every starter avatar, at a large and a small size.
void main() {
  setUpAll(loadGoldenFonts);

  testWidgets('avatar catalogue', (tester) async {
    tester.setWindowSize(const Size(720, 560));
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(
          color: const Color(0xFF15102E),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Wrap(
              spacing: 20,
              runSpacing: 16,
              children: [
                for (final avatar in AvatarCatalog.starters)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AvatarView(avatar: avatar, size: 96),
                      const SizedBox(height: 4),
                      Text(
                        avatar.name,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                for (final avatar in AvatarCatalog.starters)
                  AvatarView(avatar: avatar, size: 32),
              ],
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/avatar_catalog.png'),
    );
  });
}
