import 'dart:math';
import 'dart:typed_data';
import 'package:lifecircle_mobile/src/features/crypto/domain/crypto_provider.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_capabilities.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_lifecycle_state.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_metadata.dart';

/// A software-backed provider for deterministic testing and SEC-004B isolation.
/// In SEC-004C, this is joined by AppleKeychainProvider and AndroidKeystoreProvider.
class SoftwareCryptoProvider implements CryptoProvider {
  final Map<String, Uint8List> _materialStore = {};
  final Map<String, KeyMetadata> _metadataStore = {};

  // Testing flags
  bool simulateUnavailableKeystore = false;
  bool simulateHardwareUnsupported = false;
  bool simulateBiometricInvalidated = false;
  bool simulateOsReset = false;
  bool simulateCorruptedMetadata = false;

  @override
  Future<KeyMetadata> generateKey(KeyIdentifier identifier, KeyCapabilities capabilities, String ownerId) async {
    if (simulateUnavailableKeystore) throw PlatformKeystoreUnavailableException();
    if (simulateHardwareUnsupported && capabilities.isHardwareBacked) throw HardwareKeystoreRequiredException();

    final keyIdString = '${identifier.id}_${identifier.version}';

    // Generate 32 bytes (256-bit) via CSPRNG
    final random = Random.secure();
    final material = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      material[i] = random.nextInt(256);
    }

    final metadata = KeyMetadata(
      identifier: identifier,
      state: KeyLifecycleState.generated,
      capabilities: capabilities,
      ownerId: ownerId,
      rotationPolicy: const Duration(days: 365), // Default
      createdAtUtc: DateTime.now().toUtc(),
    );

    _materialStore[keyIdString] = material;
    _metadataStore[keyIdString] = metadata;

    return metadata;
  }

  @override
  Future<KeyMetadata> getKeyMetadata(KeyIdentifier identifier) async {
    if (simulateCorruptedMetadata) throw CorruptedKeyMetadataException();

    final keyIdString = '${identifier.id}_${identifier.version}';
    final metadata = _metadataStore[keyIdString];
    
    if (metadata == null) throw KeyNotFoundException();
    return metadata;
  }

  @override
  Future<Uint8List> getKeyMaterial(KeyIdentifier identifier) async {
    if (simulateBiometricInvalidated) throw BiometricInvalidatedException();
    if (simulateOsReset) throw KeyNotFoundException(); // Material wiped by OS

    final keyIdString = '${identifier.id}_${identifier.version}';
    final material = _materialStore[keyIdString];
    
    if (material == null) throw KeyNotFoundException();
    return material;
  }

  @override
  Future<void> updateKeyMetadata(KeyMetadata metadata) async {
    final keyIdString = '${metadata.identifier.id}_${metadata.identifier.version}';
    _metadataStore[keyIdString] = metadata;
  }

  @override
  Future<void> destroyKey(KeyIdentifier identifier) async {
    final keyIdString = '${identifier.id}_${identifier.version}';
    
    // Cryptographically erase the material
    if (_materialStore.containsKey(keyIdString)) {
      final material = _materialStore[keyIdString]!;
      for (var i = 0; i < material.length; i++) {
        material[i] = 0; // Zeroize
      }
      _materialStore.remove(keyIdString);
    }

    // Update metadata state to destroyed
    if (_metadataStore.containsKey(keyIdString)) {
      final current = _metadataStore[keyIdString]!;
      _metadataStore[keyIdString] = current.copyWith(state: KeyLifecycleState.destroyed);
    }
  }
}
