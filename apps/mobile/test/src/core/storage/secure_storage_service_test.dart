import 'package:encrypt/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/core/storage/secure_storage_service.dart';

class FakeSecureStorageService implements SecureStorageService {
  final Map<String, String> _storage = {};

  @override
  Future<Key> getOrCreateEncryptionKey() async {
    final existingKeyBase64 = _storage['life_circle_encryption_key'];
    if (existingKeyBase64 != null) {
      return Key.fromBase64(existingKeyBase64);
    }

    final newKey = Key.fromSecureRandom(32);
    _storage['life_circle_encryption_key'] = newKey.base64;
    return newKey;
  }

  @override
  Future<void> write(String key, String value) async {
    _storage[key] = value;
  }

  @override
  Future<String?> read(String key) async {
    return _storage[key];
  }

  @override
  Future<void> delete(String key) async {
    _storage.remove(key);
  }
}

void main() {
  group('FakeSecureStorageService', () {
    late FakeSecureStorageService fakeStorage;

    setUp(() {
      fakeStorage = FakeSecureStorageService();
    });

    test('getOrCreateEncryptionKey creates and stores new key if missing', () async {
      final key = await fakeStorage.getOrCreateEncryptionKey();
      expect(key.bytes.length, equals(32));
      
      final storedKey = await fakeStorage.read('life_circle_encryption_key');
      expect(storedKey, equals(key.base64));
    });

    test('getOrCreateEncryptionKey returns existing key if present', () async {
      final key1 = await fakeStorage.getOrCreateEncryptionKey();
      final key2 = await fakeStorage.getOrCreateEncryptionKey();
      
      expect(key1.base64, equals(key2.base64));
    });
  });
}
