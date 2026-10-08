import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:math_strike/core/di/core_providers.dart';

/// A controllable [Clock] for date-dependent tests.
class FakeClock {
  /// Creates a clock reading [now].
  FakeClock(this.now);

  /// The current (fake) time.
  DateTime now;

  /// Reads the time; pass the tear-off `clock.call` as a [Clock].
  DateTime call() => now;

  /// Moves the clock forward by [duration].
  void advance(Duration duration) => now = now.add(duration);

  /// Overrides [clockProvider] with this clock.
  Override get override => clockProvider.overrideWithValue(call);
}
