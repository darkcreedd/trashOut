// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:email_validator/email_validator.dart';
import 'package:trash_out/authentication/vm/login_controller.dart';
import 'package:trash_out/authentication/vm/login_state.dart';

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
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    ref.listen<LoginState>(
      loginControllerProvider,
      (previous, state) {
        if (state is LoginStateError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
    );
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
                (!isLoading)
                    ? CustomButton(
                        text: "Login",
                        onPressed: () async {
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();
                          bool validEmail = EmailValidator.validate(email);
                          if (validEmail) {
                            if (password.length >= 6) {
                              setState(() {
                                isLoading = true;
                              });
                              await ref
                                  .read(loginControllerProvider.notifier)
                                  .login(email: email, password: password)
                                  .then((user) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (user != null) {
                                  context.go('/');
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Password too short!")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter a valid email')));
                          }
                        })
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: KColors.green300,
                            shadowColor: Colors.transparent,
                            fixedSize: Size(230.w, 47.h),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r))),
                        onPressed: () {},
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        )),
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
