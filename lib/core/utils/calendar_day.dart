import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

/// A date on the player's local calendar, without a time of day.
///
/// Daily rewards and per-day statistics are keyed by calendar day rather
/// than by [DateTime], so a "day" always runs from local midnight to local
/// midnight regardless of time zones or daylight-saving changes. Arithmetic
/// is done on UTC dates internally, where every day is exactly 24 hours.
@immutable
final class CalendarDay implements Comparable<CalendarDay> {
  /// Creates a calendar day. The values must form a valid date; use
  /// [CalendarDay.fromDateTime] or [addDays] to normalise overflow.
  const CalendarDay(this.year, this.month, this.day);

  /// The calendar day of [dateTime], in that [DateTime]'s own time zone
  /// (local for `DateTime.now()`).
  CalendarDay.fromDateTime(DateTime dateTime)
    : this(dateTime.year, dateTime.month, dateTime.day);

  /// Parses a [toKey] string (`yyyy-MM-dd`), or returns `null` if [key] is
  /// not a valid date.
  static CalendarDay? tryParse(String key) {
    final match = _keyPattern.firstMatch(key);
    if (match == null) return null;
    final parsed = CalendarDay(
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
      int.parse(match.group(3)!),
    );
    // Rejects overflowing dates such as 2026-02-31.
    return CalendarDay.fromDateTime(parsed._utc) == parsed ? parsed : null;
  }

  static final RegExp _keyPattern = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');

  /// Four-digit year.
  final int year;

  /// Month, 1–12.
  final int month;

  /// Day of the month, 1–31.
  final int day;

  DateTime get _utc => DateTime.utc(year, month, day);

  /// Day of the week, [DateTime.monday] (1) to [DateTime.sunday] (7).
  int get weekday => _utc.weekday;

  /// The day [days] after this one (negative for earlier days).
  CalendarDay addDays(int days) =>
      CalendarDay.fromDateTime(DateTime.utc(year, month, day + days));

  /// Whole days from [other] to this day (positive when this is later).
  int daysSince(CalendarDay other) => _utc.difference(other._utc).inDays;

  /// Local midnight at the start of this day.
  DateTime get startOfDayLocal => DateTime(year, month, day);

  /// Stable storage key, `yyyy-MM-dd`.
  String toKey() =>
      '${year.toString().padLeft(4, '0')}-'
      '${month.toString().padLeft(2, '0')}-'
      '${day.toString().padLeft(2, '0')}';

  /// Whether this day is before [other].
  bool isBefore(CalendarDay other) => compareTo(other) < 0;

  @override
  int compareTo(CalendarDay other) => _utc.compareTo(other._utc);

  @override
  bool operator ==(Object other) =>
      other is CalendarDay &&
      other.year == year &&
      other.month == month &&
      other.day == day;

  @override
  int get hashCode => Object.hash(year, month, day);

  @override
  String toString() => toKey();
}

/// Serialises a [CalendarDay] as its `yyyy-MM-dd` key.
final class CalendarDayConverter implements JsonConverter<CalendarDay, String> {
  /// Creates the converter.
  const CalendarDayConverter();

  @override
  CalendarDay fromJson(String json) =>
      CalendarDay.tryParse(json) ??
      (throw FormatException('Invalid calendar day', json));

  @override
  String toJson(CalendarDay object) => object.toKey();
}
