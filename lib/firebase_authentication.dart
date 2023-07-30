import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get authStateChange => auth.authStateChanges();

  String? errorMessage;

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (error) {
      error.message;
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } on FirebaseAuthException catch (e) {
      e.message;
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      auth.signOut();
    } on FirebaseAuthException catch (e) {
      e.message;
    }
  }
}
