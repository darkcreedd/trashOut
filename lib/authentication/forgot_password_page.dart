import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/custom_text_field.dart';
import 'package:trash_out/widgets/gap.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

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
              CustomTextField(
                icon: MdiIcons.email,
                label: "Email",
              ),
              Gap(50.h),
              CustomButton(
                text: "Submit",
                onPressed: () {
                  context.push('/otpScreen');
                },
              ),
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
