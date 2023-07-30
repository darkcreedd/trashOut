import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash_out/widgets/gap.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, bottom: 20).w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 8.r,
            backgroundColor: color,
          ),
          const Gap(0, 8),
          Text(label)
        ],
      ),
    );
  }
}
