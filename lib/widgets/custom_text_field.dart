import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash_out/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.icon,
    required this.label,
    this.controller,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: controller,
        cursorColor: KColors.green300,
        decoration: InputDecoration(
          hintText: label,
          prefixIcon: Icon(
            icon,
            color: Colors.grey,
          ),
          fillColor: Colors.grey[100],
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(10.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: KColors.green300),
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }
}
