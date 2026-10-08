/// A subject the math engine can ask questions about.
///
/// "Mixed mode" is not a topic: it is a mix of topics picked by the
/// adaptive engine. Topic names are persisted (learning progress), so never
/// rename a value without a migration.
enum MathTopic {
  /// Adding whole numbers.
  addition('Addition', 'Adding numbers together'),

  /// Subtracting whole numbers.
  subtraction('Subtraction', 'Taking away and finding differences'),

  /// Times tables and long multiplication.
  multiplication('Multiplication', 'Times tables and beyond'),

  /// Exact division.
  division('Division', 'Sharing and grouping'),

  /// Fractions of amounts, simplifying and fraction arithmetic.
  fractions('Fractions', 'Parts of a whole'),

  /// Decimal arithmetic.
  decimals('Decimals', 'Numbers with a decimal point'),

  /// Percentages of amounts, increases and decreases.
  percentages('Percentages', 'Parts of a hundred'),

  /// Negative numbers.
  integers('Integers', 'Positive and negative numbers'),

  /// Solving equations.
  algebra('Algebra', 'Find the missing x'),

  /// Shapes, perimeter, area and angles.
  geometry('Geometry', 'Shapes, areas and angles'),

  /// Telling and calculating time.
  time('Time', 'Clocks and durations'),

  /// Prices and change.
  money('Money', 'Prices, totals and change'),

  /// Units of length, mass and capacity.
  measurement('Measurement', 'Units and conversions'),

  /// Chance and likelihood.
  probability('Probability', 'How likely is it?'),

  /// Mean, median, mode and range.
  statistics('Statistics', 'Averages and data'),

  /// Squares, square roots and cube roots.
  squareRoots('Square roots', 'Squares and their roots'),

  /// Powers and exponent laws.
  exponents('Exponents', 'Powers of numbers'),

  /// Everyday problems written in words.
  wordProblems('Word problems', 'Math in real life');

  const MathTopic(this.label, this.description);

  /// Player-facing name.
  final String label;

  /// One-line description.
  final String description;

  /// The topic stored as [name], or `null` for unknown names (e.g. from a
  /// newer app version).
  static MathTopic? tryParse(String name) {
    for (final topic in values) {
      if (topic.name == name) return topic;
    }
    return null;
  }
}
