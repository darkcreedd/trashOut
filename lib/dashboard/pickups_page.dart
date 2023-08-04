// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trash_out/state/state.dart';
import 'package:trash_out/state/waste_points_state.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_pie_chart.dart';
import 'package:trash_out/widgets/dashboard_item.dart';
import 'package:trash_out/widgets/gap.dart';
import 'package:trash_out/widgets/request_summary_tab.dart';

class PickupsPage extends ConsumerStatefulWidget {
  const PickupsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PickupsPageState();
}

class _PickupsPageState extends ConsumerState<PickupsPage> {
  Map<String, double> dataMap = {
    "Plastic": 5,
    "Metal": 3,
    "Organic": 6,
    "Glass": 4,
    "E-waste": 2,
    "Others": 7,
  };
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    final completedList = ref.watch(completedWasteProvider);
    final pendingList = ref.watch(pendingWasteProvider);
    final totalPoints = ref.watch(wastePointsProvider);
    final redeemedPoints = ref.watch(redeemedPointsProvider);
    final stats = ref.watch(statsProvider);

    final plasticCount = stats[0];
    final metalCount = stats[1];
    final organicCount = stats[2];
    final glassCount = stats[3];
    final ewasteCount = stats[4];
    final othersCount = stats[5];
    // final
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Pickups"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0).w,
        height: mediaQ.height,
        width: mediaQ.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: mediaQ.height * 0.15,
              width: mediaQ.width,
              padding: const EdgeInsets.all(8).w,
              decoration: BoxDecoration(
                color: KColors.green200,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DashBoardItem(
                      icon: MdiIcons.trophy,
                      points: totalPoints,
                      caption: "Total Points"),
                  DashBoardItem(
                      icon: MdiIcons.trashCan,
                      points: completedList.length,
                      caption: "Total Disposals"),
                  GestureDetector(
                    onTap: () {
                      //todo::
                    },
                    child: DashBoardItem(
                        icon: MdiIcons.giftOutline,
                        points: redeemedPoints,
                        caption: "Redeemed"),
                  ),
                ],
              ),
            ),
            Expanded(
              child: DefaultTabController(
                initialIndex: 1,
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorWeight: 3,
                      indicatorColor: KColors.green200,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sen',
                          fontWeight: FontWeight.bold),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs: const [
                        Tab(
                          text: 'Stats',
                        ),
                        Tab(
                          text: 'Pending',
                        ),
                        Tab(
                          text: 'History',
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10).w,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Waste Produced",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.sp),
                                  ),
                                  Gap(10.h),
                                  CustomPieChart(dataMap: {
                                    "Plastic":
                                        double.parse(plasticCount.toString()),
                                    "Metal":
                                        double.parse(metalCount.toString()),
                                    "Organic":
                                        double.parse(organicCount.toString()),
                                    "Glass":
                                        double.parse(glassCount.toString()),
                                    "E-waste":
                                        double.parse(ewasteCount.toString()),
                                    "Others":
                                        double.parse(othersCount.toString()),
                                  }),
                                  Gap(30.h),
                                ]),
                          ),
                          Visibility(
                            visible: (pendingList.isNotEmpty),
                            replacement: const Center(
                                child: Text("No Pending Disposals")),
                            child: ListView.builder(
                              itemCount: pendingList.length,
                              itemBuilder: (context, index) {
                                return RequestSummaryTab1(
                                  mediaQ: mediaQ,
                                  waste: pendingList[index],
                                );
                              },
                            ),
                          ),
                          Visibility(
                            visible: (completedList.isNotEmpty),
                            replacement: const Center(
                                child: Text("You have no disposal records")),
                            child: ListView.builder(
                              itemCount: completedList.length,
                              itemBuilder: (context, index) {
                                return RequestSummaryTab(
                                  mediaQ: mediaQ,
                                  waste: completedList[index],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
