// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:trash_out/widgets/gap.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({
    Key? key,
    required this.mediaQ,
    required this.icon,
    this.onPressed,
    required this.title,
  }) : super(key: key);

  final Size mediaQ;
  final IconData icon;
  final Function()? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8).w,
        height: 45.h,
        width: mediaQ.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [Icon(icon), Gap(0, 10.w), Text(title)],
            ),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
