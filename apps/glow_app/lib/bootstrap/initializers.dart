import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/app_config.dart';
import '../di/service_locator.dart';

/// Application initializers.
// ignore: avoid_classes_with_only_static_members
abstract final class Initializers {
  /// Initializes all required services.
  static Future<void> initialize(AppConfig config) async {
    await _initializeSupabase();
    await configureDependencies(config);
  }

  /// Initializes Supabase.
  static Future<void> _initializeSupabase() async {
    // TODO: Get these from environment variables
    await Supabase.initialize(
      url: 'YOUR_SUPABASE_URL',
      anonKey: 'YOUR_SUPABASE_ANON_KEY',
    );
  }
}
