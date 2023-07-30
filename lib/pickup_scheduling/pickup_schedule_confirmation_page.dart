// import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:trash_out/state/state.dart';
import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';

class PickupScheduleConfirmationPage extends ConsumerStatefulWidget {
  const PickupScheduleConfirmationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PickupScheduleConfirmationPageState();
}

class _PickupScheduleConfirmationPageState
    extends ConsumerState<PickupScheduleConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    final dateAndtime = ref.watch(wasteDateTimeProvider);
    final wasteType = ref.watch(wasteTypesProvider);
    final wasteClass = ref.watch(wasteClassProvider);
    final wasteList = ref.watch(wasteListProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            splashRadius: 25.sp,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () => context.pop()),
        title: const Text(
          "Pickup Summary",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pickup Address",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              Card(
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.7),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Container(
                  height: 70.h,
                  width: mediaQ.width,
                  color: Colors.white,
                  padding: const EdgeInsets.all(10).w,
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: KColors.green200,
                        size: 30.sp,
                      ),
                      const Gap(0, 20),
                      const Expanded(
                        child: Text(
                          overflow: TextOverflow.fade,
                          "College of Science,KNUST",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Gap(10.h),
              Text(
                "Selected Garbage Type",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              Card(
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.7),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 80.h,
                  ),
                  width: mediaQ.width,
                  color: Colors.white,
                  padding: const EdgeInsets.all(10).w,
                  child: Wrap(
                    children: [
                      for (final i in wasteType.wasteTypes!)
                        Container(
                          height: 40.h,
                          width: 100,
                          margin:
                              const EdgeInsets.only(right: 10, bottom: 10).w,
                          decoration: BoxDecoration(
                            color: KColors.green200,
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Center(
                              child: Text(
                            i,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                    ],
                  ),
                ),
              ),
              Gap(10.h),
              Text(
                "Date and Time",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              Card(
                elevation: 2,
                shadowColor: Colors.black.withOpacity(0.7),
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Container(
                  height: 70.h,
                  width: mediaQ.width,
                  color: Colors.white,
                  padding: const EdgeInsets.all(10).w,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          overflow: TextOverflow.fade,
                          DateFormat.yMMMEd().format(dateAndtime.wasteDate!),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Gap(0, 20),
                      Text(
                        dateAndtime.wasteTime!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(10.h),
              Text(
                "Uploaded Photos",
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
              Gap(10.h),
              Wrap(
                children: [
                  Container(
                    height: 70.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 5).w,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  Container(
                    height: 70.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 5).w,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  Container(
                    height: 70.h,
                    width: 100.w,
                    margin: const EdgeInsets.only(right: 5).w,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(10.r)),
                  )
                ],
              ),
              Gap(20.h),
              Align(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  text: "Confirm Schedule",
                  onPressed: () {
                    ref.read(wasteListProvider.notifier).addWaste(
                        wasteClass: wasteClass,
                        wasteTypes: wasteType.wasteTypes!,
                        date: dateAndtime.wasteDate!,
                        time: dateAndtime.wasteTime!,
                        status: 'Completed',
                        location: "College of Science,KNUST",
                        points: 80000);
                    print('Updated wasteList: ${ref.watch(wasteListProvider)}');
                    context.go('/');
                  },
                ),
              ),
              Gap(20.h)
            ],
          ),
        ),
      ),
    );
  }
}
