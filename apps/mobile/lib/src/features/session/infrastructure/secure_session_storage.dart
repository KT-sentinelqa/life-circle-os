import 'dart:convert';
import 'dart:typed_data';
import 'package:lifecircle_mobile/src/features/crypto/application/encryption_service.dart';

class SecureSessionStorage {
  const SecureSessionStorage(this._encryptionService);

  final EncryptionService _encryptionService;
  
  // In a real app, you would use shared_preferences or a flutter_secure_storage
  // to hold the encrypted blob. For demonstration, we'll assume a mocked persistence layer.
  static Uint8List? _persistedBlob;

  /// Stores the refresh token by encrypting it first
  Future<void> storeRefreshToken(String token, String deviceId, String familyId) async {
    final payloadBytes = utf8.encode(token);
    final encrypted = await _encryptionService.encrypt(
      payload: payloadBytes,
      metadata: EncryptionMetadata(
        schemaVersion: '1.0',
        recordType: 'RefreshToken',
        deviceId: deviceId,
        familyId: familyId,
        userId: 'session_root',
      ),
    );
    // Persist ciphertext and nonce
    _persistedBlob = encrypted.ciphertext; 
  }

  /// Retrieves and decrypts the refresh token
  Future<String?> retrieveRefreshToken(String deviceId, String familyId) async {
    if (_persistedBlob == null) return null;
    
    try {
      final decryptedBytes = await _encryptionService.decrypt(
        ciphertext: _persistedBlob!,
        metadata: EncryptionMetadata(
          schemaVersion: '1.0',
          recordType: 'RefreshToken',
          deviceId: deviceId,
          familyId: familyId,
          userId: 'session_root',
        ),
      );
      return utf8.decode(decryptedBytes);
    } catch (e) {
      // If decryption fails (e.g. AAD binding invalid), token is unrecoverable
      return null;
    }
  }

  /// Purges the refresh token on logout or revocation
  Future<void> clear() async {
    _persistedBlob = null;
  }
}
