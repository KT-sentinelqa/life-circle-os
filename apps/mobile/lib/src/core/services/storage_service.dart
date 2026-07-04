import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Secure storage abstraction for persisting sensitive data.
///
/// Uses encrypted shared preferences on Android and keychain on iOS.
class StorageService {
  /// Creates a new [StorageService] instance.
  StorageService(this._storage);

  final FlutterSecureStorage _storage;

  /// Writes a secure [value] for the given [key].
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a secure value for the given [key].
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  /// Deletes the secure value for the given [key].
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}

/// Provider exposing the [StorageService] instance.
final storageServiceProvider = Provider<StorageService>((ref) {
  const storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  return StorageService(storage);
});
