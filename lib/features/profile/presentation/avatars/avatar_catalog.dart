import 'package:flutter/material.dart';

/// Body silhouette of an avatar.
enum AvatarBody {
  /// Circle.
  round,

  /// Rounded square (robots).
  boxy,

  /// Bell / gumdrop.
  bell,

  /// Wide oval.
  blob,
}

/// Eye style of an avatar.
enum AvatarEyes {
  /// Small solid dots.
  dots,

  /// Large cartoon eyes with highlights.
  big,

  /// Robot visor bar.
  visor,

  /// Closed, happy arcs.
  happy,
}

/// What sits on top of the head.
enum AvatarTop {
  /// Nothing.
  none,

  /// Single antenna with a glowing tip.
  antenna,

  /// Pointy cat ears.
  ears,

  /// Two small horns.
  horns,

  /// Glass space helmet.
  helmet,
}

/// Parameters of one avatar. Avatars are drawn from these in code, so they
/// are crisp at any size, identical on every platform and need no assets.
@immutable
class AvatarSpec {
  /// Creates a spec.
  const AvatarSpec({
    required this.id,
    required this.name,
    required this.color,
    required this.accent,
    required this.body,
    required this.eyes,
    required this.top,
  });

  /// Stable identifier stored in the profile. Never rename.
  final String id;

  /// Display name (also the accessibility label).
  final String name;

  /// Main body colour.
  final Color color;

  /// Accessory / background accent colour.
  final Color accent;

  /// Silhouette.
  final AvatarBody body;

  /// Eye style.
  final AvatarEyes eyes;

  /// Head accessory.
  final AvatarTop top;
}

/// The avatar catalogue.
abstract final class AvatarCatalog {
  /// Avatars available from the start. Unlockable avatars join the
  /// catalogue with the rewards system (Phase 10).
  static const List<AvatarSpec> starters = [
    AvatarSpec(
      id: 'bolt',
      name: 'Bolt',
      color: Color(0xFF3FD0FF),
      accent: Color(0xFFFFD54F),
      body: AvatarBody.boxy,
      eyes: AvatarEyes.visor,
      top: AvatarTop.antenna,
    ),
    AvatarSpec(
      id: 'nova',
      name: 'Nova',
      color: Color(0xFF7CE38B),
      accent: Color(0xFFB388FF),
      body: AvatarBody.round,
      eyes: AvatarEyes.big,
      top: AvatarTop.antenna,
    ),
    AvatarSpec(
      id: 'whiskers',
      name: 'Whiskers',
      color: Color(0xFFFFA45B),
      accent: Color(0xFF5BC0FF),
      body: AvatarBody.round,
      eyes: AvatarEyes.big,
      top: AvatarTop.ears,
    ),
    AvatarSpec(
      id: 'comet',
      name: 'Comet',
      color: Color(0xFFFF7EB6),
      accent: Color(0xFF7C4DFF),
      body: AvatarBody.blob,
      eyes: AvatarEyes.happy,
      top: AvatarTop.horns,
    ),
    AvatarSpec(
      id: 'astro',
      name: 'Astro',
      color: Color(0xFFE8ECF5),
      accent: Color(0xFF3D5AFE),
      body: AvatarBody.round,
      eyes: AvatarEyes.dots,
      top: AvatarTop.helmet,
    ),
    AvatarSpec(
      id: 'zap',
      name: 'Zap',
      color: Color(0xFFFFD54F),
      accent: Color(0xFFFF5252),
      body: AvatarBody.boxy,
      eyes: AvatarEyes.big,
      top: AvatarTop.horns,
    ),
    AvatarSpec(
      id: 'orbit',
      name: 'Orbit',
      color: Color(0xFFB388FF),
      accent: Color(0xFF00E5FF),
      body: AvatarBody.bell,
      eyes: AvatarEyes.big,
      top: AvatarTop.none,
    ),
    AvatarSpec(
      id: 'luna',
      name: 'Luna',
      color: Color(0xFFCFC2FF),
      accent: Color(0xFFFF80AB),
      body: AvatarBody.round,
      eyes: AvatarEyes.happy,
      top: AvatarTop.ears,
    ),
    AvatarSpec(
      id: 'rex',
      name: 'Rex',
      color: Color(0xFF26C6A6),
      accent: Color(0xFFFFB74D),
      body: AvatarBody.blob,
      eyes: AvatarEyes.big,
      top: AvatarTop.horns,
    ),
    AvatarSpec(
      id: 'chip',
      name: 'Chip',
      color: Color(0xFFFF6B6B),
      accent: Color(0xFF64FFDA),
      body: AvatarBody.boxy,
      eyes: AvatarEyes.dots,
      top: AvatarTop.antenna,
    ),
    AvatarSpec(
      id: 'pip',
      name: 'Pip',
      color: Color(0xFF64B5F6),
      accent: Color(0xFFFFEE58),
      body: AvatarBody.bell,
      eyes: AvatarEyes.dots,
      top: AvatarTop.none,
    ),
    AvatarSpec(
      id: 'gizmo',
      name: 'Gizmo',
      color: Color(0xFFC6FF00),
      accent: Color(0xFF7C4DFF),
      body: AvatarBody.bell,
      eyes: AvatarEyes.visor,
      top: AvatarTop.antenna,
    ),
  ];

  /// Looks up [id], falling back to the first starter for unknown ids
  /// (e.g. an avatar from a newer app version).
  static AvatarSpec byId(String id) =>
      starters.firstWhere((a) => a.id == id, orElse: () => starters.first);
}
