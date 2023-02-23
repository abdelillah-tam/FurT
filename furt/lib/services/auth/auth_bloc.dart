import 'package:bloc/bloc.dart';
import 'package:furt/services/auth/auth_event.dart';
import 'package:furt/services/auth/auth_provider.dart';
import 'package:furt/services/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventLogIn>((event, emit) async {
      emit(const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait ...',
      ));

      final email = event.email;
      final password = event.password;

      try {
        final user = await provider.logIn(email: email, password: password);

        emit(const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ));
        emit(AuthStateLoggedIn(
          user: user,
          isLoading: false,
        ));

      } on Exception catch (e) {
        emit(AuthStateLoggedOut(
          exception: e,
          isLoading: false,
        ));
      }
    });
  }
}
