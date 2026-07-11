class CryptoMetadata {
  const CryptoMetadata({
    required this.algorithm,
    required this.keyVersion,
    required this.keyId,
    required this.createdAtUtc,
    required this.rotationVersion,
    required this.aadVersion,
  });

  final String algorithm;
  final String keyVersion;
  final String keyId;
  final DateTime createdAtUtc;
  final String rotationVersion;
  final String aadVersion;
}

class EncryptedPayload {
  const EncryptedPayload({
    required this.ciphertextBase64,
    required this.ivBase64,
    required this.metadata,
  });

  final String ciphertextBase64;
  final String ivBase64;
  final CryptoMetadata metadata;

  EncryptedPayload copyWith({
    String? ciphertextBase64,
    String? ivBase64,
    CryptoMetadata? metadata,
  }) {
    return EncryptedPayload(
      ciphertextBase64: ciphertextBase64 ?? this.ciphertextBase64,
      ivBase64: ivBase64 ?? this.ivBase64,
      metadata: metadata ?? this.metadata,
    );
  }
}
