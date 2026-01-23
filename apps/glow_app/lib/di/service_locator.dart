import 'package:get_it/get_it.dart';
import 'package:glow_core/glow_core.dart';
import 'package:glow_observability/glow_observability.dart';

import '../config/app_config.dart';

final getIt = GetIt.instance;

/// Configures all dependencies.
Future<void> configureDependencies(AppConfig config) async {
  // Register config
  getIt
    ..registerSingleton<AppConfig>(config)
    // Core services
    ..registerLazySingleton<Logger>(ConsoleLogger.new);
}
