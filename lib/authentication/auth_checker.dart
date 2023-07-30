import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trash_out/authentication/sign_in_page.dart';
import 'package:trash_out/authentication/splash_screen.dart';

import '../state/provider.dart';

class AuthChecker extends ConsumerStatefulWidget {
  const AuthChecker({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends ConsumerState<AuthChecker> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        if (data != null) return const SplashScreen();
        return const SignInPage();
      },
      loading: () => const LoadingScreen(),
      error: (e, trace) => ErrorScreen(
        ex: e,
        trace: trace,
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.ex, this.trace});
  final Object? ex;
  final StackTrace? trace;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 50,
          width: 50,
          child: Text('${ex.toString()} $trace'),
        ),
      ),
    );
  }
}
