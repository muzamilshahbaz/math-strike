import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/utils/formatters.dart';

void main() {
  test('formatCount adds thousands separators', () {
    expect(formatCount(0), '0');
    expect(formatCount(999), '999');
    expect(formatCount(1000), '1,000');
    expect(formatCount(1234567), '1,234,567');
    expect(formatCount(-4500), '-4,500');
  });

  test('formatPlayTime picks the largest sensible unit', () {
    expect(formatPlayTime(const Duration(seconds: 45)), '45s');
    expect(formatPlayTime(const Duration(minutes: 12, seconds: 5)), '12m');
    expect(formatPlayTime(const Duration(hours: 2, minutes: 5)), '2h 05m');
  });

  test('formatCountdown shows hours and minutes', () {
    expect(formatCountdown(const Duration(seconds: 20)), '< 1m');
    expect(formatCountdown(const Duration(minutes: 42)), '42m');
    expect(formatCountdown(const Duration(hours: 5, minutes: 7)), '5h 7m');
  });

  test('formatReaction and formatPercent', () {
    expect(formatReaction(const Duration(milliseconds: 1449)), '1.4s');
    expect(formatPercent(0.857), '86%');
    expect(formatPercent(1), '100%');
  });
}
