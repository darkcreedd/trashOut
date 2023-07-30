import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trash_out/models/user_model.dart';

class Authentication {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Stream<User?> get authStateChange => auth.authStateChanges();

  String? errorMessage;

  AppUser? appUser;

  // Future<User?> signUpWithEmailAndPassword(
  //     {required String email,
  //     required String name,
  //     required String password}) async {
  //   final fullname = name.split('');
  //   try {
  //     final result = await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //       if(result.user != null){
  //           await FirebaseFirestore.instance.collection('users').add({
  //       'first name': fullname[0],
  //       'last name': fullname[1],
  //       'email': email,
  //       'address': '',
  //       'redeemed points': 0,
  //       'total disposals': 0,
  //       'total points': 0,
  //       'waste list': {
  //         {"wasteId": '258961',
  //         "id": '8965325',
  //         "wasteClass": "Medical",
  //         "wasteTypes": ["Plastic"],
  //         "date": DateTime.now(),
  //         "time": '11am - 12pm',
  //         "location": "College of Science",
  //         "points": 200}
  //       }
  //     });

  //     }
  //     return result.user;
  //   } on FirebaseAuthException catch (error) {
  //     error.message;
  //   }
  //   return null;
  // }

  Future<User?> signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    final fullname = name.split('');
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user != null) {
        await FirebaseFirestore.instance.collection('users').add({
          'first name': fullname[0],
          'last name': fullname[1],
          'email': email,
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

        // Fetch the user data from Firestore using the user ID
        final userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .get();

        if (userSnapshot.exists) {
          // If the user document exists, create a User instance from the data
          appUser = AppUser(
            name: userSnapshot.data()?['first name'],
            email: userSnapshot.data()?['email'],
            password: '',
            redeemed: userSnapshot.data()?['redeemed points'],
            totalDisposals: userSnapshot.data()?['total disposals'],
            totalPoints: userSnapshot.data()?['total points'],
            //Todo: waste list
            // Add other properties as needed based on your User class
          );
        } else {
          // Document doesn't exist, handle error or set appUser to null
          appUser = null;
        }
      }
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
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(result.user!.uid)
          .get();

      if (userSnapshot.exists) {
        // If the user document exists, create a User instance from the data
        appUser = AppUser(
          name: userSnapshot.data()?['first name'],
          email: userSnapshot.data()?['email'],
          password: '',
          redeemed: userSnapshot.data()?['redeemed points'],
          totalDisposals: userSnapshot.data()?['total disposals'],
          totalPoints: userSnapshot.data()?['total points'],
          //Todo: waste list
          // Add other properties as needed based on your User class
        );
      } else {
        // Document doesn't exist, handle error or set appUser to null
        appUser = null;
      }
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

class UserDetailsNotifier extends StateNotifier<AppUser> {
  UserDetailsNotifier()
      : super(AppUser(
            name: 'name',
            email: 'email',
            password: 'password',
            totalPoints: 0,
            totalDisposals: 0,
            redeemed: 0));
  updateUser(
      {required String name,
      required String email,
      required String password,
      required int totalPoints,
      required int totalDisposals,
      required int redeemed}) {
    state = AppUser(
        name: name,
        email: email,
        password: password,
        totalPoints: totalPoints,
        totalDisposals: totalDisposals,
        redeemed: redeemed);
  }
}

final userDetailsNotifierProvider =
    StateNotifierProvider<UserDetailsNotifier, AppUser>((ref) {
  return UserDetailsNotifier();
});
