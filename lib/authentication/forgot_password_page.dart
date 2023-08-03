import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/custom_email_field.dart';
import 'package:trash_out/widgets/gap.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
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
                "Forgot your password?",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp),
              ),
              Gap(10.h),
              Text(
                textAlign: TextAlign.center,
                "Don't worry, we will help you recover it! Enter the email you used in creating an account here and we will help you recover it",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp),
              ),
              Gap(25.h),
              CustomEmailField(
                icon: MdiIcons.email,
                label: "Email",
                controller: emailController,
              ),
              Gap(50.h),
              (!isLoading)
                  ? CustomButton(
                      text: "Submit",
                      onPressed: () async {
                        FocusManager.instance.primaryFocus!.unfocus();

                        String email = emailController.text.trim();
                        bool isValid = EmailValidator.validate(email);
                        if (isValid) {
                          ref.read(emailProvider.notifier).setEmail(email);
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: email)
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Reset link sent'),
                              ),
                            );
                            // ignore: use_build_context_synchronously
                            context.push('/otpScreen');
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message!),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Invalid email, try again.")));
                        }
                      },
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: KColors.green300,
                          shadowColor: Colors.transparent,
                          fixedSize: Size(230.w, 47.h),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r))),
                      onPressed: () {},
                      child: CircularProgressIndicator(color: Colors.white)),
              Gap(30.h),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () => context.go('/signIn'),
                    child: Text(
                      "Back",
                      style: TextStyle(
                          fontSize: 16.sp,
                          decoration: TextDecoration.underline,
                          color: KColors.green300,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class EmailNotifier extends StateNotifier<String?> {
  EmailNotifier() : super('');
  setEmail(String email) {
    state = email;
  }
}

final emailProvider = StateNotifierProvider<EmailNotifier, String?>((ref) {
  return EmailNotifier();
});
