import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/utils/calendar_day.dart';

void main() {
  group('CalendarDay', () {
    test('is taken from the DateTime fields, ignoring the time', () {
      expect(
        CalendarDay.fromDateTime(DateTime(2026, 3, 9, 23, 59)),
        const CalendarDay(2026, 3, 9),
      );
    });

    test('adds days across month, year and leap-day boundaries', () {
      expect(
        const CalendarDay(2026, 1, 31).addDays(1),
        const CalendarDay(2026, 2, 1),
      );
      expect(
        const CalendarDay(2026, 12, 31).addDays(1),
        const CalendarDay(2027, 1, 1),
      );
      expect(
        const CalendarDay(2028, 2, 28).addDays(1),
        const CalendarDay(2028, 2, 29),
      );
      expect(
        const CalendarDay(2026, 3, 1).addDays(-1),
        const CalendarDay(2026, 2, 28),
      );
    });

    test('counts whole days between dates', () {
      const a = CalendarDay(2026, 3, 1);
      expect(a.addDays(10).daysSince(a), 10);
      expect(a.daysSince(a.addDays(10)), -10);
      expect(a.daysSince(a), 0);
    });

    test('round-trips through its storage key', () {
      const day = CalendarDay(2026, 7, 4);
      expect(day.toKey(), '2026-07-04');
      expect(CalendarDay.tryParse(day.toKey()), day);
    });

    test('rejects malformed and impossible keys', () {
      expect(CalendarDay.tryParse('2026-02-31'), isNull);
      expect(CalendarDay.tryParse('2026-13-01'), isNull);
      expect(CalendarDay.tryParse('26-1-1'), isNull);
      expect(CalendarDay.tryParse('yesterday'), isNull);
    });

    test('orders chronologically and reports weekdays', () {
      const monday = CalendarDay(2026, 10, 5);
      expect(monday.weekday, DateTime.monday);
      expect(monday.isBefore(monday.addDays(1)), isTrue);
      expect(monday.addDays(1).isBefore(monday), isFalse);
    });

    test('converter throws on invalid JSON values', () {
      const converter = CalendarDayConverter();
      expect(converter.fromJson('2026-10-09'), const CalendarDay(2026, 10, 9));
      expect(() => converter.fromJson('nope'), throwsFormatException);
    });
  });
}
