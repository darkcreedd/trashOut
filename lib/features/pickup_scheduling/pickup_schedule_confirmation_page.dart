// import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:io';

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
  final _formKey = GlobalKey<FormState>();
  TextEditingController addressController = TextEditingController();

  bool validateCodeFormat(String code) {
    return RegExp(r'^[A-Z]{2}-[A-Z0-9]{4}-\d{4}$').hasMatch(code);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    final dateAndtime = ref.watch(wasteDateTimeProvider);
    final wasteType = ref.watch(wasteTypesProvider);
    final wasteClass = ref.watch(wasteClassProvider);
    final images = ref.watch(imagesProvider);

    // final wasteList = ref.watch(wasteListProvider);
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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Pickup Address",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                        Expanded(
                          child: TextFormField(
                            controller: addressController,
                            validator: (value) {
                              if (value != null && !validateCodeFormat(value)) {
                                return 'Invalid code format. Example: AO-K448-1234';
                              }
                              return null; // Return null when input is valid
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter your GPS code(AO -K448-1234)'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Gap(10.h),
                Text(
                  "Selected Garbage Type",
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
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
                  style:
                      TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
                ),
                Gap(10.h),
                (images.isNotEmpty)
                    ? Wrap(
                        children: List.generate(
                        images.length,
                        (index) => Container(
                          height: 80.h,
                          width: 100.w,
                          margin: const EdgeInsets.only(right: 5).w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: FileImage(
                                File(images[index]!.path),
                              ),
                            ),
                            // color: Colors.amber,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ))
                    : SizedBox(
                        height: 100.h,
                        width: mediaQ.width,
                        child: const Center(
                          child: Text(
                            "No images were added",
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                Gap(20.h),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomButton(
                    text: "Confirm Schedule",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.blue,
                                content: Text("Adding to Waste Schedules")));
                        ref.read(wasteListProvider.notifier).addWaste(
                            wasteClass: wasteClass,
                            wasteTypes: wasteType.wasteTypes!,
                            date: dateAndtime.wasteDate!,
                            time: dateAndtime.wasteTime!,
                            status: 'Pending',
                            location: addressController.text,
                            points: 20);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Success")));

                        print(
                            'Updated wasteList: ${ref.watch(wasteListProvider)}');
                        context.go('/home');
                      }
                    },
                  ),
                ),
                Gap(20.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
