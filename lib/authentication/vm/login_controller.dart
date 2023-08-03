import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trash_out/authentication/vm/login_state.dart';

import '../../providers/auth_provider.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  Future<User?> login({required String email, required String password}) async {
    state = const LoginStateLoading();
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .signInWithEmailAndPassword(email: email, password: password);

      state = const LoginStateSuccess();
      return result;
    } catch (e) {
      state = LoginStateError(e.toString());
    }
    return null;
  }

  Future<User?> createUser(
      {required String email,
      required String password,
      required String userName}) async {
    state = const LoginStateLoading();
    try {
      final result = await ref
          .read(authRepositoryProvider)
          .registerUserWithEmailAndPassword(
              email: email, password: password, userName: userName);
      state = const LoginStateSuccess();
      return result;
    } catch (e) {
      state = LoginStateError(e.toString());
    }
    return null;
  }

  void signOut() async {
    await ref.read(authRepositoryProvider).signOut();
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>((ref) {
  return LoginController(ref);
});
