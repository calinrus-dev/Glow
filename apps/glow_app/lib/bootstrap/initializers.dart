import 'package:hive_flutter/hive_flutter.dart';

import '../config/app_config.dart';
import '../di/service_locator.dart';

/// Application initializers.
// ignore: avoid_classes_with_only_static_members
abstract final class Initializers {
  /// Initializes all required services.
  static Future<void> initialize(AppConfig config) async {
    await _initializeHive();
    await configureDependencies(config);
    await _initializeDatabase();
  }

  /// Initializes Hive storage.
  static Future<void> _initializeHive() async {
    await Hive.initFlutter();
    // TODO: Register adapters
  }

  /// Initializes local database.
  static Future<void> _initializeDatabase() async {
    // TODO: Initialize SQLite/Drift database
  }
}
