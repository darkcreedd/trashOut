import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

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
                "Recover Account",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp),
              ),
              Gap(10.h),
              Text(
                textAlign: TextAlign.center,
                "An email containing a 6-digit pin has been sent to the email account you provided, enter the pin in this field.",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp),
              ),
              Gap(15.h),
              OTPTextField(
                length: 6,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                otpFieldStyle:
                    OtpFieldStyle(focusBorderColor: KColors.green300),
                onCompleted: (pin) {
                  // print("Completed: " + pin);
                },
              ),
              Gap(50.h),
              CustomButton(
                text: "Submit",
                onPressed: () {},
              ),
              Gap(30.h),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () => context.pop(),
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
