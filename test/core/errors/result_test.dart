import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/core/errors/failure.dart';
import 'package:math_strike/core/errors/result.dart';

void main() {
  group('Result', () {
    test('guard wraps a returned value in Success', () async {
      final result = await Result.guard(() async => 42);
      expect(result, const Success(42));
      expect(result.isSuccess, isTrue);
      expect(result.valueOrNull, 42);
      expect(result.failureOrNull, isNull);
    });

    test(
      'guard converts thrown AppException to the matching Failure',
      () async {
        final result = await Result.guard<int>(
          () async => throw const StorageException('disk full'),
        );
        expect(result.failureOrNull, isA<StorageFailure>());
        expect(result.failureOrNull!.message, 'disk full');
        expect(result.valueOrNull, isNull);
      },
    );

    test('guardSync maps FormatException to DataFormatFailure', () {
      final result = Result.guardSync<int>(() => int.parse('x'));
      expect(result.failureOrNull, isA<DataFormatFailure>());
    });

    test('fold and map follow the active branch', () {
      const Result<int> ok = Success(2);
      const Result<int> err = Err(Failure.network('offline'));

      expect(ok.map((v) => v * 10), const Success(20));
      expect(
        err.map((v) => v * 10),
        const Err<int>(Failure.network('offline')),
      );
      expect(ok.fold(onSuccess: (v) => 'v$v', onFailure: (_) => 'f'), 'v2');
      expect(
        err.fold(onSuccess: (v) => 'v$v', onFailure: (f) => f.message),
        'offline',
      );
    });
  });

  group('Failure.fromError', () {
    test('maps each AppException subtype', () {
      expect(
        Failure.fromError(const NetworkException('n')),
        isA<NetworkFailure>(),
      );
      expect(Failure.fromError(const AuthException('a')), isA<AuthFailure>());
      expect(
        Failure.fromError(const DataFormatException('d')),
        isA<DataFormatFailure>(),
      );
    });

    test('falls back to UnexpectedFailure', () {
      expect(Failure.fromError(StateError('boom')), isA<UnexpectedFailure>());
    });
  });
}
