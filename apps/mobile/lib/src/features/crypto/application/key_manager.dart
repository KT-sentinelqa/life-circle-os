import 'dart:typed_data';

import 'package:lifecircle_mobile/src/features/crypto/domain/crypto_provider.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_capabilities.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_lifecycle_state.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_metadata.dart';

class KeyManagerResponse {
  const KeyManagerResponse({
    required this.material,
    required this.requiresMigration,
    required this.activeKeyId,
  });

  final Uint8List material;
  final bool requiresMigration;
  final KeyIdentifier activeKeyId;
}

class KeyManager {
  const KeyManager({
    required CryptoProvider provider,
  }) : _provider = provider;

  final CryptoProvider _provider;

  Future<KeyIdentifier> generateKey(KeyIdentifier identifier, KeyCapabilities capabilities, {String ownerId = 'system'}) async {
    final metadata = await _provider.generateKey(identifier, capabilities, ownerId);
    
    // Automatically provision and activate for this implementation
    await transitionState(identifier, KeyLifecycleState.provisioned);
    await transitionState(identifier, KeyLifecycleState.active);
    
    return identifier;
  }

  Future<KeyMetadata> getKeyMetadata(KeyIdentifier identifier) async {
    return _provider.getKeyMetadata(identifier);
  }

  Future<Uint8List> getKeyForOperation(KeyIdentifier identifier, KeyOperation operation) async {
    final metadata = await _provider.getKeyMetadata(identifier);

    if (metadata.state == KeyLifecycleState.destroyed || metadata.state == KeyLifecycleState.archived) {
      throw KeyNotFoundException();
    }

    if (operation == KeyOperation.encrypt || operation == KeyOperation.sign) {
      if (metadata.state != KeyLifecycleState.active) {
        throw KeyLifecycleException('Key must be active for encryption/signing. Current state: ${metadata.state}');
      }
    }

    if (operation == KeyOperation.decrypt || operation == KeyOperation.verify) {
      if (metadata.state != KeyLifecycleState.active && metadata.state != KeyLifecycleState.deprecated) {
        throw KeyLifecycleException('Key must be active or deprecated for decryption/verification. Current state: ${metadata.state}');
      }
    }

    return _provider.getKeyMaterial(identifier);
  }

  Future<KeyManagerResponse> getKeyForMigrationAwareOperation(KeyIdentifier requestedKeyId, KeyOperation operation) async {
    // 1. Resolve requested key for decryption
    final material = await getKeyForOperation(requestedKeyId, operation);
    
    // 2. Check if the key is deprecated. If so, find the active version.
    final metadata = await _provider.getKeyMetadata(requestedKeyId);
    
    if (metadata.state == KeyLifecycleState.deprecated) {
      // In a real system, we'd query the provider for the 'active' key in this family.
      // For this implementation, we assume the next integer version is the active one.
      final nextVersion = (int.parse(requestedKeyId.version) + 1).toString();
      final activeKeyId = KeyIdentifier(
        id: requestedKeyId.id,
        version: nextVersion,
        algorithm: requestedKeyId.algorithm,
      );

      return KeyManagerResponse(
        material: material,
        requiresMigration: true,
        activeKeyId: activeKeyId,
      );
    }

    return KeyManagerResponse(
      material: material,
      requiresMigration: false,
      activeKeyId: requestedKeyId,
    );
  }

  Future<void> transitionState(KeyIdentifier identifier, KeyLifecycleState newState) async {
    final metadata = await _provider.getKeyMetadata(identifier);
    final updated = metadata.copyWith(state: newState);
    await _provider.updateKeyMetadata(updated);
  }

  Future<void> destroyKey(KeyIdentifier identifier) async {
    await _provider.destroyKey(identifier);
  }

  Future<KeyIdentifier> rotateKey(KeyIdentifier currentIdentifier) async {
    // 1. Fetch current metadata
    final currentMetadata = await _provider.getKeyMetadata(currentIdentifier);
    
    // 2. Transition current to deprecated
    await transitionState(currentIdentifier, KeyLifecycleState.deprecated);

    // 3. Generate new key
    final nextVersion = (int.parse(currentIdentifier.version) + 1).toString();
    final nextIdentifier = KeyIdentifier(
      id: currentIdentifier.id,
      version: nextVersion,
      algorithm: currentIdentifier.algorithm,
    );

    await generateKey(nextIdentifier, currentMetadata.capabilities, ownerId: currentMetadata.ownerId);

    return nextIdentifier;
  }
}
