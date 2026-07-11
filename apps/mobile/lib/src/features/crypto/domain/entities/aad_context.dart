import 'dart:convert';
import 'dart:typed_data';

/// Represents Authenticated Additional Data (AAD) bound to a ciphertext.
class AadContext {
  const AadContext({
    required this.familyId,
    required this.userId,
    required this.deviceId,
    required this.schemaVersion,
    required this.recordType,
  });

  final String familyId;
  final String userId;
  final String deviceId;
  final String schemaVersion;
  final String recordType;

  /// Serializes the AAD into a deterministic byte array for AES-GCM tag computation.
  Uint8List toBytes() {
    // Deterministic ordering is critical.
    final payload = '$familyId|$userId|$deviceId|$schemaVersion|$recordType';
    return Uint8List.fromList(utf8.encode(payload));
  }

  AadContext copyWith({
    String? familyId,
    String? userId,
    String? deviceId,
    String? schemaVersion,
    String? recordType,
  }) {
    return AadContext(
      familyId: familyId ?? this.familyId,
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      schemaVersion: schemaVersion ?? this.schemaVersion,
      recordType: recordType ?? this.recordType,
    );
  }
}
