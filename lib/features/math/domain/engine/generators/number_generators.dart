import 'dart:math' as math;

import '../../entities/fraction.dart';
import '../../entities/math_topic.dart';
import '../../entities/question.dart';
import '../math_text.dart';
import '../question_context.dart';

/// Generators for fractions, decimals, percentages, negative numbers,
/// roots and powers.
const Map<MathTopic, TopicGenerator> numberGenerators = {
  MathTopic.fractions: _fractions,
  MathTopic.decimals: _decimals,
  MathTopic.percentages: _percentages,
  MathTopic.integers: _integers,
  MathTopic.squareRoots: _squareRoots,
  MathTopic.exponents: _exponents,
};

const String _x = MathText.times;
const String _minus = MathText.minus;
String _n(int value) => MathText.integer(value);
String _t(int value) => MathText.term(value);
int _pow(int base, int exponent) => math.pow(base, exponent).toInt();

// ---------------------------------------------------------------------------
// Fractions

Question _fractions(QuestionContext c) => switch (c.level) {
  <= 2 => _fractionOfAmount(c),
  <= 4 => _simplifyFraction(c),
  <= 6 => _sameDenominators(c),
  <= 8 => _differentDenominators(c),
  _ => _multiplyOrDivideFractions(c),
};

/// Alternatives that nudge the numerator of [answer].
String Function(int) _nearbyFractions(Fraction answer) =>
    (attempt) =>
        Fraction(answer.numerator + attempt, answer.denominator).toString();

/// A proper fraction in lowest terms with a denominator in [dens].
Fraction _properFraction(QuestionContext c, List<int> dens) {
  final den = c.pick(dens);
  return Fraction(c.between(1, den - 1), den);
}

Question _fractionOfAmount(QuestionContext c) {
  final den = c.level == 1
      ? c.pick(const [2, 4])
      : c.pick(const [2, 3, 4, 5, 10]);
  var num = c.level == 1 ? 1 : c.between(1, den - 1);
  while (Fraction.gcd(num, den) != 1) {
    num = c.between(1, den - 1);
  }
  final part = c.between(1, c.level == 1 ? 5 : 10);
  final amount = den * part;
  final answer = num * part;
  return c.question(
    prompt: '$num/$den of $amount = ?',
    answer: _n(answer),
    mistakes: [
      if (num > 1) _n(part),
      if (amount - answer > 0) _n(amount - answer),
      _n(answer + 1),
      if (answer > 1) _n(answer - 1),
      _n(amount),
    ],
    alternative: c.nearbyIntegers(answer, min: 1),
    hint: 'Split $amount into $den equal parts, then take $num of them.',
    explanation: num == 1
        ? '$amount ${MathText.divide} $den = $part, so 1/$den of $amount is '
              '$part.'
        : '$amount ${MathText.divide} $den = $part, so 1/$den of $amount is '
              '$part and $num/$den is $num $_x $part = $answer.',
  );
}

Question _simplifyFraction(QuestionContext c) {
  final simple = _properFraction(
    c,
    c.level == 3 ? [2, 3, 4, 5, 6, 8, 10] : [3, 5, 6, 7, 8, 9, 12],
  );
  final factor = c.between(2, c.level == 3 ? 5 : 9);
  final top = simple.numerator * factor;
  final bottom = simple.denominator * factor;
  return c.question(
    prompt: 'Simplify $top/$bottom',
    answer: simple.toString(),
    mistakes: [
      Fraction(simple.numerator, bottom).toString(),
      Fraction(top, simple.denominator).toString(),
      Fraction(simple.numerator + 1, simple.denominator).toString(),
      Fraction(simple.denominator, simple.numerator).toString(),
    ],
    alternative: (attempt) => Fraction(
      simple.numerator + attempt,
      simple.denominator + attempt,
    ).toString(),
    hint: 'Find the biggest number that divides both $top and $bottom.',
    explanation:
        'Both $top and $bottom divide by $factor: $top ${MathText.divide} '
        '$factor = ${simple.numerator} and $bottom ${MathText.divide} '
        '$factor = ${simple.denominator}, so $top/$bottom = $simple.',
  );
}

Question _sameDenominators(QuestionContext c) {
  final den = c.between(3, c.level == 5 ? 10 : 12);
  var a = c.between(1, den - 1);
  var b = c.between(1, den - 1);
  final subtract = c.level == 6 && c.chance(0.5) && a != b;
  if (subtract && a < b) (a, b) = (b, a);
  final rawTop = subtract ? a - b : a + b;
  final answer = Fraction(rawTop, den);
  final op = subtract ? _minus : '+';
  final raw = '$rawTop/$den';
  return c.question(
    prompt: '$a/$den $op $b/$den = ?',
    answer: answer.toString(),
    mistakes: [
      Fraction(rawTop, den * 2).toString(),
      Fraction(subtract ? a + b : (a - b).abs(), den).toString(),
      Fraction(rawTop + 1, den).toString(),
      Fraction(a * b, den).toString(),
    ],
    alternative: _nearbyFractions(answer),
    hint: 'The bottom numbers match, so only the top numbers change.',
    explanation:
        'The denominators are the same, so ${subtract ? 'subtract' : 'add'} '
        'the numerators: $a/$den $op $b/$den = $raw'
        '${raw == answer.toString() ? '' : ' = $answer'}.',
  );
}

Question _differentDenominators(QuestionContext c) {
  final dens = c.level == 7
      ? [2, 3, 4, 5, 6, 8, 10]
      : [2, 3, 4, 5, 6, 8, 9, 10, 12];
  var first = _properFraction(c, dens);
  var second = _properFraction(c, dens);
  while (second.denominator == first.denominator) {
    second = _properFraction(c, dens);
  }
  final subtract = c.level == 8 && c.chance(0.5);
  if (subtract && first.compareTo(second) < 0) {
    (first, second) = (second, first);
  }
  final answer = subtract ? first - second : first + second;
  final common = Fraction.lcm(first.denominator, second.denominator);
  final a = first.numerator * (common ~/ first.denominator);
  final b = second.numerator * (common ~/ second.denominator);
  final op = subtract ? _minus : '+';
  final raw = '${subtract ? a - b : a + b}/$common';
  final wrongTop = subtract
      ? (first.numerator - second.numerator).abs()
      : first.numerator + second.numerator;
  final wrongBottom = subtract
      ? (first.denominator - second.denominator).abs()
      : first.denominator + second.denominator;

  return c.question(
    prompt: '${first.improper} $op ${second.improper} = ?',
    answer: answer.toString(),
    mistakes: [
      if (wrongTop > 0) Fraction(wrongTop, wrongBottom).toString(),
      (first * second).toString(),
      (answer + Fraction(1, common)).toString(),
      if (subtract)
        (first + second).toString()
      else
        (first.compareTo(second) > 0 ? first - second : second - first)
            .toString(),
    ],
    alternative: (attempt) =>
        (answer + Fraction(attempt + 1, common)).toString(),
    hint: 'Rewrite both fractions with the same denominator first.',
    explanation:
        'Use the common denominator $common: ${first.improper} = $a/$common '
        'and ${second.improper} = $b/$common. Then $a/$common $op $b/$common '
        '= $raw${raw == answer.toString() ? '' : ' = $answer'}.',
  );
}

Question _multiplyOrDivideFractions(QuestionContext c) {
  const dens = [2, 3, 4, 5, 6, 7, 8, 9];
  final first = _properFraction(c, dens);
  final second = _properFraction(c, dens);
  final divide = c.level == 10 && c.chance(0.6);
  final answer = divide ? first / second : first * second;
  final (a, b) = (first.numerator, first.denominator);
  final (p, q) = (second.numerator, second.denominator);

  return c.question(
    prompt:
        '${first.improper} ${divide ? MathText.divide : _x} '
        '${second.improper} = ?',
    answer: answer.toString(),
    mistakes: [
      Fraction(a + p, b + q).toString(),
      if (divide) (first * second).toString() else (first / second).toString(),
      Fraction(b * p, a * q).toString(),
      Fraction(a * p, b + q).toString(),
    ],
    alternative: _nearbyFractions(answer),
    hint: divide
        ? 'Flip the second fraction, then multiply.'
        : 'Multiply the top numbers, then the bottom numbers.',
    explanation: divide
        ? 'Dividing by $p/$q is the same as multiplying by $q/$p: '
              '$a/$b $_x $q/$p = ${a * q}/${b * p} = $answer.'
        : 'Multiply tops and bottoms: $a/$b $_x $p/$q = ${a * p}/${b * q}'
              '${Fraction(a * p, b * q).toString() == '${a * p}/${b * q}' ? '' : ' = $answer'}.',
  );
}

// ---------------------------------------------------------------------------
// Decimals

String _d(int scaled, int places) => MathText.decimal(scaled, places);

Question _decimals(QuestionContext c) => switch (c.level) {
  1 => _decimalSum(c, places: 1, min: 1, max: 9, subtract: false),
  2 => _decimalSum(c, places: 1, min: 1, max: 100, subtract: true),
  3 => _decimalSum(c, places: 1, min: 10, max: 1000, subtract: true),
  4 => _decimalSum(c, places: 2, min: 1, max: 1000, subtract: false),
  5 => _decimalSum(c, places: 2, min: 100, max: 10000, subtract: true),
  6 => _mixedPlacesSum(c),
  7 => _decimalTimesWhole(c),
  8 => _powersOfTen(c),
  9 => _decimalTimesDecimal(c),
  _ => _decimalDivide(c),
};

Question _decimalSum(
  QuestionContext c, {
  required int places,
  required int min,
  required int max,
  required bool subtract,
}) {
  var a = c.between(min, max);
  var b = c.between(min, max);
  final isSubtract = subtract && c.chance(0.5);
  if (isSubtract && a < b) (a, b) = (b, a);
  final result = isSubtract ? a - b : a + b;
  final unit = _pow(10, places);
  final op = isSubtract ? _minus : '+';
  return c.question(
    prompt: '${_d(a, places)} $op ${_d(b, places)} = ?',
    answer: _d(result, places),
    mistakes: [
      _d(result, places + 1),
      _d(result * 10, places),
      _d(result + 1, places),
      if (result > 1) _d(result - 1, places),
      _d(result + unit, places),
      if (isSubtract) _d(a + b, places),
    ],
    alternative: c.nearbyIntegers(result, format: (v) => _d(v, places)),
    hint:
        'Line up the decimal points, then '
        '${isSubtract ? 'subtract' : 'add'} as with whole numbers.',
    explanation:
        'Line up the decimal points and ${isSubtract ? 'subtract' : 'add'} '
        'column by column: ${_d(a, places)} $op ${_d(b, places)} = '
        '${_d(result, places)}.',
  );
}

Question _mixedPlacesSum(QuestionContext c) {
  final tenths = c.between(10, 999);
  final hundredths = c.between(100, 9999);
  final result = tenths * 10 + hundredths;
  // tenths written with two decimal places, e.g. 2.5 → 2.50.
  final padded = '${tenths ~/ 10}.${tenths % 10}0';
  return c.question(
    prompt: '${_d(tenths, 1)} + ${_d(hundredths, 2)} = ?',
    answer: _d(result, 2),
    mistakes: [
      _d(tenths + hundredths, 2),
      _d(tenths + hundredths, 1),
      _d(result + 10, 2),
      _d(result - 1, 2),
    ],
    alternative: c.nearbyIntegers(result, format: (v) => _d(v, 2)),
    hint: 'Give both numbers two decimal places before adding.',
    explanation:
        'Write ${_d(tenths, 1)} as $padded so the '
        'decimal points line up: ${_d(tenths, 1)} + ${_d(hundredths, 2)} = '
        '${_d(result, 2)}.',
  );
}

Question _decimalTimesWhole(QuestionContext c) {
  var a = c.between(11, 199);
  if (a % 10 == 0) a++; // Keep a visible decimal digit.
  final whole = c.between(2, 9);
  final product = a * whole;
  return c.question(
    prompt: '${_d(a, 1)} $_x $whole = ?',
    answer: _d(product, 1),
    mistakes: [
      _d(product, 2),
      _n(product),
      _d(product + 1, 1),
      _d(product - 1, 1),
      _d(a + whole * 10, 1),
    ],
    alternative: c.nearbyIntegers(product, format: (v) => _d(v, 1)),
    hint: 'Multiply without the decimal point, then put it back.',
    explanation:
        'Ignore the point: $a $_x $whole = $product. ${_d(a, 1)} has one '
        'decimal place, so the answer does too: ${_d(product, 1)}.',
  );
}

Question _powersOfTen(QuestionContext c) {
  final value = c.between(101, 9999);
  final shift = c.between(1, 3);
  final factor = _pow(10, shift);
  final multiply = c.chance(0.5);
  String shifted(int by) =>
      by >= 0 ? _d(value * _pow(10, by), 2) : _d(value, 2 - by);
  final answer = shifted(multiply ? shift : -shift);
  return c.question(
    prompt:
        '${_d(value, 2)} ${multiply ? _x : MathText.divide} '
        '${_n(factor)} = ?',
    answer: answer,
    mistakes: [
      shifted(multiply ? shift - 1 : -shift + 1),
      shifted(multiply ? shift + 1 : -shift - 1),
      shifted(multiply ? -shift : shift),
    ],
    alternative: (attempt) =>
        shifted(multiply ? shift + attempt + 1 : -shift - attempt - 1),
    hint:
        'Count the zeros in ${_n(factor)}: that is how many places the '
        'digits move.',
    explanation:
        '${multiply ? 'Multiplying' : 'Dividing'} by ${_n(factor)} moves '
        'every digit $shift place${shift == 1 ? '' : 's'} to the '
        '${multiply ? 'left' : 'right'}: ${_d(value, 2)} '
        '${multiply ? _x : MathText.divide} ${_n(factor)} = $answer.',
  );
}

Question _decimalTimesDecimal(QuestionContext c) {
  var a = c.between(11, 99);
  var b = c.between(11, 99);
  // Keep a visible decimal digit in both numbers.
  if (a % 10 == 0) a++;
  if (b % 10 == 0) b++;
  final product = a * b;
  return c.question(
    prompt: '${_d(a, 1)} $_x ${_d(b, 1)} = ?',
    answer: _d(product, 2),
    mistakes: [
      _d(product, 1),
      _d(product, 3),
      _d(product + 10, 2),
      _d(product - 10, 2),
    ],
    alternative: c.nearbyIntegers(product, format: (v) => _d(v, 2)),
    hint:
        'Multiply as whole numbers, then count the decimal places in '
        'both numbers.',
    explanation:
        '$a $_x $b = $product. There are two decimal places in total (one '
        'in each number), so the answer is ${_d(product, 2)}.',
  );
}

Question _decimalDivide(QuestionContext c) {
  final quotient = c.between(11, 999);
  final divisor = c.between(2, 9);
  final dividend = quotient * divisor;
  return c.question(
    prompt: '${_d(dividend, 2)} ${MathText.divide} $divisor = ?',
    answer: _d(quotient, 2),
    mistakes: [
      _d(quotient, 1),
      _d(quotient, 3),
      _d(quotient + 1, 2),
      _d(quotient + 10, 2),
    ],
    alternative: c.nearbyIntegers(quotient, min: 1, format: (v) => _d(v, 2)),
    hint:
        'Divide as with whole numbers and keep the decimal point in the '
        'same place.',
    explanation:
        'Divide as with whole numbers, keeping the decimal point in place: '
        '${_d(dividend, 2)} ${MathText.divide} $divisor = ${_d(quotient, 2)}. '
        'Check: '
        '${_d(quotient, 2)} $_x $divisor = ${_d(dividend, 2)}.',
  );
}

// ---------------------------------------------------------------------------
// Percentages

Question _percentages(QuestionContext c) => switch (c.level) {
  1 => _percentOf(c, const [50], 2, 20, 2),
  2 => _percentOf(c, const [10, 50], 10, 100, 10),
  3 => _percentOf(c, const [10, 20, 25, 50], 20, 200, 20),
  4 => _percentOf(c, const [5, 10, 25, 30, 75], 20, 400, 20),
  5 => _percentOf(c, [for (var p = 5; p < 100; p += 5) p], 20, 500, 20),
  6 => _percentOf(c, [for (var p = 5; p <= 150; p += 5) p], 20, 1000, 20),
  7 || 8 => _whatPercent(c),
  9 => _percentChange(c, increase: true),
  _ => _percentChange(c, increase: false),
};

String _percentExplanation(int percent, int amount, int answer) =>
    switch (percent) {
      50 => '50% is half: $amount ${MathText.divide} 2 = $answer.',
      10 => '10% is a tenth: $amount ${MathText.divide} 10 = $answer.',
      25 => '25% is a quarter: $amount ${MathText.divide} 4 = $answer.',
      _ =>
        '$percent% of ${_n(amount)} = ${_n(amount)} $_x $percent '
            '${MathText.divide} 100 = ${_n(answer)}.',
    };

Question _percentOf(
  QuestionContext c,
  List<int> percents,
  int min,
  int max,
  int step,
) {
  final percent = c.pick(percents);
  final amount = c.between(min ~/ step, max ~/ step) * step;
  final answer = amount * percent ~/ 100;
  return c.question(
    prompt: '$percent% of ${_n(amount)} = ?',
    answer: _n(answer),
    mistakes: [
      if (amount * percent % 10 == 0) _n(amount * percent ~/ 10),
      if (amount - answer >= 0) _n(amount - answer),
      if (amount > percent) _n(amount - percent),
      _n(answer + 5),
      if (answer >= 5) _n(answer - 5),
    ],
    alternative: c.nearbyIntegers(answer, step: math.max(1, step ~/ 4)),
    hint: switch (percent) {
      50 => '50% means half.',
      10 => '10% means divide by 10.',
      25 => '25% means a quarter: divide by 4.',
      _ => 'Find 10% first by dividing by 10, then build up to $percent%.',
    },
    explanation: _percentExplanation(percent, amount, answer),
  );
}

Question _whatPercent(QuestionContext c) {
  final whole = c.pick(
    c.level == 7 ? const [10, 20, 25, 50] : const [40, 80, 200, 250, 400, 500],
  );
  final percents = [
    for (var p = 5; p < 100; p += 5)
      if (whole * p % 100 == 0) p,
  ];
  final percent = c.pick(percents);
  final part = whole * percent ~/ 100;
  return c.question(
    prompt: 'What percentage of $whole is $part?',
    answer: MathText.percent(percent),
    mistakes: [
      MathText.percent(part),
      MathText.percent(100 - percent),
      MathText.percent(percent + 10),
      if (percent > 10) MathText.percent(percent - 10),
    ],
    alternative: c.nearbyIntegers(
      percent,
      step: 5,
      min: 1,
      format: MathText.percent,
    ),
    hint: 'Write $part out of $whole as a fraction with 100 on the bottom.',
    explanation:
        '$part out of $whole is $part/$whole = $percent/100, which is '
        '$percent%.',
  );
}

Question _percentChange(QuestionContext c, {required bool increase}) {
  final percent = c.between(1, 9) * 5;
  final amount = c.between(1, 20) * 20;
  final change = amount * percent ~/ 100;
  final answer = increase ? amount + change : amount - change;
  String money(int dollars) => MathText.money(dollars * 100, allowWhole: true);
  return c.question(
    prompt: increase
        ? 'Increase ${_n(amount)} by $percent%.'
        : 'A ${money(amount)} game is $percent% off. What does it cost now?',
    answer: increase ? _n(answer) : money(answer),
    mistakes: [
      if (increase) _n(change) else money(change),
      if (increase) _n(amount + percent) else money(amount - percent),
      if (increase) _n(amount - change) else money(amount + change),
      if (increase) _n(answer + 10) else money(answer + 10),
    ],
    alternative: c.nearbyIntegers(
      answer,
      step: 2,
      min: 1,
      format: increase ? _n : money,
    ),
    hint:
        'Work out $percent% of ${_n(amount)} first, then '
        '${increase ? 'add it on' : 'take it away'}.',
    explanation:
        '$percent% of ${_n(amount)} is ${_n(change)}. '
        '${_n(amount)} ${increase ? '+' : _minus} ${_n(change)} = '
        '${_n(answer)}.',
  );
}

// ---------------------------------------------------------------------------
// Integers (negative numbers)

Question _integers(QuestionContext c) => switch (c.level) {
  1 => _signedSum(c, 5, subtract: false),
  2 => _signedSum(c, 10, subtract: false),
  3 => _signedSum(c, 10, subtract: true),
  4 => _signedSum(c, 20, subtract: true),
  5 => _signedProduct(c, 6),
  6 => _signedProduct(c, 12),
  7 => _signedQuotient(c),
  _ => _signedExpression(c),
};

List<String> _signMistakes(int answer, int naive) => [
  _n(-answer),
  _n(naive),
  _n(answer + 1),
  _n(answer - 1),
  _n(answer + 2),
];

Question _signedSum(QuestionContext c, int range, {required bool subtract}) {
  var a = c.nonZero(range);
  var b = c.nonZero(range);
  // Make sure negatives are involved.
  if (a > 0 && b > 0) {
    if (c.chance(0.5)) {
      a = -a;
    } else {
      b = -b;
    }
  }
  final answer = subtract ? a - b : a + b;
  final op = subtract ? _minus : '+';
  final String explanation;
  if (!subtract && b < 0) {
    explanation =
        'Adding a negative is the same as subtracting: ${_n(a)} + ${_t(b)} '
        '= ${_n(a)} $_minus ${_n(-b)} = ${_n(answer)}.';
  } else if (subtract && b < 0) {
    explanation =
        'Subtracting a negative is the same as adding: ${_n(a)} $_minus '
        '${_t(b)} = ${_n(a)} + ${_n(-b)} = ${_n(answer)}.';
  } else {
    explanation =
        'Start at ${_n(a)} on the number line and move ${_n(b.abs())} '
        'step${b.abs() == 1 ? '' : 's'} to the ${subtract ? 'left' : 'right'}: '
        '${_n(answer)}.';
  }
  return c.question(
    prompt: '${_n(a)} $op ${_t(b)} = ?',
    answer: _n(answer),
    mistakes: _signMistakes(answer, subtract ? a + b : a - b),
    alternative: c.nearbyIntegers(answer, min: null),
    hint: subtract && b < 0
        ? 'Subtracting a negative number is the same as adding.'
        : 'Picture a number line: adding moves right, subtracting moves '
              'left.',
    explanation: explanation,
  );
}

String _signRule(int a, int b, int answer, String op) =>
    '${(a < 0) == (b < 0) ? 'Same signs give a positive answer' : 'Different signs give a negative answer'}. '
    '${_n(a.abs())} $op ${_n(b.abs())} = ${_n(answer.abs())}, so the answer '
    'is ${_n(answer)}.';

Question _signedProduct(QuestionContext c, int range) {
  var a = c.nonZero(range);
  final b = c.nonZero(range);
  if (a > 0 && b > 0) a = -a;
  final answer = a * b;
  return c.question(
    prompt: '${_n(a)} $_x ${_t(b)} = ?',
    answer: _n(answer),
    mistakes: _signMistakes(answer, a + b),
    alternative: c.nearbyIntegers(answer, min: null),
    hint:
        'Multiply the numbers, then decide the sign: same signs give a '
        'positive answer.',
    explanation: _signRule(a, b, answer, _x),
  );
}

Question _signedQuotient(QuestionContext c) {
  var quotient = c.nonZero(12);
  final divisor = c.nonZero(12);
  if (quotient > 0 && divisor > 0) quotient = -quotient;
  final dividend = quotient * divisor;
  return c.question(
    prompt: '${_n(dividend)} ${MathText.divide} ${_t(divisor)} = ?',
    answer: _n(quotient),
    mistakes: _signMistakes(quotient, dividend + divisor),
    alternative: c.nearbyIntegers(quotient, min: null),
    hint:
        'Divide the numbers, then decide the sign: same signs give a '
        'positive answer.',
    explanation: _signRule(dividend, divisor, quotient, MathText.divide),
  );
}

Question _signedExpression(QuestionContext c) {
  final a = c.nonZero(c.level == 8 ? 20 : 10);
  final b = c.nonZero(c.level == 8 ? 20 : 10);
  final k = c.nonZero(c.level == 10 ? 9 : 10);
  final (
    String prompt,
    int answer,
    int naive,
    String explanation,
  ) = switch (c.level) {
    8 => (
      '${_n(a)} + ${_t(b)} $_minus ${_t(k)} = ?',
      a + b - k,
      a + b + k,
      'Work left to right: ${_n(a)} + ${_t(b)} = ${_n(a + b)}, then '
          '${_n(a + b)} $_minus ${_t(k)} = ${_n(a + b - k)}.',
    ),
    9 => (
      '${_n(a)} $_x ${_t(b)} + ${_t(k)} = ?',
      a * b + k,
      a * (b + k),
      'Multiply first: ${_n(a)} $_x ${_t(b)} = ${_n(a * b)}, then '
          '${_n(a * b)} + ${_t(k)} = ${_n(a * b + k)}.',
    ),
    _ => (
      '(${_n(a)} $_minus ${_t(b)}) $_x ${_t(k)} = ?',
      (a - b) * k,
      (a + b) * k,
      'Brackets first: ${_n(a)} $_minus ${_t(b)} = ${_n(a - b)}, then '
          '${_n(a - b)} $_x ${_t(k)} = ${_n((a - b) * k)}.',
    ),
  };
  return c.question(
    prompt: prompt,
    answer: _n(answer),
    mistakes: _signMistakes(answer, naive),
    alternative: c.nearbyIntegers(answer, min: null),
    hint: 'Brackets first, then multiply or divide, then add and subtract.',
    explanation: explanation,
  );
}

// ---------------------------------------------------------------------------
// Squares, square roots and cube roots

Question _squareRoots(QuestionContext c) => switch (c.level) {
  1 => _square(c, 2, 5),
  2 => _root(c, 2, 5),
  3 => _root(c, 2, 10),
  4 => _square(c, 1, 12),
  5 => _root(c, 1, 12),
  6 => c.chance(0.5) ? _square(c, 11, 15) : _root(c, 6, 15),
  7 => _root(c, 11, 20),
  8 => c.chance(0.5) ? _cubeRoot(c, 2, 5) : _root(c, 15, 25),
  9 => _cubeRoot(c, 2, 10),
  _ => _root(c, 26, 99),
};

Question _square(QuestionContext c, int min, int max) {
  final n = c.between(min, max);
  return c.question(
    prompt: '${MathText.power(n, 2)} = ?',
    answer: _n(n * n),
    mistakes: [
      _n(2 * n),
      _n(n + 2),
      _n((n + 1) * (n + 1)),
      if (n > 1) _n((n - 1) * (n - 1)),
    ],
    alternative: c.nearbyIntegers(n * n, min: 1),
    hint: '${MathText.power(n, 2)} means $n $_x $n.',
    explanation:
        '${MathText.power(n, 2)} means $n multiplied by itself: $n $_x $n = '
        '${_n(n * n)}.',
  );
}

Question _root(QuestionContext c, int min, int max) {
  final root = c.between(min, max);
  final square = root * root;
  return c.question(
    prompt: '√${_n(square)} = ?',
    answer: _n(root),
    mistakes: [
      if (square.isEven && square > 2) _n(square ~/ 2),
      _n(root + 1),
      if (root > 1) _n(root - 1),
      _n(root * 2),
    ],
    alternative: c.nearbyIntegers(root, min: 1),
    hint: root <= 12
        ? 'Which number multiplied by itself gives ${_n(square)}?'
        : 'Find the two square numbers either side of ${_n(square)} to '
              'narrow it down.',
    explanation:
        '√${_n(square)} asks which number times itself makes ${_n(square)}: '
        '$root $_x $root = ${_n(square)}, so √${_n(square)} = $root.',
  );
}

Question _cubeRoot(QuestionContext c, int min, int max) {
  final root = c.between(min, max);
  final cube = root * root * root;
  return c.question(
    prompt: '${MathText.cubeRoot}${_n(cube)} = ?',
    answer: _n(root),
    mistakes: [
      if (cube % 3 == 0 && cube > 3) _n(cube ~/ 3),
      _n(root + 1),
      if (root > 1) _n(root - 1),
      _n(root * root),
    ],
    alternative: c.nearbyIntegers(root, min: 1),
    hint:
        'Which number multiplied by itself three times gives '
        '${_n(cube)}?',
    explanation:
        '$root $_x $root $_x $root = ${_n(cube)}, so ${MathText.cubeRoot}${_n(cube)} = $root.',
  );
}

// ---------------------------------------------------------------------------
// Exponents

Question _exponents(QuestionContext c) => switch (c.level) {
  1 => _powerValue(c, [for (var b = 2; b <= 10; b++) (b, 2)]),
  2 => _powerValue(c, [for (var b = 2; b <= 5; b++) (b, 3)]),
  3 => _powerValue(c, [
    for (var e = 1; e <= 6; e++) (2, e),
    for (var e = 1; e <= 4; e++) (10, e),
  ]),
  4 => _powerValue(c, [
    for (var e = 2; e <= 4; e++) (3, e),
    for (var e = 2; e <= 3; e++) ...[(4, e), (5, e)],
  ]),
  5 => _powerValue(c, [
    for (var e = 5; e <= 10; e++) (2, e),
    for (var e = 3; e <= 5; e++) (3, e),
  ]),
  6 || 7 || 8 => _exponentLaw(c),
  9 => _zeroAndNegativeExponent(c),
  _ => _scientificNotation(c),
};

Question _powerValue(QuestionContext c, List<(int, int)> options) {
  final (base, exponent) = c.pick(options);
  final value = _pow(base, exponent);
  final copies = List.filled(exponent, '$base').join(' $_x ');
  return c.question(
    prompt: '${MathText.power(base, exponent)} = ?',
    answer: _n(value),
    mistakes: [
      _n(base * exponent),
      _n(base + exponent),
      if (exponent > 1) _n(_pow(base, exponent - 1)),
      _n(_pow(base, exponent + 1)),
    ],
    alternative: c.nearbyIntegers(value, min: 0),
    hint: 'Multiply $exponent copies of $base together.',
    explanation: exponent == 1
        ? 'Any number to the power 1 is itself: $base.'
        : '${MathText.power(base, exponent)} means $copies = ${_n(value)}.',
  );
}

Question _exponentLaw(QuestionContext c) {
  final base = c.between(2, 9);
  // For division keep m > n, so the answer is never a zero power.
  final m = c.between(3, 9);
  final n = c.level == 7 ? c.between(2, m - 1) : c.between(2, 6);
  String p(int e) => MathText.power(base, e);
  final (
    String prompt,
    int answer,
    List<int> wrong,
    String rule,
  ) = switch (c.level) {
    6 => (
      '${p(m)} $_x ${p(n)} = ?',
      m + n,
      [m * n, (m - n).abs()],
      'When multiplying powers of the same base, add the exponents: '
          '$m + $n = ${m + n}',
    ),
    7 => (
      '${p(m)} ${MathText.divide} ${p(n)} = ?',
      m - n,
      [m + n, if (m % n == 0) m ~/ n],
      'When dividing powers of the same base, subtract the exponents: '
          '$m $_minus $n = ${m - n}',
    ),
    _ => (
      '(${p(m)})${MathText.raised(n)} = ?',
      m * n,
      [m + n, m * n - 1],
      'A power of a power multiplies the exponents: $m $_x $n = ${m * n}',
    ),
  };
  return c.question(
    prompt: prompt,
    answer: p(answer),
    mistakes: [
      for (final e in wrong)
        if (e != answer) p(e),
      MathText.power(base * 2, answer),
      p(answer + 1),
    ],
    alternative: (attempt) => p(answer + attempt + 1),
    hint: 'The base stays the same; only the exponent changes.',
    explanation: '$rule, so the answer is ${p(answer)}.',
  );
}

Question _zeroAndNegativeExponent(QuestionContext c) {
  final kind = c.between(0, 2);
  if (kind == 0) {
    final base = c.between(2, 12);
    return c.question(
      prompt: '${MathText.power(base, 0)} = ?',
      answer: '1',
      mistakes: ['0', _n(base), Fraction(1, base).toString()],
      alternative: c.nearbyIntegers(1, min: 2),
      hint:
          'Think of ${MathText.power(base, 2)} ${MathText.divide} '
          '${MathText.power(base, 2)}.',
      explanation:
          'Any non-zero number to the power 0 is 1, because '
          '${MathText.power(base, 2)} ${MathText.divide} '
          '${MathText.power(base, 2)} = ${MathText.power(base, 0)} = 1.',
    );
  }
  final base = kind == 1 ? 10 : 2;
  final e = c.between(1, kind == 1 ? 4 : 5);
  final value = _pow(base, e);
  final answer = kind == 1 ? _d(1, e) : Fraction(1, value).toString();
  return c.question(
    prompt: '${MathText.power(base, -e)} = ?',
    answer: answer,
    mistakes: [
      _n(-value),
      _n(-base * e),
      if (kind == 1) _d(1, e + 1) else Fraction(1, base * e + 1).toString(),
      if (kind == 1) _n(value) else Fraction(1, value * 2).toString(),
    ],
    alternative: (attempt) => kind == 1
        ? _d(1, e + attempt + 1)
        : Fraction(1, value * _pow(2, attempt + 1)).toString(),
    hint: 'A negative exponent means "one over" the positive power.',
    explanation:
        '${MathText.power(base, -e)} = 1/${MathText.power(base, e)} = '
        '1/${_n(value)}${kind == 1 ? ' = $answer' : ''}.',
  );
}

Question _scientificNotation(QuestionContext c) {
  final mantissa = c.between(11, 99);
  final e = c.between(2, 5);
  final value = mantissa * _pow(10, e - 1);
  return c.question(
    prompt: '${_d(mantissa, 1)} $_x ${MathText.power(10, e)} = ?',
    answer: _n(value),
    mistakes: [
      _n(value * 10),
      _n(value ~/ 10),
      _n(mantissa * e),
      if (e > 2) _n(value ~/ 100),
    ],
    alternative: (attempt) => _n(value * _pow(10, attempt + 1)),
    hint:
        'Multiplying by ${MathText.power(10, e)} moves the digits $e '
        'places to the left.',
    explanation:
        '${MathText.power(10, e)} = ${_n(_pow(10, e))}. Moving the digits of '
        '${_d(mantissa, 1)} $e places to the left gives ${_n(value)}.',
  );
}
