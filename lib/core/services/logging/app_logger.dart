import 'package:logger/logger.dart';

/// Application logging contract.
///
/// Depend on this interface (never on `package:logger` directly) so the
/// backend can later be swapped for crash reporting / analytics sinks.
abstract interface class AppLogger {
  /// Verbose diagnostic output, stripped in production.
  void debug(String message);

  /// Notable but expected events (e.g. "backup completed").
  void info(String message);

  /// Recoverable problems worth investigating.
  void warning(String message, {Object? error, StackTrace? stackTrace});

  /// Failures that break a user-facing feature.
  void error(String message, {Object? error, StackTrace? stackTrace});
}

/// [AppLogger] backed by `package:logger`, printing to the debug console.
final class ConsoleAppLogger implements AppLogger {
  /// Creates a console logger. When [verbose] is false, debug output is
  /// suppressed.
  ConsoleAppLogger({required bool verbose})
    : _logger = Logger(
        level: verbose ? Level.debug : Level.info,
        printer: PrettyPrinter(methodCount: 0, errorMethodCount: 6),
      );

  final Logger _logger;

  @override
  void debug(String message) => _logger.d(message);

  @override
  void info(String message) => _logger.i(message);

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.w(message, error: error, stackTrace: stackTrace);

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}

/// [AppLogger] that discards everything. Useful in tests.
final class SilentAppLogger implements AppLogger {
  /// Creates a no-op logger.
  const SilentAppLogger();

  @override
  void debug(String message) {}

  @override
  void info(String message) {}

  @override
  void warning(String message, {Object? error, StackTrace? stackTrace}) {}

  @override
  void error(String message, {Object? error, StackTrace? stackTrace}) {}
}
