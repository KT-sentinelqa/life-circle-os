import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration for the API client.
class ApiConfig {
  /// Creates an [ApiConfig].
  const ApiConfig({
    required this.baseUrl,
    required this.timeout,
  });

  /// Creates an [ApiConfig] from environment variables.
  factory ApiConfig.fromEnv() {
    return ApiConfig(
      baseUrl: dotenv.env['API_URL'] ?? 'https://api.lifecircle.os',
      timeout: const Duration(seconds: 30),
    );
  }

  /// The base URL for the API.
  final String baseUrl;
  
  /// The timeout duration for requests.
  final Duration timeout;
}
