import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/gap.dart';

class SelectAddressMapPage extends StatefulWidget {
  const SelectAddressMapPage({super.key});

  @override
  State<SelectAddressMapPage> createState() => _SelectAddressMapPageState();
}

class _SelectAddressMapPageState extends State<SelectAddressMapPage> {
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Pickup Address"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 120.h, maxHeight: 200.h),
            height: mediaQ.height * 0.2,
            width: mediaQ.width,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16).w,
            decoration: BoxDecoration(
              color: KColors.green200,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pick your location from the map",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Gap(5.h),
                SizedBox(
                  height: 45.h,
                  child: TextField(
                    cursorColor: KColors.green300,
                    decoration: InputDecoration(
                      hintText: 'Enter closest landmark',
                      contentPadding: const EdgeInsets.all(5),
                      prefixIcon: const Icon(
                        Icons.location_pin,
                        color: Colors.black,
                      ),
                      fillColor: Colors.grey[100],
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: KColors.green300, width: 2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Selected Address",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 45.h,
                  width: mediaQ.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Center(
                    child: Text("College of  Science, KNUST"),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
