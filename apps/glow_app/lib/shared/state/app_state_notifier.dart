import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_state.dart';

part 'app_state_notifier.g.dart';

/// Notifier for global application state.
@riverpod
class AppStateNotifier extends _$AppStateNotifier {
  @override
  AppState build() {
    _initialize();
    return const AppState.initializing();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));
    state = const AppState.unauthenticated();
  }

  void markAuthenticated() {
    state = const AppState.authenticated();
  }

  void markUnauthenticated() {
    state = const AppState.unauthenticated();
  }
}
