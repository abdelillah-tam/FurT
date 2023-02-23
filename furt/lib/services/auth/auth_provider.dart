import 'package:furt/services/auth/auth_user.dart';

abstract class AuthProvider{
  AuthUser? get currentUser;

  Future<void> initialize();

  Future<AuthUser> logIn({required String email, required String password});
}