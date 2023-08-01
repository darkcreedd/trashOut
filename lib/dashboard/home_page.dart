// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'package:trash_out/pickup_scheduling/state.dart';
import 'package:trash_out/state/auth.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/dashboard_item.dart';
import 'package:trash_out/widgets/gap.dart';

import '../state/user_state.dart';
import '../state/waste_points_state.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  //* Firebase table access

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    final totalDisposals = ref.watch(completedWasteProvider);
    final totalPoints = ref.watch(wastePointsProvider);
    final redeemedPoints = ref.watch(redeemedPointsProvider);

    final user = ref.watch(userDetailsNotifierProvider);
    final userData = ref.watch(userDataProvider);

    String userNew = userData.toString();
    //Todo: Firestore

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16).w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 70,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.go('/profile'),
                          child: CircleAvatar(
                            radius: 30.r,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Gap(0, 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Expanded(child: SizedBox()),
                            const Text("Welcome back,"),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: Text(
                                  user.name,
                                  style: TextStyle(
                                      color: KColors.green300,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.grey[200]),
                    child: Center(
                      child: Text(
                        DateFormat.MMMEd().format(DateTime.now()),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.sp),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              Container(
                width: mediaQ.width,
                height: mediaQ.height * 0.25,
                padding: const EdgeInsets.all(16).w,
                decoration: BoxDecoration(
                  color: KColors.green300,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DashBoardItem(
                          icon: MdiIcons.trophy,
                          points: totalPoints,
                          caption: "Total Points"),
                      DashBoardItem(
                          icon: MdiIcons.trashCan,
                          points: totalDisposals.length,
                          caption: "Total Disposals"),
                      DashBoardItem(
                          icon: IcoFontIcons.medal,
                          points: redeemedPoints,
                          caption: "Redeemed"),
                    ],
                  ),
                  const Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () => context.push('/home/redeemPoints'),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              MdiIcons.gift,
                              color: KColors.green100,
                              size: 30.sp,
                            ),
                            Gap(0, 10.w),
                            const Text(
                              "Redeem Points",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                ]),
              ),
              Gap(20.h),
              Text(
                "Quick Access",
                style: TextStyle(
                    color: KColors.green300,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp),
              ),
              Gap(20.h),
              Expanded(
                child: ResponsiveGridRow(
                  children: [
                    ResponsiveGridCol(
                      xs: 6,
                      md: 3,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(wasteClassProvider.notifier)
                              .setWasteClass('Domestic');
                          context.push('/home/domestic');
                        },
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.grey.shade100,
                          margin: const EdgeInsets.only(right: 5, bottom: 5).w,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                            height: 150,
                            alignment: const Alignment(0, 0),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 38.r,
                                    backgroundColor: Colors.blue.shade600,
                                    child: const ImageIcon(
                                      color: Colors.white,
                                      size: 40,
                                      AssetImage(
                                          "assets/icons/garbage_can.png"),
                                    ),
                                  ),
                                  Gap(5.h),
                                  Text(
                                    "Domestic Waste",
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      xs: 6,
                      md: 3,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(wasteClassProvider.notifier)
                              .setWasteClass('Medical');
                          context.push('/home/medical');
                        },
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.grey.shade100,
                          margin: const EdgeInsets.only(left: 5, bottom: 5).w,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Container(
                            height: 150,
                            alignment: const Alignment(0, 0),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 38.r,
                                    backgroundColor: Colors.orangeAccent,
                                    child: const Icon(
                                      IcoFontIcons.medicalSignAlt,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Gap(5.h),
                                  Text(
                                    "Medical Waste",
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      xs: 6,
                      md: 3,
                      child: GestureDetector(
                        onTap: () {
                          ref
                              .read(wasteClassProvider.notifier)
                              .setWasteClass("Industrial");
                          context.push('/home/industrial');
                        },
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.grey.shade100,
                          margin: const EdgeInsets.only(right: 5, top: 5).w,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Container(
                            height: 150,
                            alignment: const Alignment(0, 0),
                            decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 38.r,
                                    backgroundColor: Colors.amberAccent,
                                    child: const Icon(
                                      IcoFontIcons.industries3,
                                      size: 50,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Gap(5.h),
                                  Text(
                                    "Industrial Waste",
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ResponsiveGridCol(
                      xs: 6,
                      md: 3,
                      child: GestureDetector(
                        onTap: () => context.push('/home/wasteClassification'),
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.grey.shade100,
                          margin: const EdgeInsets.only(left: 5, top: 5).w,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Container(
                            height: 150,
                            alignment: const Alignment(0, 0),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                      radius: 38.r,
                                      backgroundColor: KColors.green100,
                                      child: const Icon(
                                        IcoFontIcons.info,
                                        color: Colors.white,
                                      )),
                                  Gap(5.h),
                                  Text(
                                    textAlign: TextAlign.center,
                                    "Waste Classification Guide",
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
