// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icofont_flutter/icofont_flutter.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';
import 'package:trash_out/widgets/waste_type_tab.dart';

import 'state.dart';

class IndustrialWasteSpecificationPage extends ConsumerStatefulWidget {
  const IndustrialWasteSpecificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _IndustrialWasteSpecificationPageState();
}

class _IndustrialWasteSpecificationPageState
    extends ConsumerState<IndustrialWasteSpecificationPage> {
  List indexes = [];
  List<String> tx() {
    List<String> types = [];

    for (final i in indexes) {
      switch (i) {
        case 0:
          types.add('Manufacturing');
          break;
        case 1:
          types.add('Hazardous');
          break;
        case 2:
          types.add('Construction');
          break;
        case 3:
          types.add('E-waste');
          break;
        default:
      }
    }
    return types;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            splashRadius: 25.sp,
            onPressed: () => context.go('/home'),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          "Industrial Waste",
          style: TextStyle(fontFamily: 'Sen'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).w,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: mediaQ.height * 0.2,
                width: mediaQ.width,
                decoration: BoxDecoration(
                  color: KColors.green100,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: SizedBox(
                  height: mediaQ.height * 0.2 - 50,
                  width: mediaQ.width * 0.7,
                  child: Image.asset(
                    "assets/images/industry.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Gap(15.h),
              Text(
                "Select your Garbage type",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
              ),
              Gap(15.h),
              Wrap(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(0))
                            ? indexes.remove(0)
                            : indexes.add(0);
                      });
                    },
                    child: WasteTypeTab1(
                        color: (indexes.contains(0))
                            ? KColors.green100
                            : KColors.grey,
                        icon: "assets/icons/production_icon.png",
                        label: "Production"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(1))
                            ? indexes.remove(1)
                            : indexes.add(1);
                      });
                    },
                    child: WasteTypeTab1(
                        color: (indexes.contains(1))
                            ? KColors.green100
                            : KColors.grey,
                        icon: 'assets/icons/hazardous_icon.png',
                        label: "Hazardous"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(2))
                            ? indexes.remove(2)
                            : indexes.add(2);
                      });
                    },
                    child: WasteTypeTab1(
                        color: (indexes.contains(2))
                            ? KColors.green100
                            : KColors.grey,
                        icon: 'assets/icons/construction_icon.png',
                        label: "Construction"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(3))
                            ? indexes.remove(3)
                            : indexes.add(3);
                      });
                    },
                    child: WasteTypeTab(
                        color: (indexes.contains(3))
                            ? KColors.green100
                            : KColors.grey,
                        icon: IcoFontIcons.microChip,
                        label: "E-waste"),
                  ),
                ],
              ),
              const Text("Upload Photo Instead"),
              Gap(10.h),
              IconButton(
                splashRadius: 25.sp,
                icon: const Icon(Icons.camera_alt),
                onPressed: () {},
              ),
              Gap(10.h),
              CustomButton(
                  text: "Proceed to Schedule",
                  onPressed: () {
                    if (indexes.isNotEmpty) {
                      List<String> selectedTypes = tx();
                      ref
                          .read(wasteTypesProvider.notifier)
                          .addWasteType(selectedTypes);
                      context.pushNamed('date');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Select at least one waste type to proceed."),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
