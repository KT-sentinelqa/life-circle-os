/// Abstract interface for managing OS-level notification permissions.
abstract interface class NotificationPermissionService {
  /// Requests required notification and alarm permissions from the OS.
  /// Returns true if permissions were granted.
  Future<bool> requestPermissions();

  /// Checks if the application currently has notification permissions.
  Future<bool> checkPermissions();
}
