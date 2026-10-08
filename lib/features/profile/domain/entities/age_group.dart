import 'difficulty.dart';

/// The player's age bracket. Shapes the starting difficulty and, from
/// Phase 6, which subjects and number ranges the math engine uses.
enum AgeGroup {
  /// Preschool: counting, shapes, tiny sums.
  preschool('3–5 years', 'Counting, shapes and first sums', Difficulty.easy),

  /// Early primary.
  earlyPrimary(
    '6–8 years',
    'Adding, subtracting and times tables',
    Difficulty.easy,
  ),

  /// Late primary.
  latePrimary(
    '9–12 years',
    'Multiplying, dividing and fractions',
    Difficulty.medium,
  ),

  /// Teenagers.
  teen('13–16 years', 'Algebra, percentages and powers', Difficulty.hard),

  /// Adults and seniors.
  adult('Adult', 'Quick mental math for every day', Difficulty.medium),

  /// Player-defined: no age-based assumptions.
  custom('Custom', 'Choose your own level', Difficulty.medium);

  const AgeGroup(this.label, this.description, this.recommendedDifficulty);

  /// Short label, e.g. "6–8 years".
  final String label;

  /// What the bracket practises.
  final String description;

  /// Difficulty suggested when this group is picked.
  final Difficulty recommendedDifficulty;
}
