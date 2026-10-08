import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/core_providers.dart';
import '../../../../core/utils/calendar_day.dart';
import '../../../../core/utils/formatters.dart';

/// "Next reward in 5h 12m": time left until local midnight, refreshed
/// every minute.
class NextRewardCountdown extends ConsumerStatefulWidget {
  /// Creates the countdown.
  const NextRewardCountdown({this.style, super.key});

  /// Text style.
  final TextStyle? style;

  @override
  ConsumerState<NextRewardCountdown> createState() =>
      _NextRewardCountdownState();
}

class _NextRewardCountdownState extends ConsumerState<NextRewardCountdown> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(
      const Duration(seconds: 30),
      (_) => setState(() {}),
    );
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = ref.watch(clockProvider)();
    final midnight = CalendarDay.fromDateTime(now).addDays(1).startOfDayLocal;
    return Text(
      'Next reward in ${formatCountdown(midnight.difference(now))}',
      style: widget.style,
    );
  }
}
