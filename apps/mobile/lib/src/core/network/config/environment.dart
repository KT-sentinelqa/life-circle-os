/// Represents the execution environment.
enum Environment {
  /// Development environment.
  dev,
  
  /// Staging environment.
  staging,
  
  /// Production environment.
  prod,
}

/// Extension on [Environment] to retrieve environment-specific properties.
extension EnvironmentExtension on Environment {
  /// Returns the environment variable file name associated with
  /// the environment.
  String get fileName {
    switch (this) {
      case Environment.dev:
        return '.env.dev';
      case Environment.staging:
        return '.env.staging';
      case Environment.prod:
        return '.env.prod';
    }
  }
}
