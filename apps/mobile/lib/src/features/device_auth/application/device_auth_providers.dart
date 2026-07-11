import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lifecircle_mobile/src/features/device_auth/application/device_crypto_service.dart';

final deviceCryptoServiceProvider = Provider<DeviceCryptoService>((ref) {
  // Returns the mock implementation for now until real hardware integration
  return MockDeviceCryptoService();
});
