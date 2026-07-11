import 'package:lifecircle_mobile/src/features/authentication/domain/entities/user.dart';

/// Abstract contract for authentication data operations.
abstract class AuthRepository {
  /// Requests an OTP to be sent to the given [identifier] (email or phone).
  Future<void> requestOtp({required String identifier});

  /// Verifies the OTP and advances to the next auth stage.
  Future<User> verifyOtp({
    required String identifier,
    required String otp,
  });

  /// Configures two-factor authentication and advances to the next auth stage.
  Future<User> setupTwoFactor({required String method});

  /// Registers the current device as trusted and advances to the next auth stage.
  Future<User> registerDevice({required String deviceName});

  /// Configures biometric unlock and advances to the next auth stage.
  Future<User> setupBiometric();

  /// Completes the authentication pipeline.
  Future<User> completeAuthPipeline();

  /// Creates a new family for the active user.
  Future<User> createFamily({required String familyName});


  /// Logs the user out and clears the session.
  Future<void> logout();

  /// Checks if a valid session exists and returns the associated [User].
  Future<User?> checkSession();
}
