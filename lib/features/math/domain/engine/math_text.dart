import '../../../../core/utils/formatters.dart';

/// Canonical text for numbers in questions and answer choices.
///
/// Every value is written exactly one way (e.g. `1.5`, never `1.50`), so
/// two choices are equal as text if and only if they are equal as values.
/// That lets the engine de-duplicate choices by comparing strings.
abstract final class MathText {
  /// The minus sign (U+2212), which reads better than a hyphen.
  static const String minus = '−';

  /// Multiplication sign.
  static const String times = '×';

  /// Division sign.
  static const String divide = '÷';

  /// Currency symbol for money questions.
  static const String currency = r'$';

  /// An integer with thousands separators: `−1,250`.
  static String integer(int value) =>
      value < 0 ? '$minus${formatCount(-value)}' : formatCount(value);

  /// An integer as a later term in an expression, bracketed when negative:
  /// `(−5)`.
  static String term(int value) =>
      value < 0 ? '(${integer(value)})' : integer(value);

  /// A decimal stored as [scaled] / 10^[places], without trailing zeros:
  /// `decimal(150, 2)` → `1.5`.
  static String decimal(int scaled, int places) {
    if (places == 0) return integer(scaled);
    var unit = 1;
    for (var i = 0; i < places; i++) {
      unit *= 10;
    }
    final whole = scaled.abs() ~/ unit;
    var fraction = (scaled.abs() % unit).toString().padLeft(places, '0');
    while (fraction.endsWith('0')) {
      fraction = fraction.substring(0, fraction.length - 1);
    }
    final sign = scaled < 0 ? minus : '';
    final wholeText = formatCount(whole);
    return fraction.isEmpty ? '$sign$wholeText' : '$sign$wholeText.$fraction';
  }

  /// A money amount in cents. Whole-dollar amounts are written without
  /// cents only when [allowWhole] is set (early levels): `$3` or `$3.00`.
  static String money(int cents, {bool allowWhole = false}) {
    final sign = cents < 0 ? minus : '';
    final dollars = formatCount(cents.abs() ~/ 100);
    final rest = cents.abs() % 100;
    if (allowWhole && rest == 0) return '$sign$currency$dollars';
    return '$sign$currency$dollars.${rest.toString().padLeft(2, '0')}';
  }

  /// Marks the start of an exponent: `2^5` means 2 to the power 5.
  ///
  /// Exponents are marked up rather than written with Unicode superscript
  /// digits, which most bundled fonts lack (they would need a runtime font
  /// download). `MathTextView` draws them raised.
  static const String powerMark = '^';

  static final RegExp _exponent = RegExp(r'\^(−?\d+)');

  /// An exponent on whatever precedes it: `raised(3)` → `^3`.
  static String raised(int exponent) => '$powerMark${integer(exponent)}';

  /// `base` raised to `exponent`, e.g. `2^5`; negative bases are bracketed.
  static String power(int base, int exponent) =>
      '${term(base)}${raised(exponent)}';

  /// Cube root sign (a raised 3 before √, which every font has).
  static const String cubeRoot = '³√';

  /// Splits [text] into (plain, exponent) runs for rendering: exponent
  /// runs are `true`.
  static List<(String, bool)> runs(String text) {
    final result = <(String, bool)>[];
    var start = 0;
    for (final match in _exponent.allMatches(text)) {
      if (match.start > start) {
        result.add((text.substring(start, match.start), false));
      }
      result.add((match.group(1)!, true));
      start = match.end;
    }
    if (start < text.length) result.add((text.substring(start), false));
    return result;
  }

  /// [text] as a screen reader should say it: `2^5` → "2 to the power of
  /// 5", `√9` → "square root of 9".
  static String spoken(String text) => text
      .replaceAllMapped(_exponent, (m) => ' to the power of ${m.group(1)}')
      .replaceAll(cubeRoot, 'cube root of ')
      .replaceAll('√', 'square root of ');

  /// A percentage: `45%`.
  static String percent(int value) => '${integer(value)}%';
}
