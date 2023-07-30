import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash_out/widgets/gap.dart';

class DashBoardItem extends StatelessWidget {
  const DashBoardItem({
    Key? key,
    required this.points,
    required this.icon,
    required this.caption,
  }) : super(key: key);

  final int points;
  final IconData icon;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30.sp,
        ),
        Gap(5.h),
        Text(
          '$points',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
        Gap(5.h),
        Text(
          caption,
          style: TextStyle(
              color: Colors.white54,
              fontSize: 13.sp,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
