import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trash_out/firebase_authentication.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/custom_password_field.dart';
import 'package:trash_out/widgets/custom_text_field.dart';
import 'package:trash_out/widgets/gap.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool keepMeloggedIn = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
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
              CustomTextField(
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
                          color: KColors.green300, fontWeight: FontWeight.bold),
                    )),
              ),
              Gap(50.h),
              CustomButton(
                text: "Login",
                onPressed: () {
                  Authentication()
                      .signInWithEmailAndPassword(emailController.text.trim(),
                          passwordController.text.trim())
                      .then((value) => context.go('/'));
                },
              ),
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
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
