import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  AuthRepository(this._auth);

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result.user;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          throw AuthException("Email already used. Go to login page.");
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          throw AuthException("Wrong email/password combination.");
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          throw AuthException("No user found with this email.");
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          throw AuthException("User disabled.");
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          throw AuthException("Too many requests to log into this account.");
        case "ERROR_OPERATION_NOT_ALLOWED":
          throw AuthException("Server error, please try again later.");
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          throw AuthException("Email address is invalid.");
        default:
          throw AuthException("Login failed. Please try again.");
      }
    }
  }

  Future<User?> registerUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      User? user;

      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await result.user!.updateDisplayName(userName);

      user = result.user!;
      email = user.email!;
      _firestore.collection('users').doc(user.uid).set({
        'username': userName,
        'email': email,
        'address': '',
        'redeemed points': 0,
        'total disposals': 0,
        'total points': 0,
        'waste list': [
          {
            "wasteId": '258961',
            "id": '8965325',
            "wasteClass": "Medical",
            "wasteTypes": ["Plastic"],
            "date": DateTime.now(),
            "time": '11am - 12pm',
            "location": "College of Science",
            "points": 200
          }
        ]
      });
      return result.user;
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "ERROR_EMAIL_ALREADY_IN_USE":
        case "account-exists-with-different-credential":
        case "email-already-in-use":
          throw AuthException("Email already used. Go to login page.");
        case "ERROR_WRONG_PASSWORD":
        case "wrong-password":
          throw AuthException("Wrong email/password combination.");
        case "ERROR_USER_NOT_FOUND":
        case "user-not-found":
          throw AuthException("No user found with this email.");
        case "ERROR_USER_DISABLED":
        case "user-disabled":
          throw AuthException("User disabled.");
        case "ERROR_TOO_MANY_REQUESTS":
        case "operation-not-allowed":
          throw AuthException("Too many requests to log into this account.");
        case "ERROR_OPERATION_NOT_ALLOWED":
          throw AuthException("Server error, please try again later.");
        case "ERROR_INVALID_EMAIL":
        case "invalid-email":
          throw AuthException("Email address is invalid.");
        default:
          throw AuthException("Login failed. Please try again.");
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() {
    return message;
  }
}
