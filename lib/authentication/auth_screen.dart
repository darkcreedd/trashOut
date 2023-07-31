// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:trash_out/authentication/sign_in_page.dart';
import 'package:trash_out/authentication/splash_screen.dart';
import 'package:trash_out/utils/colors.dart';

import '../state/auth.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);

    return _authState.when(
        data: (data) {
          if (data != null) return const Redirect();
          return const SignInPage();
        },
        loading: () => const SplashScreen(),
        error: (e, trace) => ErrorScreen(e: e, trace: trace));
  }
}

class Redirect extends StatefulWidget {
  const Redirect({super.key});

  @override
  State<Redirect> createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300))
        .then((value) => context.go('/home'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: KColors.green100,
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.e,
    required this.trace,
  }) : super(key: key);

  final Object e;
  final StackTrace trace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(e.toString())),
    );
  }
}
