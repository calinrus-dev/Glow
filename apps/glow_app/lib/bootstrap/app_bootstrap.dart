import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glow_core/glow_core.dart';
import 'package:glow_observability/glow_observability.dart';

import '../app.dart';
import '../config/app_config.dart';
import '../di/service_locator.dart';
import 'error_handlers.dart';
import 'initializers.dart';

/// Bootstraps the application with error handling and initialization logic.
class AppBootstrap {
  AppBootstrap({
    Logger? logger,
    ErrorHandler? errorHandler,
  })  : _logger = logger ?? const ConsoleLogger(),
        _errorHandler = errorHandler ?? const ErrorHandler();

  final Logger _logger;
  final ErrorHandler _errorHandler;

  /// Initializes the application.
  Future<void> initialize() async {
    await runZonedGuarded(
      () async {
        // Ensure Flutter bindings are initialized
        WidgetsFlutterBinding.ensureInitialized();

        // Set preferred orientations
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        // Setup error handlers
        _setupErrorHandlers();

        // Load configuration
        final config = await AppConfig.load();

        // Initialize services
        await Initializers.initialize(config);

        _logger.info('App initialization completed successfully');
      },
      _errorHandler.handleError,
    );
  }

  /// Runs the application.
  void run() {
    final config = getIt<AppConfig>();

    runApp(
      ProviderScope(
        child: GlowApp(
          config: config,
        ),
      ),
    );
  }

  void _setupErrorHandlers() {
    // Flutter framework errors
    FlutterError.onError = _errorHandler.handleFlutterError;

    // Platform dispatcher errors (for errors outside Flutter)
    PlatformDispatcher.instance.onError = _errorHandler.handleError;
  }
}
