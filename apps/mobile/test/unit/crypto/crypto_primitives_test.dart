import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/crypto/application/encryption_service.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/aad_context.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/encrypted_payload.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';

void main() {
  group('Cryptographic Primitives SEC-004A', () {
    late EncryptionService encryptionService;
    late Uint8List testKeyBytes;

    setUp(() {
      encryptionService = const EncryptionService();
      // Generate a deterministic key for testing (32 bytes = 256 bit)
      testKeyBytes = Uint8List.fromList(List.generate(32, (i) => i));
    });

    final defaultAad = const AadContext(
      familyId: 'family_123',
      userId: 'user_456',
      deviceId: 'device_789',
      schemaVersion: '1.0',
      recordType: 'medical_log',
    );

    final defaultKeyId = const KeyIdentifier(
      id: 'key_abc',
      version: '1',
      algorithm: 'AES-256-GCM',
    );

    test('CRYPTO-001: Encrypt and decrypt payload perfectly matches original', () {
      const plaintext = 'Sensitive Medical Data';
      
      final encryptedPayload = encryptionService.encrypt(
        plaintext: plaintext,
        keyBytes: testKeyBytes,
        keyIdentifier: defaultKeyId,
        aad: defaultAad,
      );

      expect(encryptedPayload.ciphertextBase64, isNotEmpty);
      expect(encryptedPayload.ivBase64, isNotEmpty);
      expect(encryptedPayload.metadata.algorithm, 'AES-256-GCM');

      final decrypted = encryptionService.decrypt(
        payload: encryptedPayload,
        keyBytes: testKeyBytes,
        aad: defaultAad,
      );

      expect(decrypted, plaintext);
    });

    test('CRYPTO-004: Decrypt with exact AAD succeeds', () {
      final encryptedPayload = encryptionService.encrypt(
        plaintext: 'Test Data',
        keyBytes: testKeyBytes,
        keyIdentifier: defaultKeyId,
        aad: defaultAad,
      );

      final decrypted = encryptionService.decrypt(
        payload: encryptedPayload,
        keyBytes: testKeyBytes,
        aad: defaultAad,
      );
      expect(decrypted, 'Test Data');
    });

    test('CRYPTO-005: Decrypt with incorrect AAD fails (Bad Tag)', () {
      final encryptedPayload = encryptionService.encrypt(
        plaintext: 'Test Data',
        keyBytes: testKeyBytes,
        keyIdentifier: defaultKeyId,
        aad: defaultAad,
      );

      final maliciousAad = defaultAad.copyWith(familyId: 'family_HACKER');

      expect(
        () => encryptionService.decrypt(
          payload: encryptedPayload,
          keyBytes: testKeyBytes,
          aad: maliciousAad,
        ),
        throwsA(isA<CryptoDecryptionException>()),
      );
    });

    test('CRYPTO-006: Tampering with ciphertext fails decryption', () {
      final encryptedPayload = encryptionService.encrypt(
        plaintext: 'Test Data',
        keyBytes: testKeyBytes,
        keyIdentifier: defaultKeyId,
        aad: defaultAad,
      );

      // Modify the ciphertext
      final decodedCiphertext = base64Decode(encryptedPayload.ciphertextBase64);
      decodedCiphertext[0] = decodedCiphertext[0] ^ 0xFF; // Flip bits
      final tamperedCiphertextBase64 = base64Encode(decodedCiphertext);

      final tamperedPayload = encryptedPayload.copyWith(
        ciphertextBase64: tamperedCiphertextBase64,
      );

      expect(
        () => encryptionService.decrypt(
          payload: tamperedPayload,
          keyBytes: testKeyBytes,
          aad: defaultAad,
        ),
        throwsA(isA<CryptoDecryptionException>()),
      );
    });

    test('CRYPTO-007: Tampering with IV fails decryption', () {
      final encryptedPayload = encryptionService.encrypt(
        plaintext: 'Test Data',
        keyBytes: testKeyBytes,
        keyIdentifier: defaultKeyId,
        aad: defaultAad,
      );

      // Modify the IV
      final decodedIv = base64Decode(encryptedPayload.ivBase64);
      decodedIv[0] = decodedIv[0] ^ 0xFF;
      final tamperedIvBase64 = base64Encode(decodedIv);

      final tamperedPayload = encryptedPayload.copyWith(
        ivBase64: tamperedIvBase64,
      );

      expect(
        () => encryptionService.decrypt(
          payload: tamperedPayload,
          keyBytes: testKeyBytes,
          aad: defaultAad,
        ),
        throwsA(isA<CryptoDecryptionException>()),
      );
    });

    test('CRYPTO-015: Generated nonces are unique', () {
      final nonces = <String>{};
      for (var i = 0; i < 1000; i++) {
        final nonce = encryptionService.generateNonce();
        expect(nonces.contains(nonce), isFalse);
        nonces.add(nonce);
      }
    });

    test('CRYPTO-016: Metadata is correctly attached to payload', () {
      final payload = encryptionService.encrypt(
        plaintext: 'Data',
        keyBytes: testKeyBytes,
        keyIdentifier: defaultKeyId,
        aad: defaultAad,
      );

      expect(payload.metadata.keyId, defaultKeyId.id);
      expect(payload.metadata.keyVersion, defaultKeyId.version);
      expect(payload.metadata.aadVersion, '1.0');
      expect(payload.metadata.createdAtUtc, isNotNull);
    });
  });
}
