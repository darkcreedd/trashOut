import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/custom_password_field.dart';
import 'package:trash_out/widgets/gap.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

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
                "Reset Password",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp),
              ),
              Gap(10.h),
              Text(
                textAlign: TextAlign.center,
                "Create a new password for your recovered account.",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp),
              ),
              Gap(25.h),
              const CustomPasswordField(label: "New Password"),
              Gap(15.h),
              const CustomPasswordField(label: "Confirm Password"),
              Gap(50.h),
              CustomButton(
                text: "Reset Password",
                onPressed: () {},
              ),
              Gap(30.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Back",
                    style: TextStyle(
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline,
                        color: KColors.green300,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
