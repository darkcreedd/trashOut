// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:trash_out/models/user_model.dart';

// class Authentication {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   Stream<User?> get authStateChange => auth.authStateChanges();

//   String? errorMessage;
//   // final ProviderContainer _container;

//   // Authentication(this._container,);

//   static AppUser? appUser;

//   Future<User?> signUpWithEmailAndPassword(
//       {required String email,
//       required String name,
//       required String password}) async {
//     try {
//       final result = await auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       if (result.user != null) {
//         await FirebaseFirestore.instance.collection('users').add({
//           'username': name,
//           'email': email,
//           'address': '',
//           'redeemed points': 0,
//           'total disposals': 0,
//           'total points': 0,
//           'waste list': {
//             {
//               "wasteId": '258961',
//               "id": '8965325',
//               "wasteClass": "Medical",
//               "wasteTypes": ["Plastic"],
//               "date": DateTime.now(),
//               "time": '11am - 12pm',
//               "location": "College of Science",
//               "points": 200
//             }
//           }
//         });

//         // Fetch the user data from Firestore using the user ID
//         // final userSnapshot = await FirebaseFirestore.instance
//         //     .collection('users')
//         //     .doc(result.user!.uid)
//         //     .get();

//         // if (userSnapshot.exists) {
//         //   // If the user document exists, create a User instance from the data
//         //   appUser = AppUser(
//         //     name: userSnapshot.data()?['first name'],
//         //     email: userSnapshot.data()?['email'],
//         //     password: '',
//         //     redeemed: userSnapshot.data()?['redeemed points'],
//         //     totalDisposals: userSnapshot.data()?['total disposals'],
//         //     totalPoints: userSnapshot.data()?['total points'],
//         //     //Todo: waste list
//         //     // Add other properties as needed based on your User class
//         //   );
//         // _container.read(userDetailsNotifierProvider.notifier).updateUser(
//         //     user: appUser ??
//         //         AppUser(
//         //             name: name,
//         //             email: email,
//         //             password: password,
//         //             totalPoints: 0,
//         //             totalDisposals: 0,
//         //             redeemed: 0));
//         // } else {
//         //   // Document doesn't exist, handle error or set appUser to null
//         //   appUser = AppUser(
//         //       name: name,
//         //       email: email,
//         //       password: password,
//         //       totalPoints: 0,
//         //       totalDisposals: 0,
//         //       redeemed: 0);
//         // }
//       }
//       return result.user;
//     } on FirebaseAuthException catch (error) {
//       error.message;
//     }
//     return null;
//   }

//   Future<User?> signInWithEmailAndPassword(
//       {required String email, required String password}) async {
//     try {
//       final result = await auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       // final userSnapshot = await FirebaseFirestore.instance
//       //     .collection('users')
//       //     .doc(result.user!.uid)
//       //     .get();

//       // if (userSnapshot.exists) {
//       //   // If the user document exists, create a User instance from the data
//       //   appUser = AppUser(
//       //     name: userSnapshot.data()?['username'],
//       //     email: userSnapshot.data()?['email'],
//       //     password: '',
//       //     redeemed: userSnapshot.data()?['redeemed points'],
//       //     totalDisposals: userSnapshot.data()?['total disposals'],
//       //     totalPoints: userSnapshot.data()?['total points'],
//       //     //Todo: waste list
//       //     // Add other properties as needed based on your User class
//       //   );
//       //   print('appuser --- ${appUser!.email}');
//       // } else {
//       //   // Document doesn't exist, handle error or set appUser to null
//       //   appUser = AppUser(
//       //       name: 'no user-name',
//       //       email: email,
//       //       password: password,
//       //       totalPoints: 0,
//       //       totalDisposals: 0,
//       //       redeemed: 0);
//       // }
//       return result.user;
//     } on FirebaseAuthException catch (e) {
//       e.message;
//     }
//     return null;
//   }

//   Future<void> signOut() async {
//     try {
//       auth.signOut();
//     } on FirebaseAuthException catch (e) {
//       e.message;
//     }
//   }
// }

// final authenticationProvider = Provider<Authentication>((ref) {
//   return Authentication();
// });

// final authStateProvider = StreamProvider<User?>((ref) {
//   return ref.read(authenticationProvider).authStateChange;
// });

// final initialiseFirebaseProvider = FutureProvider<FirebaseApp>((ref) async {
//   return await Firebase.initializeApp();
// });
