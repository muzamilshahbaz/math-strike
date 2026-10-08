import 'dart:math' as math;

import '../../entities/math_topic.dart';
import '../../entities/question.dart';
import '../math_text.dart';
import '../question_context.dart';

/// Generators for algebra, geometry, time, money and measurement.
const Map<MathTopic, TopicGenerator> appliedGenerators = {
  MathTopic.algebra: _algebra,
  MathTopic.geometry: _geometry,
  MathTopic.time: _time,
  MathTopic.money: _money,
  MathTopic.measurement: _measurement,
};

const String _x = MathText.times;
const String _minus = MathText.minus;
String _n(int value) => MathText.integer(value);

// ---------------------------------------------------------------------------
// Algebra

/// `ax + b`, written naturally: `3x − 4`, `x + 2`, `5x`.
String _linear(int a, int b) {
  final ax = a == 1 ? 'x' : '${a}x';
  if (b == 0) return ax;
  return b > 0 ? '$ax + ${_n(b)}' : '$ax $_minus ${_n(-b)}';
}

Question _algebra(QuestionContext c) {
  final negative = c.level >= 9 && c.chance(0.4);
  final x = negative
      ? -c.between(1, 10)
      : c.between(c.level == 1 ? 0 : 1, c.scale([10, 20, 10, 10, 10, 12]));
  final form = c.level >= 9 ? c.between(5, c.level == 10 ? 9 : 8) : c.level;

  final String equation;
  final List<int> wrong;
  final String steps;
  switch (form) {
    case 1:
      final a = c.between(1, 10);
      equation = 'x + $a = ${_n(x + a)}';
      wrong = [x + 2 * a, x + a];
      steps =
          'Subtract $a from both sides: x = ${_n(x + a)} $_minus $a = '
          '${_n(x)}.';
    case 2:
      final a = c.between(1, x); // Keeps x − a ≥ 0 for young players.
      if (c.chance(0.5)) {
        equation = 'x $_minus $a = ${_n(x - a)}';
        wrong = [x - 2 * a, x - a];
        steps = 'Add $a to both sides: x = ${_n(x - a)} + $a = ${_n(x)}.';
      } else {
        equation = '$a + x = ${_n(x + a)}';
        wrong = [x + 2 * a, x + a];
        steps =
            'Subtract $a from both sides: x = ${_n(x + a)} $_minus $a = '
            '${_n(x)}.';
      }
    case 3:
      final a = c.between(2, 10);
      equation = '${a}x = ${_n(a * x)}';
      wrong = [a * x - a, a * x + a];
      steps =
          'Divide both sides by $a: x = ${_n(a * x)} '
          '${MathText.divide} $a = ${_n(x)}.';
    case 4:
      final a = c.between(2, 10);
      final result = c.between(1, 10);
      return _solve(
        c,
        x: a * result,
        equation: 'x ${MathText.divide} $a = $result',
        wrong: [result, result + a, a],
        steps: 'Multiply both sides by $a: x = $result $_x $a = ${a * result}.',
      );
    case 5:
      final a = c.between(2, 5);
      final b = c.between(1, 12);
      final rhs = a * x + b;
      equation = '${_linear(a, b)} = ${_n(rhs)}';
      wrong = [rhs - b, if ((rhs + b) % a == 0) (rhs + b) ~/ a, rhs ~/ a];
      steps =
          'Subtract $b from both sides: ${a}x = ${_n(rhs - b)}. '
          'Divide by $a: x = ${_n(x)}.';
    case 6:
      final a = c.between(2, 9);
      final b = c.between(1, 15);
      final rhs = a * x - b;
      equation = '${_linear(a, -b)} = ${_n(rhs)}';
      wrong = [rhs + b, if ((rhs - b) % a == 0) (rhs - b) ~/ a];
      steps =
          'Add $b to both sides: ${a}x = ${_n(rhs + b)}. '
          'Divide by $a: x = ${_n(x)}.';
    case 7:
      final a = c.between(2, 6);
      final b = c.between(1, 9);
      final rhs = a * (x + b);
      equation = '$a(x + $b) = ${_n(rhs)}';
      wrong = [rhs ~/ a, rhs ~/ a + b, rhs - b];
      steps =
          'Divide both sides by $a: x + $b = ${_n(rhs ~/ a)}. '
          'Subtract $b: x = ${_n(x)}.';
    case 8:
      final right = c.between(1, 4);
      final left = right + c.between(1, 4);
      final b = c.between(1, 10);
      final d = (left - right) * x + b;
      equation = '${_linear(left, b)} = ${_linear(right, d)}';
      final k = left - right;
      wrong = [
        if ((d + b) % k == 0) (d + b) ~/ k,
        if ((d - b) % (left + right) == 0) (d - b) ~/ (left + right),
        d - b,
      ];
      steps =
          'Subtract ${right == 1 ? '' : right}x from both sides: '
          '${_linear(k, b)} = ${_n(d)}. Subtract $b: ${k == 1 ? '' : k}x = '
          '${_n(d - b)}.${k == 1 ? '' : ' Divide by $k: x = ${_n(x)}.'}';
    default:
      final a = c.between(2, 6);
      final q = negative ? x : c.between(1, 10);
      final b = c.between(1, 10);
      return _solve(
        c,
        x: a * q,
        equation: 'x/$a + $b = ${_n(q + b)}',
        wrong: [q, q + b, (q + b) * a],
        steps:
            'Subtract $b from both sides: x/$a = ${_n(q)}. Multiply by '
            '$a: x = ${_n(a * q)}.',
      );
  }
  return _solve(c, x: x, equation: equation, wrong: wrong, steps: steps);
}

Question _solve(
  QuestionContext c, {
  required int x,
  required String equation,
  required List<int> wrong,
  required String steps,
}) => c.question(
  prompt: '$equation\nx = ?',
  answer: _n(x),
  mistakes: [
    for (final w in wrong)
      if (w != x) _n(w),
    if (x != 0) _n(-x),
    _n(x + 1),
  ],
  alternative: c.nearbyIntegers(x, min: null),
  hint: 'Undo each operation on x, doing the same to both sides.',
  explanation: steps,
);

// ---------------------------------------------------------------------------
// Geometry

const List<(String, int)> _shapes = [
  ('triangle', 3),
  ('square', 4),
  ('rectangle', 4),
  ('pentagon', 5),
  ('hexagon', 6),
  ('heptagon', 7),
  ('octagon', 8),
];

Question _geometry(QuestionContext c) => switch (c.level) {
  1 || 2 => _shapeSides(c),
  3 || 4 => _perimeter(c),
  5 || 6 => _area(c),
  7 => _triangleArea(c),
  8 => _missingAngle(c),
  9 => _angleFacts(c),
  _ => c.chance(0.5) ? _circle(c) : _pythagoras(c),
};

Question _shapeSides(QuestionContext c) {
  final shapes = c.level == 1 ? _shapes.sublist(0, 5) : _shapes;
  final (name, sides) = c.pick(shapes);
  if (c.level == 2 &&
      c.chance(0.5) &&
      name != 'rectangle' &&
      name != 'square') {
    return c.question(
      prompt: 'Which shape has $sides sides?',
      answer: name,
      mistakes: [
        for (final (other, n) in _shapes)
          if (n != sides) other,
      ],
      hint: 'Penta- means 5, hexa- means 6, hepta- 7 and octa- 8.',
      explanation: 'A $name has $sides straight sides and $sides corners.',
    );
  }
  final corners = c.level == 2 && c.chance(0.5);
  return c.question(
    prompt: 'How many ${corners ? 'corners' : 'sides'} does a $name have?',
    answer: '$sides',
    mistakes: [for (final (_, n) in shapes) '$n'],
    alternative: c.nearbyIntegers(sides, min: 3),
    hint:
        'Count the straight edges${corners ? ' — a shape has as many '
                  'corners as sides' : ''}.',
    explanation: 'A $name has $sides sides and $sides corners.',
  );
}

Question _perimeter(QuestionContext c) {
  final square = c.level == 3;
  final w = c.between(2, square ? 10 : 15);
  final l = square ? w : c.between(2, 15);
  final perimeter = 2 * (w + l);
  String cm(int v) => '$v cm';
  return c.question(
    prompt: square
        ? 'A square has sides of $w cm. What is its perimeter?'
        : 'A rectangle is $l cm long and $w cm wide. What is its perimeter?',
    answer: cm(perimeter),
    mistakes: [
      cm(w * l),
      cm(w + l),
      if (!square) cm(2 * l + w),
      cm(perimeter + 2),
    ],
    alternative: c.nearbyIntegers(perimeter, step: 2, min: 4, format: cm),
    hint: 'The perimeter is the distance all the way around the edge.',
    explanation: square
        ? 'A square has 4 equal sides: 4 $_x $w = $perimeter cm.'
        : 'Add all four sides: $l + $w + $l + $w = $perimeter cm.',
  );
}

Question _area(QuestionContext c) {
  final w = c.between(2, 12);
  final l = c.between(2, 12);
  final area = w * l;
  String cm(int v) => '$v cm';
  String cm2(int v) => '$v cm²';
  if (c.level == 6 && c.chance(0.5)) {
    return c.question(
      prompt:
          'A rectangle has an area of $area cm² and is $w cm wide. '
          'How long is it?',
      answer: cm(l),
      mistakes: [cm(area - w), cm(l + 1), if (l > 1) cm(l - 1), cm(area ~/ 2)],
      alternative: c.nearbyIntegers(l, min: 1, format: cm),
      hint:
          'Area = length $_x width, so length = area ${MathText.divide} '
          'width.',
      explanation: 'Length = $area ${MathText.divide} $w = $l cm.',
    );
  }
  return c.question(
    prompt: 'A rectangle is $l cm long and $w cm wide. What is its area?',
    answer: cm2(area),
    mistakes: [cm2(2 * (w + l)), cm2(w + l), cm2(area + w), cm2(area - l)],
    alternative: c.nearbyIntegers(area, min: 1, format: cm2),
    hint: 'Area is length times width.',
    explanation: 'Area = length $_x width = $l $_x $w = $area cm².',
  );
}

Question _triangleArea(QuestionContext c) {
  var base = c.between(2, 20);
  final height = c.between(2, 12);
  if ((base * height).isOdd) base++;
  final area = base * height ~/ 2;
  String cm2(int v) => '$v cm²';
  return c.question(
    prompt:
        'A triangle has a base of $base cm and a height of $height cm. '
        'What is its area?',
    answer: cm2(area),
    mistakes: [cm2(base * height), cm2(base + height), cm2(area + height)],
    alternative: c.nearbyIntegers(area, min: 1, format: cm2),
    hint: 'A triangle is half of a rectangle.',
    explanation:
        'Area = base $_x height ${MathText.divide} 2 = $base $_x $height '
        '${MathText.divide} 2 = $area cm².',
  );
}

Question _missingAngle(QuestionContext c) {
  final a = c.between(4, 20) * 5;
  final b = c.between(2, (170 - a) ~/ 5) * 5;
  final missing = 180 - a - b;
  String deg(int v) => '$v°';
  return c.question(
    prompt:
        'Two angles of a triangle are $a° and $b°. What is the third '
        'angle?',
    answer: deg(missing),
    mistakes: [
      deg(360 - a - b),
      if (90 - a - b > 0) deg(90 - a - b),
      deg(a + b),
      deg(missing + 10),
    ],
    alternative: c.nearbyIntegers(missing, step: 5, min: 5, format: deg),
    hint: 'The angles in a triangle add up to 180°.',
    explanation: '180° $_minus $a° $_minus $b° = $missing°.',
  );
}

Question _angleFacts(QuestionContext c) {
  String deg(int v) => '$v°';
  switch (c.between(0, 2)) {
    case 0:
      final a = c.between(2, 34) * 5;
      return c.question(
        prompt:
            'Two angles make a straight line. One is $a°. What is the '
            'other?',
        answer: deg(180 - a),
        mistakes: [deg(360 - a), if (a < 90) deg(90 - a), deg(180 - a + 10)],
        alternative: c.nearbyIntegers(180 - a, step: 5, min: 5, format: deg),
        hint: 'Angles on a straight line add up to 180°.',
        explanation: '180° $_minus $a° = ${180 - a}°.',
      );
    case 1:
      final a = c.between(10, 30) * 5;
      final b = c.between(10, (340 - a) ~/ 5) * 5;
      final rest = 360 - a - b;
      return c.question(
        prompt:
            'Three angles meet at a point. Two are $a° and $b°. What is '
            'the third?',
        answer: deg(rest),
        mistakes: [
          if (180 - a - b > 0) deg(180 - a - b),
          deg(a + b),
          deg(rest + 10),
        ],
        alternative: c.nearbyIntegers(rest, step: 5, min: 5, format: deg),
        hint: 'Angles around a point add up to 360°.',
        explanation: '360° $_minus $a° $_minus $b° = $rest°.',
      );
    default:
      final (name, sides) = c.pick(_shapes.sublist(3));
      final total = (sides - 2) * 180;
      return c.question(
        prompt: 'What do the interior angles of a $name add up to?',
        answer: deg(total),
        mistakes: [
          deg(sides * 180),
          deg(360),
          deg((sides - 1) * 180),
          deg(sides * 90),
        ],
        alternative: c.nearbyIntegers(total, step: 180, min: 180, format: deg),
        hint: 'Split the shape into triangles from one corner.',
        explanation:
            'A $name can be split into ${sides - 2} triangles, each with '
            '180°: ${sides - 2} $_x 180° = $total°.',
      );
  }
}

Question _circle(QuestionContext c) {
  final r = c.between(1, 10);
  final areaAsked = c.chance(0.5);
  // π ≈ 3.14, so values in hundredths are exact integers.
  final area = 314 * r * r;
  final circumference = 628 * r;
  String unit(int hundredths, String suffix) =>
      '${MathText.decimal(hundredths, 2)} $suffix';
  final answer = areaAsked ? unit(area, 'cm²') : unit(circumference, 'cm');
  return c.question(
    prompt:
        'A circle has a radius of $r cm. Using π = 3.14, what is its '
        '${areaAsked ? 'area' : 'circumference'}?',
    answer: answer,
    mistakes: areaAsked
        ? [
            unit(circumference, 'cm²'),
            unit(314 * 4 * r * r, 'cm²'),
            unit(314 * r, 'cm²'),
          ]
        : [unit(area, 'cm'), unit(314 * r, 'cm'), unit(1256 * r, 'cm')],
    alternative: (attempt) => areaAsked
        ? unit(area + 314 * attempt, 'cm²')
        : unit(circumference + 314 * attempt, 'cm'),
    hint: areaAsked
        ? 'Area of a circle = π $_x radius $_x radius.'
        : 'Circumference = 2 $_x π $_x radius.',
    explanation: areaAsked
        ? 'Area = 3.14 $_x $r $_x $r = ${unit(area, 'cm²')}.'
        : 'Circumference = 2 $_x 3.14 $_x $r = ${unit(circumference, 'cm')}.',
  );
}

Question _pythagoras(QuestionContext c) {
  final (a, b, h) = c.pick(const [
    (3, 4, 5),
    (5, 12, 13),
    (8, 15, 17),
    (7, 24, 25),
  ]);
  final k = c.between(1, h > 13 ? 2 : 4);
  final (legA, legB, hyp) = (a * k, b * k, h * k);
  String cm(int v) => '$v cm';
  return c.question(
    prompt:
        'A right-angled triangle has shorter sides of $legA cm and '
        '$legB cm. How long is the longest side?',
    answer: cm(hyp),
    mistakes: [
      cm(legA + legB),
      cm(legA * legA + legB * legB),
      cm(legB + 1),
      cm(hyp + k),
    ],
    alternative: c.nearbyIntegers(hyp, min: legB + 1, format: cm),
    hint: 'Pythagoras: a² + b² = c².',
    explanation:
        '${MathText.power(legA, 2)} + ${MathText.power(legB, 2)} = '
        '${legA * legA} + ${legB * legB} = ${hyp * hyp}, and '
        '√${hyp * hyp} = $hyp, so the longest side is $hyp cm.',
  );
}

// ---------------------------------------------------------------------------
// Time

/// 12-hour clock text for [minutes] after midnight: `3:05`.
String _clock(int minutes) {
  final m = minutes % (24 * 60);
  final hour = (m ~/ 60) % 12 == 0 ? 12 : (m ~/ 60) % 12;
  return '$hour:${(m % 60).toString().padLeft(2, '0')}';
}

/// 12-hour clock with AM/PM: `5:45 PM`.
String _clockAmPm(int minutes) =>
    '${_clock(minutes)} ${(minutes % (24 * 60)) < 12 * 60 ? 'AM' : 'PM'}';

/// 24-hour clock: `17:45`.
String _clock24(int minutes) {
  final m = minutes % (24 * 60);
  return '${(m ~/ 60).toString().padLeft(2, '0')}:'
      '${(m % 60).toString().padLeft(2, '0')}';
}

/// A duration: `1 h 35 min`, `45 min`, `2 h`.
String _duration(int minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  if (h == 0) return '$m min';
  return m == 0 ? '$h h' : '$h h $m min';
}

Question _time(QuestionContext c) => switch (c.level) {
  <= 5 => _clockArithmetic(c),
  6 => _hoursToMinutes(c),
  7 => _durationBetween(c, twentyFourHour: false),
  8 => _minutesToHours(c),
  9 => _twentyFourHour(c),
  _ => _durationBetween(c, twentyFourHour: true),
};

Question _clockArithmetic(QuestionContext c) {
  final (int start, int change, bool before) = switch (c.level) {
    1 => (c.between(1, 11) * 60, c.between(1, 3) * 60, false),
    2 => (
      c.between(1, 11) * 60 + c.pick(const [0, 30]),
      c.pick(const [30, 60, 120]),
      false,
    ),
    3 => (
      c.between(1, 11) * 60 + c.between(0, 3) * 15,
      c.between(1, 3) * 15,
      false,
    ),
    4 => (c.between(12, 143) * 5, c.between(1, 11) * 5, false),
    _ => (c.between(13, 143) * 5, c.between(1, 11) * 5, true),
  };
  final end = before ? start - change : start + change;
  final carry = (start ~/ 60) != (end ~/ 60);
  final changeText = change % 60 == 0
      ? '${change ~/ 60} hour${change == 60 ? '' : 's'}'
      : '$change minutes';
  return c.question(
    prompt:
        'What time is it $changeText ${before ? 'before' : 'after'} '
        '${_clock(start)}?',
    answer: _clock(end),
    mistakes: [
      if (carry) _clock(before ? end + 60 : end - 60),
      _clock(end + 60),
      _clock(end - 60),
      _clock(before ? start + change : start - change),
      if (change % 60 != 0) _clock(end + 5),
    ],
    alternative: (attempt) => _clock(end + attempt * (c.level <= 3 ? 30 : 5)),
    hint: change % 60 == 0
        ? 'Count ${before ? 'back' : 'on'} $changeText; the minutes stay '
              'the same.'
        : carry
        ? 'Count ${before ? 'back' : 'on'} to the hour first, then the '
              'minutes that are left.'
        : 'Count ${before ? 'back' : 'on'} in steps of 5 minutes.',
    explanation:
        '${_clock(start)} ${before ? _minus : '+'} $changeText = '
        '${_clock(end)}.',
  );
}

Question _hoursToMinutes(QuestionContext c) {
  final hours = c.between(1, 5);
  final extra = c.pick(const [0, 15, 20, 30, 45]);
  final total = hours * 60 + extra;
  final text = extra == 0
      ? '$hours hour${hours == 1 ? '' : 's'}'
      : '$hours hour${hours == 1 ? '' : 's'} $extra minutes';
  String min(int v) => '$v minutes';
  return c.question(
    prompt: 'How many minutes are in $text?',
    answer: min(total),
    mistakes: [
      min(hours * 100 + extra),
      min(hours * 60),
      min(total + 60),
      min(hours + extra),
    ],
    alternative: c.nearbyIntegers(total, step: 5, min: 1, format: min),
    hint: 'There are 60 minutes in every hour.',
    explanation:
        '$hours $_x 60 = ${hours * 60} minutes'
        '${extra == 0 ? '' : ', plus $extra = $total minutes'}.',
  );
}

Question _minutesToHours(QuestionContext c) {
  final total = c.between(14, 60) * 5;
  return c.question(
    prompt: 'How long is $total minutes in hours and minutes?',
    answer: _duration(total),
    mistakes: [
      if (total % 100 < 60 && total ~/ 100 > 0)
        _duration(total ~/ 100 * 60 + total % 100),
      _duration(total + 60),
      _duration(total - 60),
      _duration(total + 10),
    ],
    alternative: (attempt) => _duration(total + attempt * 5),
    hint: 'How many whole groups of 60 fit into $total?',
    explanation:
        '$total = ${total ~/ 60} $_x 60 + ${total % 60}, so it is '
        '${_duration(total)}.',
  );
}

Question _durationBetween(QuestionContext c, {required bool twentyFourHour}) {
  final start = twentyFourHour
      ? c.between(96, 140) * 5
      : c.between(84, 120) * 5;
  final length = c.between(4, twentyFourHour ? 60 : 36) * 5;
  final end = start + length;
  final format = twentyFourHour ? _clock24 : _clock;
  return c.question(
    prompt: 'How long is it from ${format(start)} to ${format(end)}?',
    answer: _duration(length),
    mistakes: [
      _duration(length + 60),
      if (length > 60) _duration(length - 60),
      _duration(length + 40),
      _duration(
        (end % 60 - start % 60).abs() + (end ~/ 60 - start ~/ 60) * 60 + 5,
      ),
    ],
    alternative: (attempt) => _duration(length + attempt * 5),
    hint: 'Count on to the next whole hour, then on to the end time.',
    explanation:
        'From ${format(start)} to ${format(end)} is ${_duration(length)}.',
  );
}

Question _twentyFourHour(QuestionContext c) {
  final time = c.between(0, 287) * 5;
  return c.question(
    prompt: 'What is ${_clock24(time)} on a 12-hour clock?',
    answer: _clockAmPm(time),
    mistakes: [
      _clockAmPm(time + 12 * 60),
      _clockAmPm(time - 10 * 60),
      _clockAmPm(time + 60),
      _clockAmPm(time - 60),
    ],
    alternative: (attempt) => _clockAmPm(time + attempt * 5),
    hint: 'After 12:00, subtract 12 from the hour and use PM.',
    explanation: time >= 13 * 60
        ? 'Subtract 12 from the hour: ${_clock24(time)} is '
              '${_clockAmPm(time)}.'
        : '${_clock24(time)} is ${_clockAmPm(time)}'
              '${time < 60 ? ' (00 means 12 at night)' : ''}.',
  );
}

// ---------------------------------------------------------------------------
// Money

/// "A" or "An" for [noun].
String _article(String noun) => 'aeiou'.contains(noun[0]) ? 'An' : 'A';

const List<String> _items = [
  'pen',
  'notebook',
  'apple',
  'sticker pack',
  'juice',
  'comic',
];

Question _money(QuestionContext c) {
  final whole = c.level <= 2;
  String m(int cents) => MathText.money(cents, allowWhole: whole);
  String Function(int) near(int answer, int step) =>
      c.nearbyIntegers(answer, step: step, min: step, format: m);

  switch (c.level) {
    case 1 || 3 || 5:
      final step = c.scale([100, 100, 25, 25, 1]);
      final max = c.scale([1000, 1000, 1000, 1000, 2000]);
      final a = c.between(1, max ~/ step) * step;
      final b = c.between(1, max ~/ step) * step;
      return c.question(
        prompt: '${m(a)} + ${m(b)} = ?',
        answer: m(a + b),
        mistakes: [
          m(a + b + 100),
          m(a + b - 100),
          if (!whole) m(a + b + 10),
          m((a - b).abs()),
        ],
        alternative: near(a + b, step),
        hint: 'Add the dollars, then add the cents.',
        explanation: '${m(a)} + ${m(b)} = ${m(a + b)}.',
      );
    case 2 || 4 || 6:
      final paid = c.scale([1000, 1000, 1000, 500, 1000, 2000]);
      final step = c.scale([100, 100, 100, 5, 5, 1]);
      final price = c.between(1, paid ~/ step - 1) * step;
      final change = paid - price;
      final item = c.pick(_items);
      return c.question(
        prompt:
            '${_article(item)} $item costs ${m(price)}. You pay with ${m(paid)}. How '
            'much change do you get?',
        answer: m(change),
        mistakes: [
          m(change + 100),
          if (change > 100) m(change - 100),
          if (!whole) m(change + 10),
          m(paid + price),
        ],
        alternative: near(change, step),
        hint: 'Count up from ${m(price)} to ${m(paid)}.',
        explanation: '${m(paid)} $_minus ${m(price)} = ${m(change)}.',
      );
    case 7:
      final count = c.between(2, 6);
      final price = c.between(1, 20) * 25;
      final item = c.pick(_items);
      return c.question(
        prompt: 'How much do $count ${item}s cost at ${m(price)} each?',
        answer: m(count * price),
        mistakes: [
          m(count + price),
          m((count + 1) * price),
          m((count - 1) * price),
          m(count * price + 100),
        ],
        alternative: near(count * price, 25),
        hint: 'Multiply the price by the number of ${item}s.',
        explanation: '$count $_x ${m(price)} = ${m(count * price)}.',
      );
    case 8:
      final prices = [for (var i = 0; i < 3; i++) c.between(50, 999)];
      final total = prices.reduce((a, b) => a + b);
      return c.question(
        prompt:
            'What is the total of ${m(prices[0])}, ${m(prices[1])} and '
            '${m(prices[2])}?',
        answer: m(total),
        mistakes: [m(total + 100), m(total - 100), m(total + 10), m(total - 1)],
        alternative: near(total, 1),
        hint: 'Add two of the prices first, then add the third.',
        explanation:
            '${m(prices[0])} + ${m(prices[1])} = ${m(prices[0] + prices[1])}, '
            'then + ${m(prices[2])} = ${m(total)}.',
      );
    case 9:
      final percent = c.pick(const [10, 20, 25, 50]);
      final price = c.between(2, 25) * 400;
      final off = price * percent ~/ 100;
      return c.question(
        prompt:
            'A ${m(price)} jacket is $percent% off. What is the sale '
            'price?',
        answer: m(price - off),
        mistakes: [
          m(off),
          if (price > percent * 100) m(price - percent * 100),
          m(price + off),
          m(price - off + 100),
        ],
        alternative: near(price - off, 100),
        hint: 'Find $percent% of ${m(price)}, then take it away.',
        explanation:
            '$percent% of ${m(price)} is ${m(off)}. ${m(price)} $_minus '
            '${m(off)} = ${m(price - off)}.',
      );
    default:
      final people = c.between(2, 6);
      final each = c.between(150, 2500);
      final total = each * people;
      return c.question(
        prompt:
            '$people friends share a ${m(total)} bill equally. How much '
            'does each pay?',
        answer: m(each),
        mistakes: [
          m(total - people * 100),
          m(each + 100),
          m(each - 10),
          m(total ~/ (people + 1)),
        ],
        alternative: near(each, 1),
        hint: 'Divide the total by $people.',
        explanation:
            '${m(total)} ${MathText.divide} $people = ${m(each)}. Check: '
            '$people $_x ${m(each)} = ${m(total)}.',
      );
  }
}

// ---------------------------------------------------------------------------
// Measurement

/// (larger unit, smaller unit, factor, decimal places for the factor).
const List<(String, String, int, int)> _conversions = [
  ('m', 'cm', 100, 2),
  ('kg', 'g', 1000, 3),
  ('l', 'ml', 1000, 3),
  ('cm', 'mm', 10, 1),
  ('km', 'm', 1000, 3),
];

Question _measurement(QuestionContext c) {
  final (big, small, factor, places) = c.level <= 1
      ? _conversions.first
      : c.pick(c.level <= 3 ? _conversions.sublist(0, 4) : _conversions);
  String d(int scaled, int p, String unit) =>
      '${MathText.decimal(scaled, p)} $unit';
  final wrongFactors = [
    for (final f in const [10, 100, 1000])
      if (f != factor) f,
  ];

  switch (c.level) {
    case 1 || 2 || 4:
      final value = c.between(2, c.level == 4 ? 25 : 9);
      final answer = value * factor;
      return c.question(
        prompt: '$value $big = ? $small',
        answer: d(answer, 0, small),
        mistakes: [
          for (final f in wrongFactors) d(value * f, 0, small),
          d(answer + factor, 0, small),
        ],
        alternative: (attempt) => d(answer + attempt * value, 0, small),
        hint: 'There are ${_n(factor)} $small in 1 $big.',
        explanation:
            '1 $big = ${_n(factor)} $small, so $value $big = '
            '$value $_x ${_n(factor)} = ${_n(answer)} $small.',
      );
    case 3:
      final value = c.between(1, 9);
      return c.question(
        prompt: '${_n(value * factor)} $small = ? $big',
        answer: d(value, 0, big),
        mistakes: [
          for (final f in wrongFactors) d(value * factor, _log10(f), big),
          d(value * factor * factor, 0, big),
        ],
        alternative: (attempt) => d(value + attempt, 0, big),
        hint: 'Divide by ${_n(factor)} to change $small into $big.',
        explanation:
            '${_n(value * factor)} ${MathText.divide} '
            '${_n(factor)} = $value $big.',
      );
    case 5:
      // One decimal place keeps the answer whole for every factor.
      var scaled = c.between(11, 99);
      if (scaled % 10 == 0) scaled++; // Keep a visible decimal digit.
      final answer = scaled * factor ~/ 10;
      return c.question(
        prompt: '${d(scaled, 1, big)} = ? $small',
        answer: d(answer, 0, small),
        mistakes: [
          for (final f in wrongFactors) d(scaled * f, 1, small),
          d(scaled * factor, 0, small),
        ],
        alternative: (attempt) => d(answer + attempt * factor ~/ 10, 0, small),
        hint:
            'Multiply by ${_n(factor)}: move the digits $places '
            'place${places == 1 ? '' : 's'} to the left.',
        explanation:
            '${d(scaled, 1, big)} $_x ${_n(factor)} = '
            '${d(answer, 0, small)}.',
      );
    case 6:
      final value = c.between(factor ~/ 10 + 1, factor * 3);
      return c.question(
        prompt: '${_n(value)} $small = ? $big',
        answer: d(value, places, big),
        mistakes: [
          for (final f in wrongFactors) d(value, _log10(f), big),
          d(value * factor, 0, big),
        ],
        alternative: (attempt) =>
            d(value + attempt * (factor ~/ 10), places, big),
        hint:
            'Divide by ${_n(factor)}: move the digits $places '
            'place${places == 1 ? '' : 's'} to the right.',
        explanation:
            '${_n(value)} ${MathText.divide} ${_n(factor)} = '
            '${d(value, places, big)}.',
      );
    case 7:
      final bigPart = c.between(1, 9);
      final smallPart = c.between(1, factor - 1);
      final total = bigPart * factor + smallPart;
      return c.question(
        prompt: '$bigPart $big ${_n(smallPart)} $small = ? $small',
        answer: d(total, 0, small),
        mistakes: [
          d(bigPart + smallPart, 0, small),
          for (final f in wrongFactors) d(bigPart * f + smallPart, 0, small),
          d(int.parse('$bigPart$smallPart'), 0, small),
        ],
        alternative: (attempt) => d(total + attempt * 10, 0, small),
        hint: 'Change the $big into $small first, then add.',
        explanation:
            '$bigPart $big = ${_n(bigPart * factor)} $small. '
            '${_n(bigPart * factor)} + ${_n(smallPart)} = ${_n(total)} '
            '$small.',
      );
    case 8:
      final scaled = c.between(11, 49);
      final extra = c.between(1, 9) * factor ~/ 10;
      final total = scaled * factor ~/ 10 + extra;
      return c.question(
        prompt: '${d(scaled, 1, big)} + ${_n(extra)} $small = ? $small',
        answer: d(total, 0, small),
        mistakes: [
          d(scaled + extra, 0, small),
          d(scaled * factor ~/ 10, 0, small),
          for (final f in wrongFactors) d(scaled * f ~/ 10 + extra, 0, small),
        ],
        alternative: (attempt) => d(total + attempt * factor ~/ 10, 0, small),
        hint: 'Convert ${d(scaled, 1, big)} to $small first.',
        explanation:
            '${d(scaled, 1, big)} = ${_n(scaled * factor ~/ 10)} '
            '$small, plus ${_n(extra)} = ${_n(total)} $small.',
      );
    case 9:
      final (from, to, unitFactor, why) = c.pick(const [
        ('m²', 'cm²', 10000, '100 $_x 100'),
        ('cm²', 'mm²', 100, '10 $_x 10'),
        ('l', 'cm³', 1000, '1 l = 1,000 cm³'),
        ('m³', 'l', 1000, '1 m³ = 1,000 l'),
      ]);
      final value = c.between(2, 9);
      final answer = value * unitFactor;
      return c.question(
        prompt: '$value $from = ? $to',
        answer: d(answer, 0, to),
        mistakes: [
          d(value * 100, 0, to),
          d(value * 10, 0, to),
          d(value * 1000, 0, to),
          d(value * 10000, 0, to),
        ],
        alternative: (attempt) => d(answer * _pow10(attempt), 0, to),
        hint: from.endsWith('²')
            ? 'Area units square the length factor.'
            : 'Remember how many $to fit in 1 $from.',
        explanation:
            '1 $from = ${_n(unitFactor)} $to ($why), so $value '
            '$from = ${_n(answer)} $to.',
      );
    default:
      final speed = c.between(3, 12) * 10;
      final halfHours = c.between(2, 9);
      final distance = speed * halfHours ~/ 2;
      final hours = MathText.decimal(halfHours * 5, 1);
      return c.question(
        prompt:
            'A train travels at $speed km/h for $hours hours. How far '
            'does it go?',
        answer: '${_n(distance)} km',
        mistakes: [
          '${_n(speed * halfHours)} km',
          '${_n(speed + halfHours * 5 ~/ 10)} km',
          '${_n(distance + speed)} km',
          '${_n(speed * (halfHours ~/ 2))} km',
        ],
        alternative: (attempt) => '${_n(distance + attempt * 5)} km',
        hint: 'Distance = speed $_x time.',
        explanation: '$speed km/h $_x $hours h = ${_n(distance)} km.',
      );
  }
}

int _log10(int value) => (math.log(value) / math.ln10).round();
int _pow10(int exponent) => math.pow(10, exponent).toInt();
