import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../shared/state/app_state_notifier.dart';
import 'app_routes.dart';

/// Route guards for handling navigation restrictions.
class RouteGuards {
  const RouteGuards(this.ref);

  final Ref ref;

  /// Main redirect logic based on app state.
  String? redirect(GoRouterState state) {
    final appState = ref.read(appStateNotifierProvider);
    final currentPath = state.uri.path;

    return appState.when(
      initializing: () {
        if (currentPath != AppRoutes.splash) {
          return AppRoutes.splash;
        }
        return null;
      },
      unauthenticated: () {
        if (currentPath == AppRoutes.home) {
          return AppRoutes.auth;
        }
        return null;
      },
      authenticated: () {
        if (currentPath == AppRoutes.auth || currentPath == AppRoutes.splash) {
          return AppRoutes.home;
        }
        return null;
      },
    );
  }
}
