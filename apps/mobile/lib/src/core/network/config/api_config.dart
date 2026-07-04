import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  final String baseUrl;
  final Duration timeout;
  
  const ApiConfig({
    required this.baseUrl,
    required this.timeout,
  });

  factory ApiConfig.fromEnv() {
    return ApiConfig(
      baseUrl: dotenv.env['API_URL'] ?? 'https://api.lifecircle.os',
      timeout: const Duration(seconds: 30),
    );
  }
}
