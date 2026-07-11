/// Identifies a specific cryptographic key in the platform hierarchy.
class KeyIdentifier {
  const KeyIdentifier({
    required this.id,
    required this.version,
    required this.algorithm,
  });

  /// The unique identifier of the key (e.g., 'family_domain_kek').
  final String id;

  /// The version of the key used for deterministic rotation.
  final String version;

  /// The algorithm used by this key (e.g., 'AES-256-GCM').
  final String algorithm;
}
