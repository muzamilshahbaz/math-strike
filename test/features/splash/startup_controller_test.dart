import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/startup/startup_task.dart';
import 'package:math_strike/features/splash/domain/entities/startup_state.dart';
import 'package:math_strike/features/splash/presentation/controllers/startup_controller.dart';
import 'package:math_strike/features/splash/splash_providers.dart';

import '../../helpers/test_app.dart';

void main() {
  late ProviderContainer container;

  StartupController controllerWith(
    List<StartupTask> tasks, {
    Duration minimum = Duration.zero,
  }) {
    container = createTestContainer(
      splashMinimum: minimum,
      overrides: [startupTasksProvider.overrideWithValue(tasks)],
    );
    return container.read(startupControllerProvider.notifier);
  }

  StartupState state() => container.read(startupControllerProvider);

  test('runs every task in order and completes', () async {
    final log = <String>[];
    final controller = controllerWith([
      StartupTask(id: 'a', label: 'A', run: () async => log.add('a')),
      StartupTask(id: 'b', label: 'B', run: () async => log.add('b')),
    ]);

    await controller.start();

    expect(log, ['a', 'b']);
    expect(state().status, StartupStatus.completed);
    expect(state().progress, 1);
    expect(state().currentTaskLabel, isNull);
  });

  test('reports weighted progress and the current label', () async {
    final gate = Completer<void>();
    final controller = controllerWith([
      StartupTask(id: 'heavy', label: 'Heavy', weight: 3, run: () async {}),
      StartupTask(id: 'light', label: 'Light', run: () => gate.future),
    ]);

    final run = controller.start();
    await pumpEventQueue();

    expect(state().status, StartupStatus.running);
    expect(state().progress, 0.75);
    expect(state().currentTaskLabel, 'Light');

    gate.complete();
    await run;
    expect(state().isCompleted, isTrue);
  });

  test('critical failure stops; retry resumes without re-running', () async {
    var firstRuns = 0;
    var attempts = 0;
    final controller = controllerWith([
      StartupTask(id: 'first', label: 'First', run: () async => firstRuns++),
      StartupTask(
        id: 'flaky',
        label: 'Flaky',
        isCritical: true,
        run: () async {
          if (++attempts == 1) throw StateError('boom');
        },
      ),
    ]);

    await controller.start();
    expect(state().status, StartupStatus.failed);
    expect(state().failure?.taskId, 'flaky');

    await controller.retry();
    expect(state().status, StartupStatus.completed);
    expect(state().failure, isNull);
    expect(firstRuns, 1, reason: 'completed tasks are not re-run');
    expect(attempts, 2);
  });

  test('non-critical failure is recorded and start-up continues', () async {
    final controller = controllerWith([
      StartupTask(
        id: 'ads',
        label: 'Ads',
        run: () async => throw StateError('offline'),
      ),
    ]);

    await controller.start();

    expect(state().isCompleted, isTrue);
    expect(state().warnings.single.taskId, 'ads');
  });

  test('a task exceeding its timeout fails', () async {
    final controller = controllerWith([
      StartupTask(
        id: 'hang',
        label: 'Hang',
        isCritical: true,
        timeout: const Duration(milliseconds: 10),
        run: () => Completer<void>().future,
      ),
    ]);

    await controller.start();

    expect(state().status, StartupStatus.failed);
    expect(state().failure?.message, contains('TimeoutException'));
  });

  test('completion waits for the minimum splash duration', () async {
    final controller = controllerWith([
      StartupTask(id: 'a', label: 'A', run: () async {}),
    ], minimum: const Duration(milliseconds: 120));
    final stopwatch = Stopwatch()..start();

    await controller.start();

    expect(stopwatch.elapsedMilliseconds, greaterThanOrEqualTo(110));
    expect(state().isCompleted, isTrue);
  });

  test('concurrent start calls share one run', () async {
    var runs = 0;
    final controller = controllerWith([
      StartupTask(id: 'a', label: 'A', run: () async => runs++),
    ]);

    await Future.wait([controller.start(), controller.start()]);
    await controller.start(); // after completion: no-op

    expect(runs, 1);
  });

  test('the real task registry opens storage and records the launch', () async {
    container = createTestContainer();

    await container.read(startupControllerProvider.notifier).start();

    expect(state().isCompleted, isTrue);
    expect(state().warnings, isEmpty);
  });
}
