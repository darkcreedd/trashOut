// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/state/waste_points_state.dart';
import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';

import 'package:trash_out/widgets/gap.dart';

class CardConfirmation extends ConsumerStatefulWidget {
  const CardConfirmation({
    Key? key,
    required this.companyLogo,
    required this.points,
    required this.price,
  }) : super(key: key);

  final String companyLogo;
  final String points;
  final String price;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CardConfirmationState();
}

class _CardConfirmationState extends ConsumerState<CardConfirmation> {
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    final totalPoints = ref.watch(wastePointsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25.sp,
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: const Text("Confirm Gift Card"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).w,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: mediaQ.height * 0.2,
              width: mediaQ.width,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                image: DecorationImage(
                    image: AssetImage(widget.companyLogo), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            Gap(25.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "Do you really wish to redeem ",
                style: TextStyle(
                    color: Colors.black, fontFamily: 'Sen', fontSize: 15.sp),
                children: [
                  TextSpan(
                    text: "GHS ${widget.price}",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                  const TextSpan(
                    text: " for",
                  ),
                  TextSpan(
                    text: " ${widget.points} pts ?",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Gap(25.h),
            CustomButton(
              text: 'Redeem Gift Card',
              onPressed: () {
                if (totalPoints > (int.parse(widget.points))) {
                  ref
                      .read(wastePointsProvider.notifier)
                      .update(int.parse(widget.points));
                  ref
                      .read(redeemedPointsProvider.notifier)
                      .set(int.parse(widget.points));
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r)),
                          title: Text(
                            textAlign: TextAlign.center,
                            "Success",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: KColors.green300),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 100.w,
                                width: 100.w,
                                child: Image.asset("assets/icons/checked.png"),
                              ),
                              Gap(20.h),
                              Text(
                                "Giftcard Successfully Redeemed",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Details have been sent to your email.",
                                style: TextStyle(fontSize: 13.sp),
                              ),
                            ],
                          ),
                        );
                      }).then((value) {
                    context.go('/home');
                  });
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.r)),
                          title: const Text(
                            textAlign: TextAlign.center,
                            "Failed",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 100.w,
                                width: 100.w,
                                child: Image.asset("assets/icons/failed.png"),
                              ),
                              Gap(20.h),
                              Text(
                                "You don't have sufficient points to redeem this gift card",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
