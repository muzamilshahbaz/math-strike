import 'package:flutter/foundation.dart';

import '../engine/math_text.dart';

/// An exact rational number, always stored in lowest terms with a positive
/// denominator, so equal values have equal representations.
@immutable
final class Fraction implements Comparable<Fraction> {
  /// Creates `numerator / denominator`, simplified. [denominator] must not
  /// be zero.
  factory Fraction(int numerator, [int denominator = 1]) {
    if (denominator == 0) throw ArgumentError.value(denominator, 'denominator');
    final sign = denominator < 0 ? -1 : 1;
    final divisor = gcd(numerator.abs(), denominator.abs());
    return Fraction._(
      sign * numerator ~/ divisor,
      sign * denominator ~/ divisor,
    );
  }

  const Fraction._(this.numerator, this.denominator);

  /// Greatest common divisor of two non-negative integers (`gcd(0, n) = n`).
  static int gcd(int a, int b) {
    while (b != 0) {
      (a, b) = (b, a % b);
    }
    return a == 0 ? 1 : a;
  }

  /// Least common multiple of two positive integers.
  static int lcm(int a, int b) => a ~/ gcd(a, b) * b;

  /// Top number (sign carrier).
  final int numerator;

  /// Bottom number, always positive.
  final int denominator;

  /// Whether this is a whole number.
  bool get isWhole => denominator == 1;

  /// Approximate value.
  double get value => numerator / denominator;

  /// Sum.
  Fraction operator +(Fraction other) => Fraction(
    numerator * other.denominator + other.numerator * denominator,
    denominator * other.denominator,
  );

  /// Difference.
  Fraction operator -(Fraction other) =>
      this + Fraction(-other.numerator, other.denominator);

  /// Product.
  Fraction operator *(Fraction other) =>
      Fraction(numerator * other.numerator, denominator * other.denominator);

  /// Quotient. [other] must not be zero.
  Fraction operator /(Fraction other) =>
      Fraction(numerator * other.denominator, denominator * other.numerator);

  /// Display form: `3`, `3/4`, or a mixed number such as `1 1/4`.
  @override
  String toString() {
    if (isWhole) return MathText.integer(numerator);
    final whole = numerator.abs() ~/ denominator;
    final rest = numerator.abs() % denominator;
    final sign = numerator < 0 ? MathText.minus : '';
    return whole == 0
        ? '$sign$rest/$denominator'
        : '$sign$whole $rest/$denominator';
  }

  /// Display form without mixed numbers: `5/4`.
  String get improper => isWhole
      ? MathText.integer(numerator)
      : '${numerator < 0 ? MathText.minus : ''}${numerator.abs()}/$denominator';

  @override
  int compareTo(Fraction other) =>
      (numerator * other.denominator).compareTo(other.numerator * denominator);

  @override
  bool operator ==(Object other) =>
      other is Fraction &&
      other.numerator == numerator &&
      other.denominator == denominator;

  @override
  int get hashCode => Object.hash(numerator, denominator);
}
