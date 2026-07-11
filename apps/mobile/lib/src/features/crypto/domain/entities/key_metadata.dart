import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_capabilities.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_lifecycle_state.dart';

class KeyMetadata {
  const KeyMetadata({
    required this.identifier,
    required this.state,
    required this.capabilities,
    required this.ownerId,
    required this.rotationPolicy,
    required this.createdAtUtc,
    this.expiryTimeUtc,
  });

  final KeyIdentifier identifier;
  final KeyLifecycleState state;
  final KeyCapabilities capabilities;
  final String ownerId; // Which Domain or User owns this key
  final Duration rotationPolicy;
  final DateTime createdAtUtc;
  final DateTime? expiryTimeUtc;

  KeyMetadata copyWith({
    KeyIdentifier? identifier,
    KeyLifecycleState? state,
    KeyCapabilities? capabilities,
    String? ownerId,
    Duration? rotationPolicy,
    DateTime? createdAtUtc,
    DateTime? expiryTimeUtc,
  }) {
    return KeyMetadata(
      identifier: identifier ?? this.identifier,
      state: state ?? this.state,
      capabilities: capabilities ?? this.capabilities,
      ownerId: ownerId ?? this.ownerId,
      rotationPolicy: rotationPolicy ?? this.rotationPolicy,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      expiryTimeUtc: expiryTimeUtc ?? this.expiryTimeUtc,
    );
  }
}
