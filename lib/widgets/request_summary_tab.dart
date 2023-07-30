// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:trash_out/models/waste_model.dart';

class RequestSummaryTab extends StatelessWidget {
  const RequestSummaryTab({
    Key? key,
    required this.mediaQ,
    required this.waste,
  }) : super(key: key);

  final Size mediaQ;
  final Waste waste;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5).w,
      child: Container(
        height: 80.h,
        width: mediaQ.width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10).w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request ID: ${waste.wasteId}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        waste.wasteTypes.toString()),
                    Text(DateFormat.yMd().format(waste.date)),
                    Text("Status: ${waste.status}")
                  ]),
            ),
            Container(
              // color: Colors.red,
              margin: const EdgeInsets.only(left: 8).w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${waste.points}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text("Points")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RequestSummaryTab1 extends StatelessWidget {
  const RequestSummaryTab1({
    Key? key,
    required this.mediaQ,
    required this.waste,
  }) : super(key: key);

  final Size mediaQ;
  final Waste waste;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5).w,
      child: Container(
        height: 80.h,
        width: mediaQ.width,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10).w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Request ID: ${waste.wasteId}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        waste.wasteTypes.toString()),
                    Text(DateFormat.yMd().format(waste.date)),
                    Text("Status: ${waste.status}")
                  ]),
            ),
            Container(
              // color: Colors.red,
              margin: const EdgeInsets.only(left: 8).w,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "-",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Points")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
