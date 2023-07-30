import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trash_out/authentication/sign_in_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Center(
                  child: Text(
                      "Logged In as ${FirebaseAuth.instance.currentUser!}")),
            );
          } else {
            return const SignInPage();
          }
        },
      ),
    );
  }
}
