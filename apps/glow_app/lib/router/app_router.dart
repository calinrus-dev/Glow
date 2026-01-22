import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/pages/login_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import 'routes/auth_routes.dart';
import 'routes/home_routes.dart';

/// Application router.
class AppRouter {
  AppRouter();

  late final GoRouter config = GoRouter(
    initialLocation: AuthRoutes.login,
    routes: [
      // Auth routes
      GoRoute(
        path: AuthRoutes.login,
        name: AuthRoutes.loginName,
        builder: (context, state) => const LoginPage(),
      ),
      
      // Home routes
      GoRoute(
        path: HomeRoutes.home,
        name: HomeRoutes.homeName,
        builder: (context, state) => const HomePage(),
      ),
      
      // TODO: Add other feature routes
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}
