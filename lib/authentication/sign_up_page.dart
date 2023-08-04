import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trash_out/authentication/vm/login_controller.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/custom_password_field.dart';
import 'package:trash_out/widgets/custom_email_field.dart';
import 'package:trash_out/widgets/custom_textfield.dart';
import 'package:trash_out/widgets/gap.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool keepMeloggedIn = true;
  final _formKey = GlobalKey<FormState>();

  bool newsLetter = true;
  bool isLoading = false;
  String? validateGhanaMobileNumber(String? value) {
    final RegExp regex = RegExp(r'^\+?233\d{9}$');

    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }

    if (!regex.hasMatch(value)) {
      return 'Please enter a valid Ghanaian mobile number';
    }

    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    mobileNumberController.dispose();
    nameController.dispose();
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
          child: Form(
            key: _formKey,
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
                  label: "Username",
                  controller: nameController,
                ),
                Gap(15.h),
                CustomTextField(
                    controller: mobileNumberController,
                    icon: Icons.phone,
                    label: 'Mobile Number(+233 000 000 000)'),
                Gap(15.h),
                CustomEmailField(
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
                (!isLoading)
                    ? CustomButton(
                        text: "Create Account",
                        onPressed: () async {
                          String username = nameController.text.trim();
                          String email = emailController.text.trim();
                          String mobileNumber = mobileNumberController.text;

                          String password = passwordController.text;
                          String confirmPassword =
                              confirmPasswordController.text;
                          bool isValid = EmailValidator.validate(email);
                          String? mobileNumberError =
                              validateGhanaMobileNumber(mobileNumber);
                          if (email.isNotEmpty &&
                              username.isNotEmpty &&
                              password.isNotEmpty) {
                            if (password == confirmPassword) {
                              if (username.length > 6) {
                                if (isValid) {
                                  if (mobileNumberError == null) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await ref
                                        .read(loginControllerProvider.notifier)
                                        .createUser(
                                            mobileNumber:
                                                mobileNumberController.text,
                                            email: email,
                                            password: password,
                                            userName: username)
                                        .then((user) {
                                      if (user != null) {
                                        context.go('/');
                                      }
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(mobileNumberError),
                                      ),
                                    );
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          "Invalid email, Enter a valid email"),
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "User name characters should be more than 6.")));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("passwords mismatch!"),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("All fields are required!"),
                              backgroundColor: Colors.redAccent,
                            ));
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
      ),
    );
  }
}
