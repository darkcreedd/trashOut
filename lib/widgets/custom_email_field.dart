import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash_out/utils/colors.dart';

class CustomEmailField extends StatefulWidget {
  const CustomEmailField({
    Key? key,
    required this.icon,
    required this.label,
    this.controller,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final TextEditingController? controller;

  @override
  State<CustomEmailField> createState() => _CustomEmailFieldState();
}

class _CustomEmailFieldState extends State<CustomEmailField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        validator: (value) {
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!);
          if (emailValid == false) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("Invalid email")));
          }
          return null;
        },
        controller: widget.controller,
        cursorColor: KColors.green300,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: widget.label,
          prefixIcon: Icon(
            widget.icon,
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
