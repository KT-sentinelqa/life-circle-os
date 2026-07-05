/// Represents a successful response from the API.
class ApiResponse<T> {
  /// Creates an [ApiResponse].
  const ApiResponse({
    required this.data,
    required this.statusCode,
  });

  /// The response payload.
  final T data;

  /// The HTTP status code.
  final int statusCode;
}
