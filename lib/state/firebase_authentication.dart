// // ignore_for_file: public_member_api_docs, sort_constructors_first
// // ignore_for_file: avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:trash_out/models/user_model.dart';

// class FirebaseAuthService extends StateNotifier<String?> {
//   FirebaseAuthService() : super(null);
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Stream<User?> get authStateChanges => _auth.authStateChanges();

//   //** Code for creating new user **//

//   Future<String> createUserWithEmailAndPassword(
//       {required String email,
//       required String password,
//       required String userName}) async {
//     User? user;
//     String? errorMessage;
//     try {
//       final result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       await result.user!.updateDisplayName(userName);

//       user = result.user!;
//       email = user.email!;
//       _firestore.collection('users').doc(user.uid).set({
//         'username': userName,
//         'email': user.email,
//         'address': '',
//         'redeemed points': 0,
//         'total disposals': 0,
//         'total points': 0,
//         'waste list': []
//       });
//     } on FirebaseAuthException catch (error) {
//       switch (error.message) {
//         case "ERROR_OPERATION_NOT_ALLOWED":
//           errorMessage = "Anonymous accounts are not enabled.";
//           break;
//         case "ERROR_WEAK_PASSWORD":
//           errorMessage = "Your password is too weak.";
//           break;
//         case "ERROR_INVALID_EMAIL":
//           errorMessage = "Your email is invalid.";
//           break;
//         case "ERROR_EMAIL_ALREADY_IN_USE":
//           errorMessage = "Email is already in use on different account.";
//           break;
//         case "ERROR_INVALID_CREDENTIAL":
//           errorMessage = "Your email is invalid.";
//           break;

//         default:
//           errorMessage = "An undefined Error happened.";
//       }
//     }
//     if (errorMessage != null) {
//       return Future.error(errorMessage);
//     }
//     fetchAndStoreUserData(user!.uid);

//     return user.uid;
//   }

//   Future<String> signUserInWithEmailAndPassword(
//       {required String email, required String password}) async {
//     User? user;
//     String? errorMessage;

//     final result = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);
//     user = result.user;
//     return '';
//   }

//   final userDataProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

//   Future<void> fetchAndStoreUserData(String userId) async {
//     try {
//       final DocumentSnapshot snapshot =
//           await _firestore.collection('users').doc(userId).get();
//       if (snapshot.exists) {
//         final userData = snapshot.data() as Map<String, dynamic>;

//         // Assuming you have an AppUser instance
//         AppUser appUser = AppUser(
//             name: userData['name'],
//             email: userData['email'],
//             totalPoints: userData['total_points'],
//             redeemed: userData['redeemed_points'],
//             totalDisposals: userData['total_disposals'],
//             wasteList: userData['waste_list']);
//       } else {
//         print('User data not found in Firestore for user ID: $userId');
//       }
//     } catch (e) {
//       print('Error fetching user data from Firestore: $e');
//     }
//   }

//   passwordReset({required String email}) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       print(e.message);
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } on FirebaseAuthException catch (e) {
//       print('Error signing out: ${e.message}');
//     }
//   }
// }

// //**Providers */

// // Riverpod provider for FirebaseAuthService.
// final firebaseAuthServiceProvider =
//     StateProvider<FirebaseAuthService>((ref) => FirebaseAuthService());

// final authStateProvider = StreamProvider<User?>((ref) {
//   return ref.read(firebaseAuthServiceProvider).authStateChanges;
// });

// class UserDataProvider extends StateNotifier<UserData?> {
//   UserDataProvider() : super(null);

//   void setUserData(UserData userData) {
//     state = userData;
//   }

//   void clearUserData() {
//     state = null;
//   }
// }

// final userDataProvider = StateProvider((ref) {
//   return ref
//       .read(firebaseAuthServiceProvider)
//       .fetchAndStoreUserData(FirebaseAuth.instance.currentUser!.uid);
// });

// class UserData {
//   String uid;
//   // Add other properties related to user data that you want to track

//   UserData(this.uid);
// }
