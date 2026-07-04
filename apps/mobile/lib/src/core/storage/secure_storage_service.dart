import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the [SecureStorageService].
final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(const FlutterSecureStorage());
});

/// Service to manage securely stored keys and tokens.
class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;
  static const _encryptionKeyKey = 'life_circle_encryption_key';

  /// Retrieves the existing AES-256 key, or creates and stores a new one.
  Future<Key> getOrCreateEncryptionKey() async {
    final existingKeyBase64 = await _storage.read(key: _encryptionKeyKey);
    if (existingKeyBase64 != null) {
      return Key.fromBase64(existingKeyBase64);
    }

    // Create a new 256-bit (32 bytes) key
    final newKey = Key.fromSecureRandom(32);
    await _storage.write(key: _encryptionKeyKey, value: newKey.base64);
    
    return newKey;
  }

  /// Writes a value to secure storage.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a value from secure storage.
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  /// Deletes a value from secure storage.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
