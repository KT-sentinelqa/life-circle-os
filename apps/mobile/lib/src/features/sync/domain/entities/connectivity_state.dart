/// Represents the network connectivity status of the device.
enum ConnectivityState {
  /// Connected to the internet.
  online,

  /// Completely disconnected.
  offline,

  /// Connected to a network with no internet access.
  limited,

  /// State cannot be determined.
  unknown,
}
