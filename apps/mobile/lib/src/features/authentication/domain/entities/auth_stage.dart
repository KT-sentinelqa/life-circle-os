/// Represents the current stage of the user in the authentication pipeline.
enum AuthStage {
  /// The user has just registered or logged in but needs to verify OTP.
  awaitingOtp,
  
  /// The user has verified OTP and needs to configure 2FA.
  awaitingTwoFactor,

  /// The user has configured 2FA and needs to register the device.
  awaitingDeviceTrust,

  /// The user has registered the device and needs to set up biometrics.
  awaitingBiometrics,

  /// The user has set up biometrics and needs to save recovery codes.
  awaitingRecoveryCodes,

  /// The user has completed the authentication pipeline.
  completed,
}
