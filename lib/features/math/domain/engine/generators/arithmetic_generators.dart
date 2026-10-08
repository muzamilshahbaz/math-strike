import '../../entities/math_topic.dart';
import '../../entities/question.dart';
import '../math_text.dart';
import '../question_context.dart';

/// Generators for the four basic operations.
const Map<MathTopic, TopicGenerator> arithmeticGenerators = {
  MathTopic.addition: _addition,
  MathTopic.subtraction: _subtraction,
  MathTopic.multiplication: _multiplication,
  MathTopic.division: _division,
};

const String _x = MathText.times;
String _n(int value) => MathText.integer(value);

/// Largest operand for addition and subtraction, by level.
const List<int> _sumRange = [5, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000];

/// Digit-by-digit sum that forgets to carry: 27 + 15 → 32.
int _addWithoutCarry(int a, int b) {
  var result = 0;
  for (var place = 1; a > 0 || b > 0; place *= 10) {
    result += ((a % 10 + b % 10) % 10) * place;
    a ~/= 10;
    b ~/= 10;
  }
  return result;
}

/// Digit-by-digit difference that subtracts the smaller digit from the
/// larger instead of borrowing: 42 − 17 → 35.
int _subtractWithoutBorrow(int a, int b) {
  var result = 0;
  for (var place = 1; a > 0 || b > 0; place *= 10) {
    result += (a % 10 - b % 10).abs() * place;
    a ~/= 10;
    b ~/= 10;
  }
  return result;
}

Question _addition(QuestionContext c) {
  final max = c.scale(_sumRange);
  final a = c.between(c.level == 1 ? 0 : 1, max);
  final b = c.between(1, max);
  final sum = a + b;
  final (big, small) = a >= b ? (a, b) : (b, a);

  final String hint;
  final String explanation;
  if (sum <= 20) {
    hint = 'Start at $big and count on $small more.';
    explanation = 'Start at $big and count on $small: $a + $b = $sum.';
  } else if (a >= 10 && b >= 10 && a < 100 && b < 100) {
    final tens = a ~/ 10 * 10 + b ~/ 10 * 10;
    final ones = a % 10 + b % 10;
    hint = 'Add the tens, then add the ones.';
    explanation =
        'Tens: ${a ~/ 10 * 10} + ${b ~/ 10 * 10} = $tens. '
        'Ones: ${a % 10} + ${b % 10} = $ones. '
        'Together: $tens + $ones = $sum.';
  } else {
    hint = 'Line up the place values and add from the right.';
    explanation =
        'Add each column from the right, carrying when a column reaches '
        '10: ${_n(a)} + ${_n(b)} = ${_n(sum)}.';
  }

  return c.question(
    prompt: '${_n(a)} + ${_n(b)} = ?',
    answer: _n(sum),
    mistakes: [
      _n(_addWithoutCarry(a, b)),
      _n(sum + 1),
      if (sum > 1) _n(sum - 1),
      if (sum >= 20) ...[_n(sum + 10), _n(sum - 10)],
      if (big != small) _n(big - small),
    ],
    alternative: c.nearbyIntegers(sum),
    hint: hint,
    explanation: explanation,
  );
}

Question _subtraction(QuestionContext c) {
  final max = c.scale(_sumRange);
  final a = c.between(c.level == 1 ? 1 : 2, max);
  final b = c.between(c.level == 1 ? 0 : 1, a);
  final difference = a - b;

  return c.question(
    prompt: '${_n(a)} ${MathText.minus} ${_n(b)} = ?',
    answer: _n(difference),
    mistakes: [
      _n(_subtractWithoutBorrow(a, b)),
      _n(difference + 1),
      if (difference > 0) _n(difference - 1),
      if (a >= 20) ...[
        _n(difference + 10),
        if (difference >= 10) _n(difference - 10),
      ],
      _n(a + b),
    ],
    alternative: c.nearbyIntegers(difference),
    hint: a <= 20
        ? 'Count back $b from $a, or count up from $b to $a.'
        : 'Subtract the ones, then the tens. Borrow when the top digit is '
              'smaller.',
    explanation: a <= 20
        ? 'Count up from $b to $a: that is $difference steps, so '
              '$a ${MathText.minus} $b = $difference.'
        : '${_n(a)} ${MathText.minus} ${_n(b)} = ${_n(difference)}. '
              'Check by adding back: ${_n(difference)} + ${_n(b)} = '
              '${_n(a)}.',
  );
}

/// Factor ranges for multiplication and division, by level:
/// (smallest a, largest a, smallest b, largest b, special table for a).
const List<(int, int, int, int, List<int>?)> _factorRanges = [
  (1, 10, 1, 5, [1, 2, 5, 10]),
  (2, 10, 1, 10, [2, 3, 4, 5, 10]),
  (2, 10, 2, 10, null),
  (2, 12, 2, 12, null),
  (11, 20, 2, 9, null),
  (21, 50, 2, 9, null),
  (11, 20, 11, 20, null),
  (21, 99, 3, 12, null),
  (21, 99, 13, 25, null),
  (21, 99, 21, 99, null),
];

(int, int) _factors(QuestionContext c) {
  final (aMin, aMax, bMin, bMax, table) = c.scale(_factorRanges);
  final a = table == null ? c.between(aMin, aMax) : c.pick(table);
  return (a, c.between(bMin, bMax));
}

/// "23 × 4 = 20 × 4 + 3 × 4 = 80 + 12 = 92", splitting [a] into tens and
/// ones (or [b] when both are two-digit).
String _splitProduct(int a, int b) {
  final product = a * b;
  if (b >= 10) {
    final tens = b ~/ 10 * 10;
    final ones = b % 10;
    if (ones == 0) return '${_n(a)} $_x $b = ${_n(product)}.';
    return '${_n(a)} $_x $b = ${_n(a)} $_x $tens + ${_n(a)} $_x $ones = '
        '${_n(a * tens)} + ${_n(a * ones)} = ${_n(product)}.';
  }
  final tens = a ~/ 10 * 10;
  final ones = a % 10;
  if (ones == 0) return '${_n(a)} $_x $b = ${_n(product)}.';
  return '${_n(a)} $_x $b = $tens $_x $b + $ones $_x $b = '
      '${_n(tens * b)} + ${_n(ones * b)} = ${_n(product)}.';
}

Question _multiplication(QuestionContext c) {
  var (a, b) = _factors(c);
  // Times tables work both ways round.
  if (c.level <= 4 && c.chance(0.5)) (a, b) = (b, a);
  final product = a * b;
  final big = a >= 10 || b >= 10;

  return c.question(
    prompt: '${_n(a)} $_x ${_n(b)} = ?',
    answer: _n(product),
    mistakes: [
      _n(a * (b + 1)),
      if (b > 1) _n(a * (b - 1)),
      _n((a + 1) * b),
      _n(a + b),
      if (product >= 20) ...[_n(product + 10), _n(product - 10)],
    ],
    alternative: c.nearbyIntegers(product, step: c.level <= 4 ? 1 : 2),
    hint: c.level <= 4
        ? 'Think of the ${a <= b ? b : a} times table, or count in '
              '${a <= b ? a : b}s.'
        : 'Split the bigger number into tens and ones, multiply each part, '
              'then add.',
    explanation: c.level <= 4 || !big
        ? '$a $_x $b means $a group${a == 1 ? '' : 's'} of $b: '
              '$a $_x $b = $product.'
        : _splitProduct(a, b),
  );
}

Question _division(QuestionContext c) {
  final (quotient, divisor) = _factors(c);
  final dividend = quotient * divisor;

  return c.question(
    prompt: '${_n(dividend)} ${MathText.divide} ${_n(divisor)} = ?',
    answer: _n(quotient),
    mistakes: [
      _n(quotient + 1),
      if (quotient > 1) _n(quotient - 1),
      if (divisor != quotient) _n(divisor),
      if (dividend - divisor > 0) _n(dividend - divisor),
      _n(quotient * 2),
    ],
    alternative: c.nearbyIntegers(quotient, min: 1),
    hint:
        'How many groups of ${_n(divisor)} make ${_n(dividend)}? '
        'Use the ${_n(divisor)} times table.',
    explanation:
        '${_n(dividend)} ${MathText.divide} ${_n(divisor)} = '
        '${_n(quotient)}, because ${_n(divisor)} $_x ${_n(quotient)} = '
        '${_n(dividend)}.',
  );
}
