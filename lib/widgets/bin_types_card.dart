import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BinTypesCard extends StatelessWidget {
  const BinTypesCard(
      {super.key,
      required this.size,
      required this.image,
      required this.type,
      this.onPressed,
      required this.containerSize,
      required this.price});

  final String image;
  final Function()? onPressed;
  final Size containerSize;
  final String type;
  final int size;
  final double price;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15).r,
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(5, 2, 5, 0).w,
          width: containerSize.width,
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15).r,
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                    ),
                  ),
                ),
              ),
              Text(
                "$type $size ltrs ",
                style: TextStyle(fontSize: 14.sp),
              ),
              Text(
                "GHS $price",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
