import 'package:lifecircle_mobile/src/features/device_trust/domain/device_trust.dart';

/// Interface for native biometric authentication (FaceID, TouchID, Android Biometrics).
abstract class BiometricService {
  /// Checks if biometrics are enrolled and available on the device.
  Future<bool> isBiometricAvailable();

  /// Prompts the user to authenticate using biometrics.
  Future<BiometricState> authenticate({required String localizedReason});

  /// Retrieves the current state of biometrics without prompting the user.
  Future<BiometricState> getBiometricState();
}
