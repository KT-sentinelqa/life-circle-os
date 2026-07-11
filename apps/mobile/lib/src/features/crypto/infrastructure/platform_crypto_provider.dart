import 'dart:typed_data';

import 'package:lifecircle_mobile/src/features/crypto/domain/crypto_provider.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_capabilities.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_lifecycle_state.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_metadata.dart';
import 'package:lifecircle_mobile/src/features/crypto/infrastructure/pigeon/crypto_api.g.dart';

class CryptoCapabilities {
  CryptoCapabilities({
    required this.supportsSecureEnclave,
    required this.supportsStrongBox,
    required this.supportsHardwareKeys,
    required this.supportsBiometrics,
    required this.supportsAttestation,
    required this.supportsKeyWrapping,
  });

  final bool supportsSecureEnclave;
  final bool supportsStrongBox;
  final bool supportsHardwareKeys;
  final bool supportsBiometrics;
  final bool supportsAttestation;
  final bool supportsKeyWrapping;
}

class PlatformCryptoProvider implements CryptoProvider {
  PlatformCryptoProvider({NativeCryptoApi? api}) : _api = api ?? NativeCryptoApi();

  final NativeCryptoApi _api;
  final Map<String, KeyMetadata> _localMetadataStore = {};

  Future<CryptoCapabilities> getCapabilities() async {
    try {
      final pigeonCaps = await _api.getCapabilities();
      return CryptoCapabilities(
        supportsSecureEnclave: pigeonCaps.supportsSecureEnclave,
        supportsStrongBox: pigeonCaps.supportsStrongBox,
        supportsHardwareKeys: pigeonCaps.supportsHardwareKeys,
        supportsBiometrics: pigeonCaps.supportsBiometrics,
        supportsAttestation: pigeonCaps.supportsAttestation,
        supportsKeyWrapping: pigeonCaps.supportsKeyWrapping,
      );
    } catch (e) {
      // Telemetry: Log platform capability failure
      throw PlatformKeystoreUnavailableException();
    }
  }

  @override
  Future<KeyMetadata> generateKey(KeyIdentifier identifier, KeyCapabilities capabilities, String ownerId) async {
    final keyIdString = '${identifier.id}_${identifier.version}';
    final requiresHardware = capabilities.isHardwareBacked;
    final requiresBiometrics = capabilities.purpose == KeyPurpose.digitalSignature; // Example rule

    try {
      final nativeMeta = await _api.generateKey(keyIdString, requiresHardware, requiresBiometrics);

      final metadata = KeyMetadata(
        identifier: identifier,
        state: KeyLifecycleState.generated,
        capabilities: capabilities.copyWith(isHardwareBacked: nativeMeta.isHardwareBacked),
        ownerId: ownerId,
        rotationPolicy: const Duration(days: 365),
        createdAtUtc: DateTime.now().toUtc(),
      );

      _localMetadataStore[keyIdString] = metadata;
      return metadata;
    } catch (e) {
      if (e.toString().contains('hardware-unsupported')) {
        throw HardwareKeystoreRequiredException();
      }
      throw PlatformKeystoreUnavailableException();
    }
  }

  @override
  Future<void> destroyKey(KeyIdentifier identifier) async {
    final keyIdString = '${identifier.id}_${identifier.version}';
    try {
      await _api.destroyKey(keyIdString);
      if (_localMetadataStore.containsKey(keyIdString)) {
        final current = _localMetadataStore[keyIdString]!;
        _localMetadataStore[keyIdString] = current.copyWith(state: KeyLifecycleState.destroyed);
      }
    } catch (e) {
      throw KeyNotFoundException();
    }
  }

  @override
  Future<Uint8List> getKeyMaterial(KeyIdentifier identifier) async {
    // Platform keys usually never export material. 
    // Data DEKs are wrapped, so we must unwrap them via the hardware enclave.
    // For pure software DEKs that were wrapped, we would pass them to NativeCryptoApi.unwrapKey.
    throw UnsupportedError('PlatformCryptoProvider does not export hardware key material. Use hardware-backed signing/wrapping.');
  }

  @override
  Future<KeyMetadata> getKeyMetadata(KeyIdentifier identifier) async {
    final keyIdString = '${identifier.id}_${identifier.version}';
    final metadata = _localMetadataStore[keyIdString];
    if (metadata == null) throw KeyNotFoundException();
    return metadata;
  }

  @override
  Future<void> updateKeyMetadata(KeyMetadata metadata) async {
    final keyIdString = '${metadata.identifier.id}_${metadata.identifier.version}';
    _localMetadataStore[keyIdString] = metadata;
  }

  /// Requests a cryptographic attestation object from the OS.
  Future<Uint8List> requestAttestation(KeyIdentifier identifier, Uint8List challenge) async {
    final keyIdString = '${identifier.id}_${identifier.version}';
    try {
      return await _api.requestAttestation(keyIdString, challenge);
    } catch (e) {
      throw PlatformKeystoreUnavailableException();
    }
  }
}
