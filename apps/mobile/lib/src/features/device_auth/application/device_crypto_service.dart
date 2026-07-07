import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Abstract interface for generating asymmetric keys and signing payloads.
/// Conforms to SEC-023 (API Authentication & Mutual Trust).
abstract class DeviceCryptoService {
  /// Signs a sync payload string and returns a base64 encoded signature.
  Future<String> signPayload(String eventId, int logicalTimestamp, String payloadJson);
  
  /// Validates if the current device possesses the active private key.
  Future<bool> hasValidKeyPair();
}

/// Mock implementation for Phase 4.4B Integration Tests.
/// In production, this will interface with Android Keystore / iOS Secure Enclave.
class MockDeviceCryptoService implements DeviceCryptoService {
  @override
  Future<String> signPayload(String eventId, int logicalTimestamp, String payloadJson) async {
    // A simple HMAC simulation for testing purposes
    final data = utf8.encode('$eventId|$logicalTimestamp|$payloadJson');
    final hash = sha256.convert(data);
    return base64Encode(hash.bytes);
  }

  @override
  Future<bool> hasValidKeyPair() async => true;
}
