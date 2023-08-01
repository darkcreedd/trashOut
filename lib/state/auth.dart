// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseAuthService extends StateNotifier<String?> {
  FirebaseAuthService() : super(null);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signInWithEmailAndPass(
      {required String email, required String password}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        await fetchUserData(result.user!.uid);
      }
      return result.user;
    } on FirebaseAuthException catch (e) {
      String? signInError = handleSignInException(e);
      state = signInError;
      print('Error signing in: $signInError');
      print('the error occured here state**** $state');

      return null;
    } catch (e) {
      String signInError =
          'An error occurred while signing in. Please try again.';
      // Set the error message using the AuthErrorNotifier
      state = signInError;

      print('Error signing in: $e');
      return null;
    }
  }

  // passwordReset({required String email})async{
  //   try{
  //     await _auth.sendPasswordResetEmail(email: email);
  //   }on FirebaseAuthException catch(e){
  //     print(e.message);
  //   }
  // }

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
      String? signupError = handleCreateAccountException(e);
      state = signupError;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      String signOutError = _handleSignOutException(e);
      state = signOutError;
      print('Error signing out: $signOutError');
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

  String? handleSignInException(FirebaseAuthException e) {
    String signInError;
    switch (e.code) {
      case 'user-not-found':
        signInError = 'User not found. Please check your email and try again.';
        break;
      case 'wrong-password':
        signInError = 'Incorrect password. Please try again.';
        break;
      case 'invalid-email':
        signInError = 'Invalid email address. Please enter a valid email.';
        break;
      default:
        signInError = 'An error occurred while signing in. Please try again.';
    }
    return signInError;
  }

  String? handleCreateAccountException(FirebaseAuthException e) {
    String signupError;
    switch (e.code) {
      case 'email-already-in-use':
        signupError = 'This email address is already in use.';
        break;
      case 'weak-password':
        signupError =
            'The password is too weak. Please choose a stronger password.';
        break;
      case 'invalid-email':
        signupError = 'Invalid email address. Please enter a valid email.';
        break;
      default:
        signupError =
            'An error occurred while creating an account. Please try again.';
    }
    return signupError;
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
    StateProvider<FirebaseAuthService>((ref) => FirebaseAuthService());

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(firebaseAuthServiceProvider).authStateChanges;
});

class UserDataProvider extends StateNotifier<UserData?> {
  UserDataProvider() : super(null);

  void setUserData(UserData userData) {
    state = userData;
  }

  void clearUserData() {
    state = null;
  }
}

final userDataProvider = StateProvider((ref) {
  return ref
      .read(firebaseAuthServiceProvider)
      .fetchUserData(FirebaseAuth.instance.currentUser!.uid);
});

class UserData {
  String uid;
  // Add other properties related to user data that you want to track

  UserData(this.uid);
}
