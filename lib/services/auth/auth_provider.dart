import 'package:notesapp/services/auth/auth_user.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> logiIn({
    required String email,
    required String password,
  });

  Future<AuthUser> createuser({
    required String email,
    required String password,
  });

  Future<void> logOut();

  Future<void> sendEmailVerification();
}
