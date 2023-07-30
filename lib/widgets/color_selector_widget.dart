import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorSelector extends StatefulWidget {
  const ColorSelector({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2).w,
        height: 35.w,
        width: 35.w,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
          borderRadius: BorderRadius.circular(10.r),
          color: widget.color,
        ),
        child: isSelected
            ? const Center(
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              )
            : null,
      ),
    );
  }
}
