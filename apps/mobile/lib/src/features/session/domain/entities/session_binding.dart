import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

@immutable
class SessionBinding {
  const SessionBinding({
    required this.deviceId,
    required this.attestationId,
    required this.keyIdentifier,
    required this.trustEvidenceId,
    required this.bindingHash,
  });

  final String deviceId;
  final String attestationId;
  final String keyIdentifier;
  final String trustEvidenceId;
  
  /// SHA-256(sessionId + deviceId + attestationId + keyIdentifier)
  final String bindingHash;

  /// Verifies if the binding is still valid for a given session ID
  bool isValid(String sessionId) {
    final rawString = '$sessionId$deviceId$attestationId$keyIdentifier';
    final bytes = utf8.encode(rawString);
    final digest = sha256.convert(bytes);
    return digest.toString() == bindingHash;
  }
}
