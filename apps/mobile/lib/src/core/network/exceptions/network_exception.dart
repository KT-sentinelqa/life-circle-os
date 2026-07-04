abstract class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException(this.message, {this.statusCode});

  @override
  String toString() => '$runtimeType: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
