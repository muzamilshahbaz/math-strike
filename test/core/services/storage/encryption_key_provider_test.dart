import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:math_strike/core/errors/app_exception.dart';
import 'package:math_strike/core/services/storage/encryption_key_provider.dart';
import 'package:mocktail/mocktail.dart';

class _MockSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late _MockSecureStorage storage;
  late Map<String, String> vault;

  setUp(() {
    storage = _MockSecureStorage();
    vault = {};
    when(() => storage.read(key: any(named: 'key')))
        .thenAnswer((i) async => vault[i.namedArguments[#key] as String]);
    when(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((i) async {
      vault[i.namedArguments[#key] as String] =
          i.namedArguments[#value] as String;
    });
  });

  test('generates a 256-bit key on first launch and reuses it', () async {
    final provider = SecureStorageEncryptionKeyProvider(storage);

    final first = await provider.obtainKey();
    final second = await provider.obtainKey();

    expect(first, hasLength(32));
    expect(second, first);
    verify(
      () => storage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).called(1);
  });

  test('wraps keystore errors in StorageException', () async {
    when(() => storage.read(key: any(named: 'key')))
        .thenThrow(Exception('keystore locked'));

    await expectLater(
      SecureStorageEncryptionKeyProvider(storage).obtainKey(),
      throwsA(isA<StorageException>()),
    );
  });
}
