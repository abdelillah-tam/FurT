

import 'package:bloc/bloc.dart';
import 'package:furt/services/auth/auth_provider.dart';
import 'package:furt/services/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthProvider provider;

  AuthCubit({required this.provider})
      : super(const AuthStateUninitialized(isLoading: true));

  void initialize() async {
    await provider.initialize();
    final user = provider.currentUser;
    if (user == null) {
      emit(const AuthStateLoggedOut(exception: null, isLoading: false));
    } else {
      emit(AuthStateLoggedIn(user: user, isLoading: false));
    }
  }

  void logIn({required String email, required String password}) async {
    emit(
      const AuthStateLoggedOut(
        exception: null,
        isLoading: true,
        loadingText: 'Please wait ...',
      ),
    );
    try {
      final user = await provider.logIn(email: email, password: password);
      emit(const AuthStateLoggedOut(exception: null, isLoading: false));
      emit(AuthStateLoggedIn(user: user, isLoading: false));
    } on Exception catch (e) {
      emit(AuthStateLoggedOut(exception: e, isLoading: false));
    }
  }

  void signUp({required String email, required String password}) async {
    try {
      emit(const AuthStateRegisterState(
          exception: null, isLoading: true, loadingText: 'Signing up ...'));
      await provider.register(email: email, password: password);
      emit(const AuthStateRegisterState(exception: null, isLoading: false));
      final user = await provider.logIn(email: email, password: password);
      emit(AuthStateLoggedIn(user: user, isLoading: false));
    } on Exception catch (e) {
      emit(AuthStateRegisterState(exception: e, isLoading: false));
    }
  }

  void shoudRegister() {
    emit(const AuthStateRegisterState(exception: null, isLoading: false));
  }

  void logout() async {
    try {
      await provider.logout();
      emit(
        const AuthStateLoggedOut(
          exception: null,
          isLoading: false,
        ),
      );
    } on Exception catch (e) {
      emit(AuthStateLoggedOut(exception: e, isLoading: false));
    }
  }
}
