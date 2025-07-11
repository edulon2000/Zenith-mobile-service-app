part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  AuthLoginRequested({required this.email, required this.password});
}

// Futuramente você pode adicionar eventos de Google, Cadastro, etc.
// class AuthGoogleLoginRequested extends AuthEvent {}
// class AuthSignupRequested extends AuthEvent { ... }
class AuthSessionStarted extends AuthEvent {}
class AuthLogoutRequested extends AuthEvent {}
class AuthGoogleSignInRequested extends AuthEvent {}
