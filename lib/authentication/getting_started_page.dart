import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';

class GettingStartedPage extends StatelessWidget {
  const GettingStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0).w,
        child: SizedBox(
          height: mediaQ.height,
          width: mediaQ.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButtonWithShadow(onPressed: () => context.go("/signUp")),
              Gap(20.h),
              CustomOutlinedButton(
                text: "Login",
                onPressed: () => context.go('/signIn'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
