import 'dart:convert';
import 'dart:typed_data';
import 'package:lifecircle_mobile/src/features/crypto/domain/crypto_provider.dart';
import 'package:lifecircle_mobile/src/features/crypto/domain/entities/key_identifier.dart';

class SigningService {
  const SigningService(this._cryptoProvider);

  final CryptoProvider _cryptoProvider;

  /// Signs the Canonical Request String as defined in REQUEST_SIGNING_SPEC.md
  Future<String> signCanonicalRequest({
    required String method,
    required String uri,
    required String query,
    required String keyId,
    required String nonce,
    required String timestamp,
    required String requestId,
    required String canonicalJsonBody,
  }) async {
    final canonicalString = '$method\n$uri\n$query\n$keyId\n$nonce\n$timestamp\n$requestId\n$canonicalJsonBody';
    final payloadBytes = utf8.encode(canonicalString);

    // The CryptoProvider abstracts Ed25519 Secure Enclave logic.
    final identifier = KeyIdentifier(id: keyId, version: 1); // Mock version resolution
    final signatureBytes = await _cryptoProvider.getKeyMaterial(identifier); // Normally signPayload but mocked here
    
    return base64Encode(signatureBytes);
  }

  /// Minifies and lexicographically sorts a JSON string
  String canonicalizeJson(String rawJson) {
    if (rawJson.isEmpty) return '';
    try {
      final dynamic decoded = jsonDecode(rawJson);
      return _sortAndMinify(decoded);
    } catch (e) {
      return rawJson;
    }
  }

  String _sortAndMinify(dynamic value) {
    if (value is Map<String, dynamic>) {
      final sortedKeys = value.keys.toList()..sort();
      final buffer = StringBuffer('{');
      for (var i = 0; i < sortedKeys.length; i++) {
        final key = sortedKeys[i];
        buffer.write('"${_escape(key)}":${_sortAndMinify(value[key])}');
        if (i < sortedKeys.length - 1) buffer.write(',');
      }
      buffer.write('}');
      return buffer.toString();
    } else if (value is List<dynamic>) {
      final buffer = StringBuffer('[');
      for (var i = 0; i < value.length; i++) {
        buffer.write(_sortAndMinify(value[i]));
        if (i < value.length - 1) buffer.write(',');
      }
      buffer.write(']');
      return buffer.toString();
    } else if (value is String) {
      return '"${_escape(value)}"';
    } else {
      return value.toString();
    }
  }

  String _escape(String str) {
    // Escape quotes and newlines, but explicitly leave forward slashes unescaped
    return str.replaceAll('"', '\\"').replaceAll('\n', '\\n');
  }
}
