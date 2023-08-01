// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/gap.dart';
import 'package:trash_out/widgets/waste_type_tab.dart';

import 'state.dart';

class DomesticWasteSpecificationPage extends ConsumerStatefulWidget {
  const DomesticWasteSpecificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DomesticWasteSpecificationPageState();
}

class _DomesticWasteSpecificationPageState
    extends ConsumerState<DomesticWasteSpecificationPage> {
  List indexes = [];
  List<String> tx() {
    List<String> types = [];

    for (final i in indexes) {
      switch (i) {
        case 0:
          types.add('Plastic');
          break;
        case 1:
          types.add('Food waste');
          break;
        case 2:
          types.add('Paper');
          break;
        case 3:
          types.add('Textile');
          break;
        case 4:
          types.add('Glass');
          break;
        case 5:
          types.add('Furniture');
          break;
        case 6:
          types.add('E-waste');
          break;
        default:
      }
    }
    return types;
  }

  final ImagePicker picker = ImagePicker();
  bool isPicked = false;
// Pick an image.
// final XFile? image = await picker.pickImage(source: ImageSource.gallery);
// Capture a photo.
// final XFile? photo = await picker.pickImage(source: ImageSource.camera);
  List<XFile?>? images;
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
          "Domestic Waste",
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
                      "assets/images/domestic.png",
                      fit: BoxFit.contain,
                    )),
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
                        icon: "assets/icons/plastic.png",
                        label: "Plastic"),
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
                        icon: "assets/icons/organic.png",
                        label: "Food waste"),
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
                        icon: "assets/icons/paper_icon.png",
                        label: "Paper"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(3))
                            ? indexes.remove(3)
                            : indexes.add(3);
                      });
                    },
                    child: WasteTypeTab1(
                        color: (indexes.contains(3))
                            ? KColors.green100
                            : KColors.grey,
                        icon: "assets/icons/shirt_icon.png",
                        label: "Textile"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(4))
                            ? indexes.remove(4)
                            : indexes.add(4);
                      });
                    },
                    child: WasteTypeTab1(
                        color: (indexes.contains(4))
                            ? KColors.green100
                            : KColors.grey,
                        icon: "assets/icons/broken_glass.png",
                        label: "Glass"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(5))
                            ? indexes.remove(5)
                            : indexes.add(5);
                      });
                    },
                    child: WasteTypeTab1(
                        color: (indexes.contains(5))
                            ? KColors.green100
                            : KColors.grey,
                        icon: "assets/icons/wood.png",
                        label: "Furniture"),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        (indexes.contains(6))
                            ? indexes.remove(6)
                            : indexes.add(6);
                      });
                    },
                    child: WasteTypeTab(
                        color: (indexes.contains(6))
                            ? KColors.green100
                            : KColors.grey,
                        icon: IcoFontIcons.microChip,
                        label: "E-waste"),
                  ),
                ],
              ),
              (!isPicked)
                  ? const Text("Upload Photo (Optional)")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Photo Uploaded"),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                images = [];
                                ref.read(imagesProvider.notifier).clearImages();
                                isPicked = false;
                              });
                            },
                            child: const Text(
                              "Clear",
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
              Gap(10.h),
              IconButton(
                icon: (!isPicked)
                    ? Icon(
                        color: KColors.green100,
                        Icons.add_photo_alternate,
                        size: 30.sp,
                      )
                    : Icon(
                        color: Colors.black,
                        IcoFontIcons.tickMark,
                        size: 30.sp,
                      ),
                onPressed: () async {
                  ref.read(imagesProvider.notifier).clearImages();
                  images = await picker.pickMultiImage().then((images) {
                    if (images.isNotEmpty) {
                      ref.read(imagesProvider.notifier).addImages(images);
                      print(images);
                      setState(() {
                        isPicked = true;
                      });
                    }
                    return null;
                  });
                },
              ),
              Gap(0, 20.w),
              CustomButton(
                  text: "Proceed to Schedule",
                  onPressed: () {
                    if (indexes.isNotEmpty) {
                      print(images.toString());
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
