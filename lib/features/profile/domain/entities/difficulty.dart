/// Base challenge level. The adaptive engine (Phase 6) adjusts within and
/// around it based on the player's accuracy and reaction time.
enum Difficulty {
  /// Relaxed pace, small numbers, generous time.
  easy('Easy', 'Relaxed pace and smaller numbers'),

  /// Balanced.
  medium('Medium', 'A balanced challenge'),

  /// Faster enemies and harder questions.
  hard('Hard', 'Faster enemies, trickier questions'),

  /// For math whizzes.
  expert('Expert', 'Lightning speed for math whizzes');

  const Difficulty(this.label, this.description);

  /// Display name.
  final String label;

  /// One-line explanation.
  final String description;
}
