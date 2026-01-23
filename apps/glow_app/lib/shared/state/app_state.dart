import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

/// Global application state.
@freezed
class AppState with _$AppState {
  const factory AppState.initializing() = _Initializing;
  const factory AppState.unauthenticated() = _Unauthenticated;
  const factory AppState.authenticated() = _Authenticated;
}
