import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
      'openid',
    ],
    serverClientId: '101588302385-hp2d9qaqg7514jk5qond29c8r2fgvsdd.apps.googleusercontent.com',
  );

  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<AuthSessionStarted>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await authService.getToken();
        if (token != null && token.isNotEmpty) {

          emit(AuthSuccess());
        } else {
          emit(AuthInitial());
        }
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
    on<AuthGoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final googleUser = await _googleSignIn.signIn();

        if (googleUser == null) {
          emit(AuthInitial());
          return;
        }

        final googleAuth = await googleUser.authentication;
        final idToken = googleAuth.idToken;

        if (idToken == null) {
          emit(AuthFailure("Não foi possível obter o idToken do Google."));
          return;
        }

        await authService.syncWithGoogle(idToken);

        emit(AuthSuccess());

      } catch (e) {
        print("--> ERRO NO PROCESSO: ${e.toString()}");
        emit(AuthFailure(e.toString()));
      }
    });

    on<AuthLogoutRequested>((event, emit) async {
      await _googleSignIn.signOut(); // Também faz logout do Google
      await authService.logout();
      emit(AuthInitial());
    });
  }
}