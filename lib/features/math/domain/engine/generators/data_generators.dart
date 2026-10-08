import '../../entities/fraction.dart';
import '../../entities/math_topic.dart';
import '../../entities/question.dart';
import '../math_text.dart';
import '../question_context.dart';

/// Generators for probability, statistics and word problems.
const Map<MathTopic, TopicGenerator> dataGenerators = {
  MathTopic.probability: _probability,
  MathTopic.statistics: _statistics,
  MathTopic.wordProblems: _wordProblems,
};

const String _x = MathText.times;
const String _minus = MathText.minus;
String _n(int value) => MathText.integer(value);

// ---------------------------------------------------------------------------
// Probability

const List<String> _likelihoods = [
  'impossible',
  'unlikely',
  'an even chance',
  'likely',
  'certain',
];

String _likelihood(int favourable, int total) {
  if (favourable == 0) return 'impossible';
  if (favourable == total) return 'certain';
  if (favourable * 2 == total) return 'an even chance';
  return favourable * 2 > total ? 'likely' : 'unlikely';
}

Question _probability(QuestionContext c) => switch (c.level) {
  1 || 2 => _likelihoodWords(c),
  3 => _moreLikely(c),
  _ => _probabilityFraction(c),
};

Question _likelihoodWords(QuestionContext c) {
  final String prompt;
  final String answer;
  final String explanation;
  if (c.level == 1) {
    final red = c.between(0, 10);
    final blue = red == 0 ? c.between(1, 10) : c.between(0, 10);
    final total = red + blue;
    answer = _likelihood(red, total);
    prompt =
        'A bag has $red red and $blue blue balls. Picking a red ball '
        'without looking is…';
    explanation =
        '$red of the $total balls are red, so picking red is '
        '$answer.';
  } else {
    final k = c.between(0, 6);
    final favourable = 6 - k;
    answer = _likelihood(favourable, 6);
    prompt = 'Rolling a number greater than $k on a normal dice is…';
    explanation =
        '$favourable of the 6 numbers are greater than $k, so it '
        'is $answer.';
  }
  return c.question(
    prompt: prompt,
    answer: answer,
    mistakes: _likelihoods,
    hint: 'Compare how many outcomes you want with how many there are.',
    explanation: explanation[0].toUpperCase() + explanation.substring(1),
  );
}

Question _moreLikely(QuestionContext c) {
  final red = c.between(1, 12);
  final blue = c.chance(0.15) ? red : c.between(1, 12);
  final answer = red == blue
      ? 'Equally likely'
      : red > blue
      ? 'Red'
      : 'Blue';
  return c.question(
    prompt:
        'A bag has $red red and $blue blue counters. Which colour are '
        'you more likely to pick?',
    answer: answer,
    mistakes: const ['Red', 'Blue', 'Equally likely'],
    hint: 'The colour with more counters is more likely.',
    explanation: red == blue
        ? 'There are $red of each, so both colours are equally likely.'
        : 'There are more ${red > blue ? 'red' : 'blue'} counters '
              '(${red > blue ? red : blue} against ${red > blue ? blue : red}), '
              'so ${answer.toLowerCase()} is more likely.',
  );
}

Question _probabilityFraction(QuestionContext c) {
  final (
    String prompt,
    int favourable,
    int total,
    String why,
  ) = switch (c.level) {
    4 => _diceEvent(c),
    5 || 7 => _bagEvent(c, complement: c.level == 7),
    6 => _spinnerEvent(c),
    8 => _coinsEvent(c),
    9 => _twoDiceEvent(c),
    _ => _withoutReplacement(c),
  };
  final answer = Fraction(favourable, total);
  return c.question(
    prompt: prompt,
    answer: answer.toString(),
    mistakes: [
      if (total - favourable > 0 && favourable != total - favourable)
        Fraction(favourable, total - favourable).improper,
      Fraction(1, total).toString(),
      if (favourable != total) Fraction(total - favourable, total).toString(),
      Fraction(favourable, total + 1).toString(),
    ],
    alternative: (attempt) =>
        Fraction(favourable + attempt, total + attempt).toString(),
    hint: 'Probability = favourable outcomes ${MathText.divide} all outcomes.',
    explanation:
        '$why: $favourable out of $total, so the probability is '
        '$favourable/$total'
        '${'$favourable/$total' == answer.toString() ? '' : ' = $answer'}.',
  );
}

(String, int, int, String) _diceEvent(QuestionContext c) {
  final face = c.between(1, 6);
  final events = <(String, int, String)>[
    ('a $face', 1, 'Only $face works'),
    ('an even number', 3, '2, 4 and 6 are even'),
    ('a multiple of 3', 2, '3 and 6 are multiples of 3'),
    ('a prime number', 3, '2, 3 and 5 are prime'),
    ('a number less than 3', 2, '1 and 2 are less than 3'),
    ('a number greater than 1', 5, 'Every face except 1 works'),
  ];
  final (event, favourable, why) = c.pick(events);
  return (
    'What is the probability of rolling $event on a normal dice?',
    favourable,
    6,
    why,
  );
}

(String, int, int, String) _bagEvent(
  QuestionContext c, {
  required bool complement,
}) {
  final red = c.between(1, 8);
  final blue = c.between(1, 8);
  final green = c.between(1, 8);
  final total = red + blue + green;
  return complement
      ? (
          'A bag has $red red, $blue blue and $green green marbles. What is '
              'the probability of NOT picking red?',
          blue + green,
          total,
          '$blue + $green = ${blue + green} marbles are not red',
        )
      : (
          'A bag has $red red, $blue blue and $green green marbles. What is '
              'the probability of picking red?',
          red,
          total,
          '$red of the $total marbles are red',
        );
}

(String, int, int, String) _spinnerEvent(QuestionContext c) {
  final sections = c.between(4, 10);
  final yellow = c.between(1, sections - 1);
  return (
    'A spinner has $sections equal sections and $yellow of them are yellow. '
        'What is the probability of landing on yellow?',
    yellow,
    sections,
    '$yellow of the $sections sections are yellow',
  );
}

(String, int, int, String) _coinsEvent(QuestionContext c) {
  final (event, favourable, why) = c.pick(const [
    ('two heads', 1, 'Only HH is two heads'),
    ('two tails', 1, 'Only TT is two tails'),
    ('one head and one tail', 2, 'HT and TH both work'),
    ('at least one head', 3, 'HH, HT and TH all work'),
  ]);
  return (
    'Two coins are flipped. What is the probability of getting $event?',
    favourable,
    4,
    '$why, among HH, HT, TH and TT',
  );
}

(String, int, int, String) _twoDiceEvent(QuestionContext c) {
  if (c.chance(0.25)) {
    return (
      'Two dice are rolled. What is the probability of rolling a double?',
      6,
      36,
      'There are 6 doubles among the 36 outcomes',
    );
  }
  final sum = c.between(2, 12);
  final ways = 6 - (sum - 7).abs();
  return (
    'Two dice are rolled. What is the probability that they add up to '
        '$sum?',
    ways,
    36,
    '$ways of the 36 outcomes add up to $sum',
  );
}

(String, int, int, String) _withoutReplacement(QuestionContext c) {
  final red = c.between(2, 6);
  final blue = c.between(1, 6);
  final total = red + blue;
  return (
    'A bag has $red red and $blue blue sweets. Two are taken without '
        'putting the first back. What is the probability both are red?',
    red * (red - 1),
    total * (total - 1),
    'Multiply the chances of each pick ($red/$total $_x '
        '${red - 1}/${total - 1})',
  );
}

// ---------------------------------------------------------------------------
// Statistics

String _list(List<int> values) => values.map(_n).join(', ');

int _sum(List<int> values) => values.fold(0, (a, b) => a + b);

Question _statistics(QuestionContext c) => switch (c.level) {
  1 => _mode(c),
  2 => _range(c),
  3 => _median(c, 5),
  4 => _mean(c, 3, 20),
  5 => _mean(c, c.between(4, 5), 30),
  6 => _median(c, 6),
  7 => _mean(c, 5, 100),
  8 => _missingValue(c),
  9 => _meanTotal(c),
  _ => _combinedMean(c),
};

/// Other statistics of [values], used as tempting wrong answers.
List<String> _otherStatistics(List<int> values) {
  final sorted = [...values]..sort();
  return [
    _n(_sum(values)),
    _n(sorted.last - sorted.first),
    _n(sorted[sorted.length ~/ 2]),
    if (_sum(values) % values.length == 0) _n(_sum(values) ~/ values.length),
    _n(sorted.last),
  ];
}

Question _mode(QuestionContext c) {
  final mode = c.between(1, 10);
  final others = <int>{};
  while (others.length < 3) {
    final v = c.between(1, 10);
    if (v != mode) others.add(v);
  }
  final repeats = c.between(2, 3);
  final values = [...List.filled(repeats, mode), ...others]..shuffle(c.random);
  return c.question(
    prompt: 'What is the mode of ${_list(values)}?',
    answer: _n(mode),
    mistakes: [for (final v in others) _n(v), ..._otherStatistics(values)],
    alternative: c.nearbyIntegers(mode, min: 1),
    hint: 'The mode is the number that appears most often.',
    explanation:
        '$mode appears $repeats times, more than any other number, '
        'so the mode is $mode.',
  );
}

Question _range(QuestionContext c) {
  final values = [for (var i = 0; i < 5; i++) c.between(1, 20)];
  final sorted = [...values]..sort();
  final range = sorted.last - sorted.first;
  return c.question(
    prompt: 'What is the range of ${_list(values)}?',
    answer: _n(range),
    mistakes: [
      _n(sorted.last),
      _n(sorted.last + sorted.first),
      _n(values.last - values.first),
      ..._otherStatistics(values),
    ],
    alternative: c.nearbyIntegers(range),
    hint: 'Range = largest $_minus smallest.',
    explanation:
        'Largest $_minus smallest = ${sorted.last} $_minus '
        '${sorted.first} = $range.',
  );
}

Question _median(QuestionContext c, int count) {
  final values = [for (var i = 0; i < count; i++) c.between(1, 30)];
  final sorted = [...values]..sort();
  final String answer;
  final String middle;
  if (count.isOdd) {
    answer = _n(sorted[count ~/ 2]);
    middle = 'The middle value is $answer.';
  } else {
    final a = sorted[count ~/ 2 - 1];
    final b = sorted[count ~/ 2];
    answer = MathText.decimal((a + b) * 5, 1);
    middle = 'The middle two are $a and $b; halfway between them is $answer.';
  }
  return c.question(
    prompt: 'What is the median of ${_list(values)}?',
    answer: answer,
    mistakes: [
      _n(values[count ~/ 2]),
      if (count.isEven) _n(sorted[count ~/ 2]),
      ..._otherStatistics(values),
    ],
    alternative: (attempt) => MathText.decimal(
      (sorted[count ~/ 2] + attempt) * 10 + (count.isEven ? 5 : 0),
      1,
    ),
    hint: 'Put the numbers in order first, then find the middle.',
    explanation: 'In order: ${_list(sorted)}. $middle',
  );
}

/// [count] values between 0 and [max] whose mean is a whole number.
(List<int>, int) _valuesWithWholeMean(QuestionContext c, int count, int max) {
  while (true) {
    final values = [for (var i = 0; i < count - 1; i++) c.between(1, max)];
    final mean = c.between(2, max);
    final last = mean * count - _sum(values);
    if (last >= 1 && last <= max) {
      return ([...values, last]..shuffle(c.random), mean);
    }
  }
}

Question _mean(QuestionContext c, int count, int max) {
  final (values, mean) = _valuesWithWholeMean(c, count, max);
  final total = _sum(values);
  return c.question(
    prompt: 'What is the mean of ${_list(values)}?',
    answer: _n(mean),
    mistakes: [
      ..._otherStatistics(values),
      if (total % (count + 1) == 0) _n(total ~/ (count + 1)),
      _n(mean + 1),
    ],
    alternative: c.nearbyIntegers(mean),
    hint: 'Add them all up, then divide by how many numbers there are.',
    explanation:
        'Total = ${_n(total)}. ${_n(total)} ${MathText.divide} '
        '$count = ${_n(mean)}.',
  );
}

Question _missingValue(QuestionContext c) {
  final (values, mean) = _valuesWithWholeMean(c, 3, 20);
  final missing = values.removeLast();
  final known = _sum(values);
  return c.question(
    prompt: 'The mean of ${_list(values)} and x is $mean. What is x?',
    answer: _n(missing),
    mistakes: [
      _n(mean),
      _n(mean * 3),
      if (mean * 2 - known >= 0) _n(mean * 2 - known),
      _n(missing + 3),
    ],
    alternative: c.nearbyIntegers(missing),
    hint: 'The mean $_x 3 is the total of all three numbers.',
    explanation:
        'The total must be $mean $_x 3 = ${mean * 3}. '
        '${mean * 3} $_minus $known = $missing.',
  );
}

Question _meanTotal(QuestionContext c) {
  final count = c.between(4, 9);
  final mean = c.between(5, 40);
  return c.question(
    prompt: 'The mean of $count numbers is $mean. What is their total?',
    answer: _n(count * mean),
    mistakes: [
      _n(count + mean),
      if (mean % count == 0) _n(mean ~/ count),
      _n(count * mean + mean),
      _n((count - 1) * mean),
    ],
    alternative: c.nearbyIntegers(count * mean, step: count),
    hint: 'Mean = total ${MathText.divide} count, so total = mean $_x count.',
    explanation: 'Total = $mean $_x $count = ${_n(count * mean)}.',
  );
}

Question _combinedMean(QuestionContext c) {
  while (true) {
    final a = c.between(2, 8);
    final b = c.between(2, 8);
    final meanA = c.between(10, 30);
    final meanB = c.between(10, 30);
    final total = a * meanA + b * meanB;
    if (total % (a + b) != 0 || meanA == meanB) continue;
    final combined = total ~/ (a + b);
    final naive = (meanA + meanB) / 2;
    return c.question(
      prompt:
          'Group A has $a people with a mean age of $meanA. Group B has '
          '$b people with a mean age of $meanB. What is the mean age of '
          'everyone?',
      answer: _n(combined),
      mistakes: [
        if (naive == naive.roundToDouble()) _n(naive.round()),
        _n(combined + 1),
        _n(combined - 1),
        _n(total),
      ],
      alternative: c.nearbyIntegers(combined),
      hint: 'Find each group\'s total age first.',
      explanation:
          'Totals: $a $_x $meanA = ${a * meanA} and $b $_x $meanB = '
          '${b * meanB}. Together ${_n(total)} ${MathText.divide} ${a + b} '
          '= $combined.',
    );
  }
}

// ---------------------------------------------------------------------------
// Word problems

const List<String> _names = [
  'Ava',
  'Leo',
  'Mia',
  'Sam',
  'Zara',
  'Kai',
  'Lina',
  'Omar',
  'Ella',
  'Ravi',
];

const List<(String, String)> _things = [
  ('apple', 'apples'),
  ('sticker', 'stickers'),
  ('marble', 'marbles'),
  ('book', 'books'),
  ('card', 'cards'),
  ('shell', 'shells'),
  ('cookie', 'cookies'),
];

Question _wordProblems(QuestionContext c) {
  final name = c.pick(_names);
  var other = c.pick(_names);
  while (other == name) {
    other = c.pick(_names);
  }
  final (one, many) = c.pick(_things);
  String count(int n) => '${_n(n)} ${n == 1 ? one : many}';

  final (
    String prompt,
    int answer,
    List<int> wrong,
    String hint,
    String why,
  ) = switch (c.level) {
    1 => () {
      final a = c.between(1, 6);
      final b = c.between(1, 4);
      return (
        '$name has ${count(a)} and finds $b more. How many $many does '
            '$name have now?',
        a + b,
        [a - b, a, b],
        '"More" means add.',
        '$a + $b = ${a + b}',
      );
    }(),
    2 => () {
      final a = c.between(5, 20);
      final b = c.between(1, a - 1);
      return (
        '$name has ${count(a)} and gives $b to $other. How many are '
            'left?',
        a - b,
        [a + b, b, a - b + 1],
        'Giving away means take away.',
        '$a $_minus $b = ${a - b}',
      );
    }(),
    3 => () {
      final a = c.between(20, 99);
      final b = c.between(10, a - 1);
      return (
        '$name has ${count(a)} and $other has ${count(b)}. How many more '
            'does $name have?',
        a - b,
        [a + b, a - b + 10, a],
        '"How many more" means find the difference.',
        '$a $_minus $b = ${a - b}',
      );
    }(),
    4 => () {
      final bags = c.between(2, 10);
      final each = c.between(2, 10);
      return (
        'There are $bags bags with ${count(each)} in each. How many '
            '$many are there altogether?',
        bags * each,
        [bags + each, bags * (each - 1), bags * each + each],
        'Equal groups: multiply.',
        '$bags $_x $each = ${bags * each}',
      );
    }(),
    5 => () {
      final friends = c.between(2, 10);
      final each = c.between(2, 10);
      return (
        '${_n(friends * each)} $many are shared equally between '
            '$friends friends. How many does each friend get?',
        each,
        [friends * each - friends, friends, each + 1],
        'Sharing equally: divide.',
        '${friends * each} ${MathText.divide} $friends = $each',
      );
    }(),
    6 => () {
      final start = c.between(5, 30);
      final packs = c.between(2, 5);
      final per = c.between(3, 10);
      final away = c.between(1, start);
      final end = start + packs * per - away;
      return (
        '$name has ${count(start)}, buys $packs packs of $per, then gives '
            '$away away. How many $many does $name have now?',
        end,
        [start + packs * per, start + packs + per - away, end + away * 2],
        'Work it out in steps: first the packs, then what was given away.',
        '$packs $_x $per = ${packs * per}. $start + ${packs * per} '
            '$_minus $away = $end',
      );
    }(),
    7 => () {
      final items = c.between(2, 5);
      final price = c.between(2, 9);
      final paid = ((items * price) ~/ 10 + 1) * 10;
      return (
        '$name buys $items books at ${MathText.currency}$price each and '
            'pays with ${MathText.currency}$paid. How much change, in '
            'dollars?',
        paid - items * price,
        [items * price, paid - price, paid - items - price],
        'Find the total cost first, then the change.',
        '$items $_x $price = ${items * price}. $paid $_minus '
            '${items * price} = ${paid - items * price} dollars',
      );
    }(),
    8 => () {
      final perDay = c.between(5, 25);
      final days = c.between(3, 12);
      return c.chance(0.5)
          ? (
              '$name reads $perDay pages every day. How many pages in '
                  '$days days?',
              perDay * days,
              [perDay + days, perDay * (days - 1), perDay * days + 10],
              'The same amount every day: multiply.',
              '$perDay $_x $days = ${perDay * days}',
            )
          : (
              'A book has ${perDay * days} pages. $name reads $perDay '
                  'pages a day. How many days to finish it?',
              days,
              [perDay, days + 1, perDay * days - perDay],
              'How many groups of $perDay make ${perDay * days}?',
              '${perDay * days} ${MathText.divide} $perDay = $days',
            );
    }(),
    9 => () {
      final den = c.pick(const [2, 3, 4, 5, 10]);
      final num = c.between(1, den - 1);
      final group = den * c.between(2, 10);
      final part = group * num ~/ den;
      return (
        '$num/$den of the $group children in a school club like '
            'football. How many children is that?',
        part,
        [group ~/ den, group - part, part + num],
        'Find 1/$den first, then multiply by $num.',
        '$group ${MathText.divide} $den = ${group ~/ den}, and '
            '${group ~/ den} $_x $num = $part',
      );
    }(),
    _ => () {
      final a = c.between(1, 5);
      var b = c.between(1, 5);
      while (b == a) {
        b = c.between(1, 5);
      }
      final unit = c.between(2, 9);
      final total = (a + b) * unit;
      return (
        '$name and $other share ${count(total)} in the ratio $a:$b. How '
            'many does $other get?',
        b * unit,
        [a * unit, total ~/ 2, b * unit + b],
        'Add the ratio parts to find the size of one part.',
        '$a + $b = ${a + b} parts. ${_n(total)} ${MathText.divide} '
            '${a + b} = $unit per part, so $other gets $b $_x $unit = '
            '${b * unit}',
      );
    }(),
  };

  return c.question(
    prompt: prompt,
    answer: _n(answer),
    mistakes: [
      for (final w in wrong)
        if (w >= 0 && w != answer) _n(w),
      _n(answer + 1),
    ],
    alternative: c.nearbyIntegers(answer),
    hint: hint,
    explanation: '$why.',
  );
}
