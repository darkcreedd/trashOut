// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<User?> get authStateChange => _auth.authStateChanges();

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  Future<User?> signInWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleSignInException(e);
      print('Error signing in: $errorMessage');
      return null;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }

  Future<User?> createAccountWithEmailAndPass(
      {required String email,
      required String password,
      required String userName}) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        // Set the user's display name directly.
        await result.user!.updateDisplayName(userName);
      }
      if (result.user != null) {
        // Create a user entry in Firestore.
        await _createUserEntryInFirestore(result.user!);
      }

      return result.user;
    } on FirebaseAuthException catch (e) {
      _handleCreateAccountException(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      String errorMessage = _handleSignOutException(e);
      print('Error signing out: $errorMessage');
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  Future<void> _createUserEntryInFirestore(User user) async {
    try {
      // The 'users' collection in Firestore will store user data.
      await _firestore.collection('users').doc(user.uid).set({
        'username': user.displayName,
        'email': user.email,
        'address': '',
        'redeemed points': 0,
        'total disposals': 0,
        'total points': 0,
        'waste list': {
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
        }
      });
    } catch (e) {
      print('Error creating user entry in Firestore: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchUserData(String userId) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>;
      } else {
        print('User data not found in Firestore for user ID: $userId');
        return null;
      }
    } catch (e) {
      print('Error fetching user data from Firestore: $e');
      return null;
    }
  }

  String _handleSignInException(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'User not found. Please check your email and try again.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password. Please try again.';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email address. Please enter a valid email.';
        break;
      default:
        errorMessage = 'An error occurred while signing in. Please try again.';
    }
    return errorMessage;
  }

  String _handleCreateAccountException(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'email-already-in-use':
        errorMessage = 'This email address is already in use.';
        break;
      case 'weak-password':
        errorMessage =
            'The password is too weak. Please choose a stronger password.';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email address. Please enter a valid email.';
        break;
      default:
        errorMessage =
            'An error occurred while creating an account. Please try again.';
    }
    return errorMessage;
  }

  String _handleSignOutException(FirebaseAuthException e) {
    // You may handle specific sign-out exceptions if needed.
    // Currently, we are not differentiating sign-out exceptions.
    return 'An error occurred while signing out. Please try again.';
  }
}

//**Providers */

// Riverpod provider for FirebaseAuthService.
final firebaseAuthServiceProvider =
    Provider<FirebaseAuthService>((ref) => FirebaseAuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(firebaseAuthServiceProvider).authStateChange;
});

// Riverpod provider for the user data fetched from Firestore.
final userDataProvider =
    FutureProvider.family<Map<String, dynamic>?, String>((ref, userId) async {
  final authService = ref.read(firebaseAuthServiceProvider);
  return await authService.fetchUserData(userId);
});
