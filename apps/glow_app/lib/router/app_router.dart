import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/presentation/pages/auth_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/spaces/presentation/pages/environment_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';
import '../shared/state/app_state_notifier.dart';
import 'app_routes.dart';
import 'route_guards.dart';

part 'app_router.g.dart';

/// Provides the GoRouter instance.
@riverpod
GoRouter router(RouterRef ref) {
  final guards = RouteGuards(ref);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    redirect: (context, state) => guards.redirect(state),
    refreshListenable: _AppStateListener(ref),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splashName,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        name: AppRoutes.authName,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.homeName,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.environment,
        name: AppRoutes.environmentName,
        builder: (context, state) {
          final name = state.pathParameters['name'] ?? '';
          return EnvironmentPage(spaceName: name);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}

/// Listenable that notifies GoRouter when app state changes.
class _AppStateListener extends ChangeNotifier {
  _AppStateListener(this._ref) {
    _ref.listen(
      appStateNotifierProvider,
      (_, __) => notifyListeners(),
    );
  }

  final RouterRef _ref;
}
