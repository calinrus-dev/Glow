import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_state.dart';

part 'auth_bloc.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() => const AuthState.initial();

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();

    try {
      // TODO: Implement login logic with Supabase
      await Future<void>.delayed(const Duration(seconds: 1));

      state = const AuthState.authenticated();
    } catch (e) {
      state = AuthState.error(e.toString());
    }
  }

  Future<void> logout() async {
    // TODO: Implement logout logic
    state = const AuthState.unauthenticated();
  }
}
