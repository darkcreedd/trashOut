// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trash_out/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);
  final String text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: KColors.green300,
          shadowColor: Colors.transparent,
          fixedSize: Size(230.w, 47.h),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r))),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    Key? key,
    this.onPressed,
    required this.text,
  }) : super(key: key);
  final Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shadowColor: Colors.transparent,
            splashFactory: NoSplash.splashFactory,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: KColors.green300, width: 2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            backgroundColor: Colors.transparent,
            fixedSize: Size(250.w, 50.h)),
        onPressed: () {},
        child: Text(
          "Login",
          style:
              TextStyle(fontWeight: FontWeight.bold, color: KColors.green300),
        ));
  }
}

class CustomButtonWithShadow extends StatelessWidget {
  const CustomButtonWithShadow({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shadowColor: KColors.green300.withOpacity(0.5),
          elevation: 10,
          splashFactory: NoSplash.splashFactory,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          backgroundColor: KColors.green300,
          fixedSize: Size(250.w, 50.h)),
      onPressed: onPressed,
      child: const Text(
        "Create an Account",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
