import 'package:flutter/foundation.dart';

/// Application configuration.
class AppConfig {
  const AppConfig({
    required this.environment,
    required this.apiBaseUrl,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.enableAnalytics,
    required this.enableCrashReporting,
  });

  final Environment environment;
  final String apiBaseUrl;
  final String supabaseUrl;
  final String supabaseAnonKey;
  final bool enableAnalytics;
  final bool enableCrashReporting;

  /// Loads configuration based on environment.
  static Future<AppConfig> load() async {
    // TODO: Load from .env or flavor-specific configuration
    return const AppConfig(
      environment:
          kDebugMode ? Environment.development : Environment.production,
      apiBaseUrl: 'https://api.glow.dev',
      supabaseUrl: 'https://your-project.supabase.co',
      supabaseAnonKey: 'your-anon-key',
      enableAnalytics: !kDebugMode,
      enableCrashReporting: !kDebugMode,
    );
  }

  bool get isDevelopment => environment == Environment.development;
  bool get isProduction => environment == Environment.production;
}

/// Application environment.
enum Environment {
  development,
  staging,
  production,
}
