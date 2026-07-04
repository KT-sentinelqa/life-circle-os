/// Represents an error returned by the API.
class ApiError {
  /// Creates an [ApiError].
  const ApiError({
    required this.code,
    required this.message,
    this.details,
  });

  /// Creates an [ApiError] from JSON.
  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      code: json['code'] as String? ?? 'unknown',
      message: json['message'] as String? ?? 'An unknown error occurred',
      details: json['details'] as Map<String, dynamic>?,
    );
  }

  /// The error code.
  final String code;
  /// The error message.
  final String message;
  /// Additional error details.
  final Map<String, dynamic>? details;
}
