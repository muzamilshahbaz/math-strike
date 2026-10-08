/// Locale-neutral number and duration formatting for HUD values.
///
/// Kept dependency-free (no `intl`) because the game shows only digits,
/// separators and short unit suffixes; full localisation arrives with the
/// language setting.
library;

/// Formats [value] with thousands separators: `12345` → `12,345`.
String formatCount(int value) {
  final digits = value.abs().toString();
  final buffer = StringBuffer(value < 0 ? '-' : '');
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

/// Formats a play-time [duration] compactly: `45s`, `12m`, `2h 05m`.
String formatPlayTime(Duration duration) {
  if (duration.inMinutes < 1) return '${duration.inSeconds}s';
  if (duration.inHours < 1) return '${duration.inMinutes}m';
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  return '${duration.inHours}h ${minutes}m';
}

/// Formats a countdown [duration] in hours and minutes: `5h 12m`, `12m`,
/// or `< 1m` for the final minute.
String formatCountdown(Duration duration) {
  if (duration.inMinutes < 1) return '< 1m';
  if (duration.inHours < 1) return '${duration.inMinutes}m';
  return '${duration.inHours}h ${duration.inMinutes.remainder(60)}m';
}

/// Formats a reaction time in seconds with one decimal: `1.4s`.
String formatReaction(Duration duration) =>
    '${(duration.inMilliseconds / 1000).toStringAsFixed(1)}s';

/// Formats a 0–1 [ratio] as a whole percentage: `0.857` → `86%`.
String formatPercent(double ratio) => '${(ratio * 100).round()}%';
