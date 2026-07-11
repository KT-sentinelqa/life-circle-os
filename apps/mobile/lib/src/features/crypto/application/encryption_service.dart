import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/aad_context.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/encrypted_payload.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';

class CryptoDecryptionException implements Exception {
  CryptoDecryptionException(this.message);
  final String message;

  @override
  String toString() => 'CryptoDecryptionException: $message';
}

/// Provides deterministic cryptographic primitives for LifeCircle OS.
/// Does not manage key storage (handled by KeyManagement layer).
class EncryptionService {
  const EncryptionService();

  /// Encrypts a [plaintext] string using AES-256-GCM.
  /// Binds the [aad] to the ciphertext to prevent lateral movement.
  EncryptedPayload encrypt({
    required String plaintext,
    required Uint8List keyBytes,
    required KeyIdentifier keyIdentifier,
    required AadContext aad,
  }) {
    if (keyBytes.length != 32) {
      throw ArgumentError('AES-256 requires a 32-byte key.');
    }

    final key = Key(keyBytes);
    final iv = _generateSecureIv();
    
    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));
    
    final encrypted = encrypter.encrypt(
      plaintext,
      iv: iv,
      associatedData: aad.toBytes(),
    );

    final metadata = CryptoMetadata(
      algorithm: keyIdentifier.algorithm,
      keyVersion: keyIdentifier.version,
      keyId: keyIdentifier.id,
      createdAtUtc: DateTime.now().toUtc(),
      rotationVersion: '1',
      aadVersion: '1.0',
    );

    return EncryptedPayload(
      ciphertextBase64: encrypted.base64,
      ivBase64: iv.base64,
      metadata: metadata,
    );
  }

  /// Decrypts an [EncryptedPayload] and authenticates the [aad].
  /// Throws [CryptoDecryptionException] if the tag or AAD is invalid.
  String decrypt({
    required EncryptedPayload payload,
    required Uint8List keyBytes,
    required AadContext aad,
  }) {
    if (keyBytes.length != 32) {
      throw ArgumentError('AES-256 requires a 32-byte key.');
    }

    final key = Key(keyBytes);
    final iv = IV.fromBase64(payload.ivBase64);
    final encrypted = Encrypted.fromBase64(payload.ciphertextBase64);

    final encrypter = Encrypter(AES(key, mode: AESMode.gcm));

    try {
      final decrypted = encrypter.decrypt(
        encrypted,
        iv: iv,
        associatedData: aad.toBytes(),
      );
      return decrypted;
    } catch (e) {
      // The encrypt package throws state errors on MAC mismatch.
      throw CryptoDecryptionException('Failed to decrypt payload or AAD mismatch. Original error: $e');
    }
  }

  /// Generates a cryptographically secure 12-byte IV for AES-GCM.
  IV _generateSecureIv() {
    final random = Random.secure();
    final bytes = Uint8List(12); // GCM standard IV length is 96 bits (12 bytes)
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return IV(bytes);
  }

  /// Generates a cryptographically secure Base64 nonce.
  String generateNonce({int lengthInBytes = 32}) {
    final random = Random.secure();
    final bytes = Uint8List(lengthInBytes);
    for (var i = 0; i < bytes.length; i++) {
      bytes[i] = random.nextInt(256);
    }
    return base64Encode(bytes);
  }
}
