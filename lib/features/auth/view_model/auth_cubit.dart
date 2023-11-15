part 'auth_state.dart';

abstract class AuthState {}

class AuthStateInit extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateFailed extends AuthState {
  final String error;
  AuthStateFailed({required this.error});
}

class AuthStateSuccess extends AuthState {}
