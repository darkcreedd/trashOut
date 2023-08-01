import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:trash_out/authentication/forgot_password_page.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';

class RecoverAccount extends ConsumerStatefulWidget {
  const RecoverAccount({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<RecoverAccount> {
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    final email = ref.watch(emailProvider);
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
              RichText(
                text: TextSpan(
                    text:
                        "An email containing a link to reset your password has been sent to ",
                    style: TextStyle(
                        color: KColors.green300,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.sp),
                    children: [
                      TextSpan(
                        text: email,
                        style: TextStyle(
                            color: KColors.green300,
                            fontWeight: FontWeight.w900,
                            fontSize: 14.sp),
                      ),
                      TextSpan(
                        text:
                            ", click on the link to reset your password and sign up with your new password.",
                        style: TextStyle(
                            color: KColors.green300,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      )
                    ]),
              ),
              Gap(30.h),
              CustomButton(
                text: "Back To Sign In",
                onPressed: () {
                  context.go('/signIn');
                },
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
