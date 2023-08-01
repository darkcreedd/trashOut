// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trash_out/state/auth.dart';
import 'package:email_validator/email_validator.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/custom_password_field.dart';
import 'package:trash_out/widgets/custom_email_field.dart';
import 'package:trash_out/widgets/gap.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool keepMeloggedIn = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool inputValidator({required String email, required String password}) {
    bool isValid = EmailValidator.validate(email);
    if (isValid && (password.length > 6)) {
      return true;
    } else {
      return false;
    }
  }

  String? errorMessage;

  signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorMessage = FirebaseAuthService().handleSignInException(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: mediaQ.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Welcome Back To TrashOut",
                  style: TextStyle(
                      color: KColors.green300,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.sp),
                ),
                Gap(50.h),
                CustomEmailField(
                  controller: emailController,
                  icon: MdiIcons.email,
                  label: "Email",
                ),
                Gap(15.h),
                CustomPasswordField(
                  controller: passwordController,
                  label: "Password",
                ),
                Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r)),
                          onChanged: (value) {
                            setState(() {
                              keepMeloggedIn = value!;
                            });
                          },
                          value: keepMeloggedIn,
                        ),
                        Text(
                          "Keep me logged in",
                          style: TextStyle(
                              color: KColors.green300,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: TextButton(
                      onPressed: () => context.push('/forgotPassword'),
                      child: Text(
                        "Forgot your Password?",
                        style: TextStyle(
                            color: KColors.green300,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Gap(50.h),
                CustomButton(
                    text: "Login",
                    onPressed: () {
                      bool valid = inputValidator(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                      );
                      if (valid) {
                        context.go('/');
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Enter a valid email"),
                          ),
                        );
                      }
                    }),
                Gap(30.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: TextStyle(
                            color: KColors.green300,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () => context.go('/signUp'),
                        child: Text(
                          "  Sign up",
                          style: TextStyle(
                              color: KColors.green200,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
