import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial()) {
    on<GoogleSignInRequested>(_mapGoogleSignInRequestedToState);
    on<EmailSignInRequested>(_mapEmailSignInRequestedToState);
    on<SignOutRequested>(_mapSignOutRequestedToState);
    on<ResetPasswordRequested>(_mapResetPasswordRequestedToState);
  }

  Future<void> _mapGoogleSignInRequestedToState(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
        emit(Authenticated(_auth.currentUser!));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _mapEmailSignInRequestedToState(
    EmailSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      if (event.isRegistering) {
        await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        // Send email verification
        await _auth.currentUser?.sendEmailVerification();
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated(userCredential.user!));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _mapSignOutRequestedToState(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    emit(Unauthenticated());
  }

  Future<void> _mapResetPasswordRequestedToState(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.sendPasswordResetEmail(email: event.email);
      emit(PasswordResetSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _mapVerifyEmailRequestedToState(
    VerifyEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _auth.currentUser?.sendEmailVerification();
      emit(VerificationEmailSent());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
