import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/widgets/color_selector_widget.dart';
import 'package:trash_out/widgets/gap.dart';

import '../widgets/custom_button.dart';

class BinRequestConfirmationPage extends StatelessWidget {
  const BinRequestConfirmationPage(
      {super.key,
      required this.binImage,
      required this.material,
      required this.price,
      required this.size});
  final String binImage;
  final String price;
  final String material;
  final String size;

  @override
  Widget build(BuildContext context) {
    // var mediaQ = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text("Confirm Bin Type"),
      ),
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 250.h),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(binImage),
                  ),
                ),
              ),
              Text(
                "Material: $material",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "Size: $size ltrs",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                "GHS $price",
                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
              ),
              (material != 'Metalic')
                  ? Text(
                      "Choose Color",
                      style: TextStyle(fontSize: 14.sp),
                    )
                  : const Text(''),
              (material != 'Metalic')
                  ? Text(
                      "(A random color is delivered if no color is selected)",
                      style: TextStyle(fontSize: 13.sp),
                    )
                  : const Text(''),
              (material != 'Metalic')
                  ? SizedBox(
                      height: 30.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const ColorSelector(
                            color: Colors.red,
                          ),
                          ColorSelector(
                            color: Colors.green[600]!,
                          ),
                          ColorSelector(
                            color: Colors.blue[600]!,
                          ),
                          const ColorSelector(
                            color: Colors.black,
                          ),
                          const ColorSelector(
                            color: Colors.yellow,
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Text(
                "Bin will be delivered on your next pickup schedule, if needed urgently place a custom order instead.",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Amount is to be paid to delivery agent on the bin's arrival",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
              Gap(20.h),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 30).w,
                child: Column(
                  children: [
                    CustomButton(
                      text: "Confirm Order",
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r)),
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.logout),
                                    Gap(0, 10.w),
                                    const Text(
                                      "Logout",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Gap(20.h),
                                    Text(
                                      "Do you really wish to logout?",
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // actions: [

                                //   TextButton(
                                //     onPressed: () {
                                //       context.pop();
                                //     },
                                //     child: const Text(
                                //       "Stay",
                                //       style: TextStyle(
                                //           fontWeight: FontWeight.bold),
                                //     ),
                                //   )
                                // ],
                              );
                            });
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    CustomOutlinedButton(
                        text: "Cancel", onPressed: () => context.pop()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
