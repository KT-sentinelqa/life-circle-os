abstract class LifeCircleException implements Exception {
  const LifeCircleException(this.message);
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

class AuthorizationException extends LifeCircleException {
  const AuthorizationException([super.message = 'Not authorized to perform this action.']);
}

class ValidationException extends LifeCircleException {
  const ValidationException(super.message);
}

class SyncException extends LifeCircleException {
  const SyncException([super.message = 'Failed to synchronize with the platform.']);
}

class ConflictException extends LifeCircleException {
  const ConflictException([super.message = 'A data conflict occurred.']);
}

class NetworkException extends LifeCircleException {
  const NetworkException([super.message = 'Network connectivity is unavailable.']);
}

class OfflineException extends LifeCircleException {
  const OfflineException([super.message = 'This action cannot be performed while offline.']);
}
