import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

/// Authentication BLoC.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        loginRequested: (e) => _onLoginRequested(e, emit),
        logoutRequested: (e) => _onLogoutRequested(e, emit),
      );
    });
  }

  Future<void> _onLoginRequested(
    _LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());
    
    // TODO: Implement login logic
    await Future<void>.delayed(const Duration(seconds: 1));
    
    emit(const AuthState.authenticated());
  }

  Future<void> _onLogoutRequested(
    _LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    // TODO: Implement logout logic
    emit(const AuthState.unauthenticated());
  }
}
