import 'package:get_it/get_it.dart';
import 'package:glow_core/glow_core.dart';
import 'package:glow_observability/glow_observability.dart';

import '../config/app_config.dart';
import '../router/app_router.dart';

final getIt = GetIt.instance;

/// Configures all dependencies.
Future<void> configureDependencies(AppConfig config) async {
  // Register config
  getIt
    ..registerSingleton<AppConfig>(config)
    // Core services
    ..registerLazySingleton<Logger>(ConsoleLogger.new)
    // Auth
    // TODO: Register AuthRepository, AuthService, etc.
    // Router
    ..registerLazySingleton<AppRouter>(AppRouter.new);

  // TODO: Register feature-specific dependencies
}
