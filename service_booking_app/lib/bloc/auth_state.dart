part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  final bool isEmailVerified;

  Authenticated(this.user) : isEmailVerified = user.emailVerified;
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}

class VerificationEmailSent extends AuthState {}

class PasswordResetSent extends AuthState {}
