import 'package:notesapp/services/auth/auth_provider.dart';
import 'package:notesapp/services/auth/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider _authProvider;

  AuthService(this._authProvider);

  @override
  Future<AuthUser> createuser({
    required String email,
    required String password,
  }) =>
      _authProvider.createuser(email: email, password: password);

  @override
  AuthUser? get currentUser => _authProvider.currentUser;

  @override
  Future<void> logOut() => _authProvider.logOut();

  @override
  Future<AuthUser> logiIn({
    required String email,
    required String password,
  }) =>
      _authProvider.logiIn(email: email, password: password);

  @override
  Future<void> sendEmailVerification() => _authProvider.sendEmailVerification();
}
