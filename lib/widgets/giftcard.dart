import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GiftCard extends StatefulWidget {
  const GiftCard({
    super.key,
    required this.points,
    required this.price,
    required this.imagePath,
    required this.trigger,
  });

  final int points;
  final double price;
  final String imagePath;
  final bool trigger;

  @override
  State<GiftCard> createState() => _GiftCardState();
}

class _GiftCardState extends State<GiftCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // widget.trigger = widget.trigger;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          children: [
            Card(
              color: (widget.trigger) ? Colors.red : Colors.transparent,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
              child: Container(
                width: 150.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Center(
                    child: Text(
                  "GHS ${widget.price}",
                  style: TextStyle(fontSize: 16.sp),
                )),
              ),
            ),
            Text(
              "${widget.points} pts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ],
        ),
      ),
    );
  }
}
