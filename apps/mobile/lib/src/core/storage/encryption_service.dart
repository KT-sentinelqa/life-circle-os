import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for the [EncryptionService].
final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  throw UnimplementedError('encryptionServiceProvider must be overridden in ProviderScope with the initialized key.');
});

/// AES-256 encryption service.
class EncryptionService {
  EncryptionService(this._key);

  final Key _key;

  /// Encrypts the [plainText] using AES-256 and returns a Base64 string.
  /// Prepend the IV to the ciphertext so we can retrieve it for decryption.
  String encrypt(String plainText) {
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    final iv = IV.fromSecureRandom(16);
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  /// Decrypts the [encryptedText] back to plain text.
  String decrypt(String encryptedText) {
    final parts = encryptedText.split(':');
    if (parts.length != 2) {
      throw const FormatException('Invalid encrypted text format');
    }

    final iv = IV.fromBase64(parts[0]);
    final encrypted = Encrypted.fromBase64(parts[1]);
    
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    return encrypter.decrypt(encrypted, iv: iv);
  }
}
