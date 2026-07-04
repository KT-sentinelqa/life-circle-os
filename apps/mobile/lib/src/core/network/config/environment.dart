enum Environment {
  dev,
  staging,
  prod,
}

extension EnvironmentExtension on Environment {
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
