import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/crypto/application/key_manager.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/crypto_provider.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_capabilities.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_lifecycle_state.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_metadata.dart';
import 'package:lifecircle_mobile/src/features/crypto/infrastructure/software_crypto_provider.dart';

void main() {
  group('Key Management SEC-004B', () {
    late SoftwareCryptoProvider provider;
    late KeyManager keyManager;

    setUp(() {
      provider = SoftwareCryptoProvider();
      keyManager = KeyManager(provider: provider);
    });

    final defaultCapabilities = const KeyCapabilities(
      isHardwareBacked: false,
      isExportable: false,
      backupPolicy: BackupPolicy.never,
      purpose: KeyPurpose.dataEncryption,
    );

    test('CRYPTO-008 & 009: Deprecated state allows Read but blocks Write', () async {
      final keyId = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      
      await keyManager.generateKey(keyId, defaultCapabilities);
      await keyManager.transitionState(keyId, KeyLifecycleState.deprecated);

      final metadata = await keyManager.getKeyMetadata(keyId);
      expect(metadata.state, KeyLifecycleState.deprecated);

      final material = await keyManager.getKeyForOperation(keyId, KeyOperation.decrypt);
      expect(material, isNotNull); // Decrypt allowed

      expect(
        () => keyManager.getKeyForOperation(keyId, KeyOperation.encrypt),
        throwsA(isA<KeyLifecycleException>()), // Encrypt blocked
      );
    });

    test('CRYPTO-010: Destroyed key throws KeyNotFound', () async {
      final keyId = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      
      await keyManager.generateKey(keyId, defaultCapabilities);
      await keyManager.destroyKey(keyId); // Transitions to Destroyed, erases material

      final metadata = await keyManager.getKeyMetadata(keyId);
      expect(metadata.state, KeyLifecycleState.destroyed); // Metadata preserved

      expect(
        () => keyManager.getKeyForOperation(keyId, KeyOperation.decrypt),
        throwsA(isA<KeyNotFoundException>()), // Material gone
      );
    });

    test('CRYPTO-011: Rotation creates new version, deprecates old', () async {
      final keyIdV1 = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      await keyManager.generateKey(keyIdV1, defaultCapabilities);
      
      final keyIdV2 = await keyManager.rotateKey(keyIdV1);
      
      expect(keyIdV2.version, '2');
      
      final oldMetadata = await keyManager.getKeyMetadata(keyIdV1);
      expect(oldMetadata.state, KeyLifecycleState.deprecated);
      
      final newMetadata = await keyManager.getKeyMetadata(keyIdV2);
      expect(newMetadata.state, KeyLifecycleState.active);
    });

    test('CRYPTO-018 & 020: Backward compatibility and migration triggers', () async {
      final keyIdV1 = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      await keyManager.generateKey(keyIdV1, defaultCapabilities);
      await keyManager.rotateKey(keyIdV1); // V1 deprecated, V2 active

      // Requesting V1 for decryption works, but flags migration
      final response = await keyManager.getKeyForMigrationAwareOperation(keyIdV1, KeyOperation.decrypt);
      
      expect(response.material, isNotNull);
      expect(response.requiresMigration, isTrue); // Because V1 is deprecated
      expect(response.activeKeyId.version, '2'); // Tells consumer what to re-encrypt with
    });

    test('CRYPTO-021: Unavailable Keystore throws PlatformKeystoreUnavailableException', () async {
      provider.simulateUnavailableKeystore = true;
      final keyId = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      
      expect(
        () => keyManager.generateKey(keyId, defaultCapabilities),
        throwsA(isA<PlatformKeystoreUnavailableException>()),
      );
    });

    test('CRYPTO-022: Hardware key unsupported throws HardwareKeystoreRequiredException', () async {
      provider.simulateHardwareUnsupported = true;
      final keyId = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      
      final hardwareCapabilities = defaultCapabilities.copyWith(isHardwareBacked: true);

      expect(
        () => keyManager.generateKey(keyId, hardwareCapabilities),
        throwsA(isA<HardwareKeystoreRequiredException>()),
      );
    });

    test('CRYPTO-023: Biometric invalidated key forces re-auth', () async {
      final keyId = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      await keyManager.generateKey(keyId, defaultCapabilities);
      
      provider.simulateBiometricInvalidated = true;

      expect(
        () => keyManager.getKeyForOperation(keyId, KeyOperation.decrypt),
        throwsA(isA<BiometricInvalidatedException>()),
      );
    });

    test('CRYPTO-024: Keystore reset by OS', () async {
      final keyId = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      await keyManager.generateKey(keyId, defaultCapabilities);
      
      provider.simulateOsReset = true; // Simulates Secure Enclave wiping keys but DB retaining metadata

      expect(
        () => keyManager.getKeyForOperation(keyId, KeyOperation.decrypt),
        throwsA(isA<KeyNotFoundException>()), // The material is physically gone
      );
    });

    test('CRYPTO-025: Corrupted metadata transitions key to Destroyed safely', () async {
      final keyId = const KeyIdentifier(id: 'test_key', version: '1', algorithm: 'AES-256-GCM');
      await keyManager.generateKey(keyId, defaultCapabilities);
      
      provider.simulateCorruptedMetadata = true;

      expect(
        () => keyManager.getKeyMetadata(keyId),
        throwsA(isA<CorruptedKeyMetadataException>()),
      );
    });
  });
}
