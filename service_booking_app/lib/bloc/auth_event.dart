part of 'auth_bloc.dart';

abstract class AuthEvent {}

class GoogleSignInRequested extends AuthEvent {}

class EmailSignInRequested extends AuthEvent {
  final String email;
  final String password;
  final bool isRegistering;

  EmailSignInRequested(this.email, this.password, {this.isRegistering = false});
}

class SignOutRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  ResetPasswordRequested(this.email);
}
