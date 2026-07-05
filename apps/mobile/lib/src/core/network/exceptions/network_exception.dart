/// Base exception for all network-related errors.
abstract class NetworkException implements Exception {
  /// Creates a [NetworkException].
  const NetworkException(this.message, {this.statusCode});

  /// The error message.
  final String message;

  /// The optional HTTP status code.
  final int? statusCode;

  @override
  String toString() {
    return '$runtimeType: $message'
        '${statusCode != null ? ' (Status: $statusCode)' : ''}';
  }
}
