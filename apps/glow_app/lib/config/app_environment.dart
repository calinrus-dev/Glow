/// Application environment configuration.
enum AppEnvironment {
  dev,
  prod;

  bool get isDev => this == AppEnvironment.dev;
  bool get isProd => this == AppEnvironment.prod;
}

/// Current application environment.
class EnvironmentConfig {
  const EnvironmentConfig._({
    required this.environment,
  });

  final AppEnvironment environment;

  static EnvironmentConfig? _instance;

  static EnvironmentConfig get instance {
    assert(
      _instance != null,
      'EnvironmentConfig must be initialized before use',
    );
    return _instance!;
  }

  static void initialize(AppEnvironment environment) {
    _instance = EnvironmentConfig._(environment: environment);
  }
}
