import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/features/math/domain/engine/math_text.dart';
import 'package:math_strike/features/math/domain/entities/fraction.dart';

void main() {
  group('Fraction', () {
    test('is always stored in lowest terms with a positive denominator', () {
      expect(Fraction(6, 8), Fraction(3, 4));
      expect(Fraction(3, -4).numerator, -3);
      expect(Fraction(3, -4).denominator, 4);
      expect(Fraction(0, 5), Fraction(0));
      expect(() => Fraction(1, 0), throwsArgumentError);
    });

    test('does exact arithmetic', () {
      expect(Fraction(1, 2) + Fraction(1, 3), Fraction(5, 6));
      expect(Fraction(3, 4) - Fraction(1, 4), Fraction(1, 2));
      expect(Fraction(2, 3) * Fraction(3, 4), Fraction(1, 2));
      expect(Fraction(2, 3) / Fraction(4, 5), Fraction(5, 6));
    });

    test('displays proper, mixed, whole and negative values', () {
      expect(Fraction(3, 4).toString(), '3/4');
      expect(Fraction(5, 4).toString(), '1 1/4');
      expect(Fraction(5, 4).improper, '5/4');
      expect(Fraction(8, 4).toString(), '2');
      expect(Fraction(-1, 2).toString(), '−1/2');
      expect(Fraction(-7, 2).toString(), '−3 1/2');
    });

    test('compares by value', () {
      expect(Fraction(1, 3).compareTo(Fraction(1, 2)), lessThan(0));
      expect(Fraction(2, 4).compareTo(Fraction(1, 2)), 0);
      expect(Fraction.gcd(12, 18), 6);
      expect(Fraction.lcm(4, 6), 12);
    });
  });

  group('MathText', () {
    test('writes each value exactly one way', () {
      expect(MathText.integer(-1250), '−1,250');
      expect(MathText.term(-5), '(−5)');
      expect(MathText.term(5), '5');
      expect(MathText.decimal(150, 2), '1.5');
      expect(MathText.decimal(105, 2), '1.05');
      expect(MathText.decimal(300, 2), '3');
      expect(MathText.decimal(-25, 1), '−2.5');
      expect(MathText.decimal(1, 3), '0.001');
    });

    test('formats money, powers and percentages', () {
      expect(MathText.money(325), r'$3.25');
      expect(MathText.money(300), r'$3.00');
      expect(MathText.money(300, allowWhole: true), r'$3');
      expect(MathText.money(123456), r'$1,234.56');
      expect(MathText.power(2, 10), '2^10');
      expect(MathText.power(10, -2), '10^−2');
      expect(MathText.power(-3, 2), '(−3)^2');
      expect(MathText.percent(45), '45%');
    });

    test('splits exponent markup into runs and speaks it', () {
      expect(MathText.runs('2^3 × 2^−2 = ?'), [
        ('2', false),
        ('3', true),
        (' × 2', false),
        ('−2', true),
        (' = ?', false),
      ]);
      expect(MathText.runs('7 + 5'), [('7 + 5', false)]);
      expect(MathText.spoken('2^5 = ?'), '2 to the power of 5 = ?');
      expect(MathText.spoken('√49'), 'square root of 49');
      expect(MathText.spoken('${MathText.cubeRoot}27'), 'cube root of 27');
    });
  });
}
