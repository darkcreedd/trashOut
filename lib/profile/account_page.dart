import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:trash_out/widgets/custom_button.dart';
import 'package:trash_out/widgets/custom_textfield.dart';
import 'package:trash_out/widgets/gap.dart';

import '../widgets/custom_email_field.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        leading: IconButton(
            splashRadius: 25.sp,
            onPressed: () => context.go('/profile'),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0).w,
          child: SizedBox(
            height: mediaQ.height,
            width: mediaQ.width,
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Container(
                    height: mediaQ.height * 0.3,
                    width: mediaQ.width,
                    padding: const EdgeInsets.all(16).w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50.r,
                        ),
                        const Text("John Appleseed"),
                        const Text("johnappleseed@somewhere.com"),
                        const Text("0207644110"),
                        IconButton(
                            splashColor: Colors.black.withOpacity(0.5),
                            onPressed: () {},
                            icon: Icon(MdiIcons.cameraPlusOutline))
                      ],
                    ),
                  ),
                ),
                Gap(20.h),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Container(
                    height: mediaQ.height * 0.5,
                    width: mediaQ.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0).w,
                      child: Column(
                        children: [
                          const CustomTextField(
                              icon: IcoFontIcons.user, label: "New Username"),
                          Gap(15.h),
                          CustomEmailField(
                              icon: MdiIcons.email, label: "New Email"),
                          Gap(15.h),
                          const CustomTextField(
                              icon: IcoFontIcons.phone,
                              label: "New Mobile Number"),
                          Gap(20.h),
                          CustomButton(
                            text: "Save",
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
