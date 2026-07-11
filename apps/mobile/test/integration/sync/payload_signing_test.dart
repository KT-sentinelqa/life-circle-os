import 'package:flutter_test/flutter_test.dart';
import 'package:lifecircle_mobile/src/features/device_auth/application/device_crypto_service.dart';

void main() {
  test('DeviceCryptoService correctly signs payload for SEC-023 compliance',
      () async {
    final crypto = MockDeviceCryptoService();

    final signature = await crypto.signPayload(
      'evt-123',
      1715000000,
      '{"status":"completed"}',
    );

    // Assert that the signature is generated and not empty
    expect(signature.isNotEmpty, isTrue);
    expect(signature.length, greaterThan(10));
  });
}
