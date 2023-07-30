import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trash_out/utils/colors.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    Key? key,
    required this.label,
    this.controller,
  }) : super(key: key);

  final String label;
  final TextEditingController? controller;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        obscureText: obscureText,
        controller: widget.controller,
        cursorColor: KColors.green300,
        decoration: InputDecoration(
          suffixIcon: IconButton(
              splashColor: Colors.transparent,
              splashRadius: 20,
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: (obscureText)
                  ? Icon(
                      MdiIcons.eyeOff,
                      color: Colors.grey,
                    )
                  : Icon(
                      MdiIcons.eye,
                      color: Colors.grey,
                    )),
          hintText: widget.label,
          prefixIcon: Icon(
            MdiIcons.shieldLock,
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
