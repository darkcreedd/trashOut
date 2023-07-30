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

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool newsLetter = true;

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
                "Welcome To TrashOut",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp),
              ),
              Text(
                "We're happy to have you here",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.w500,
                    fontSize: 15.sp),
              ),
              Gap(50.h),
              CustomTextField(
                icon: MdiIcons.accountCircle,
                label: "Full Name",
                controller: nameController,
              ),
              Gap(15.h),
              CustomTextField(
                icon: MdiIcons.email,
                label: "Email",
                controller: emailController,
              ),
              Gap(15.h),
              CustomPasswordField(
                label: "Password",
                controller: passwordController,
              ),
              Gap(15.h),
              CustomPasswordField(
                controller: confirmPasswordController,
                label: "Confirm Password",
              ),
              Gap(10.h),
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
                            newsLetter = value!;
                          });
                        },
                        value: newsLetter,
                      ),
                      Expanded(
                        child: Text(
                          softWrap: true,
                          "I would like to receive your newsletter and other promotional information.",
                          style: TextStyle(
                              color: KColors.green300,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
              Gap(50.h),
              CustomButton(
                text: "Create Account",
                onPressed: () {
                  if (passwordController.text ==
                      confirmPasswordController.text) {
                    Authentication()
                        .signUpWithEmailAndPassword(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim())
                        .then((value) => context.go('/'));
                  }
                },
              ),
              Gap(30.h),
              GestureDetector(
                onTap: () => context.go('/signIn'),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Already have an account ?",
                          style: TextStyle(
                              color: KColors.green300,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/signIn'),
                          child: Text(
                            "  Sign in",
                            style: TextStyle(
                                color: KColors.green200,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
