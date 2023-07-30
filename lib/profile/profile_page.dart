import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:trash_out/state/auth.dart';
import 'package:trash_out/state/firebase_authentication.dart';
import 'package:trash_out/state/user_state.dart';
import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/gap.dart';
import 'package:trash_out/widgets/profile_tab.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    final user = ref.watch(userDetailsNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: mediaQ.height * 0.25,
              width: mediaQ.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35.r,
                  ),
                  Gap(10.h),
                  // Text(user.email),
                  Text(FirebaseAuth.instance.currentUser!.displayName!),

                  const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on_outlined),
                      Text("College of Science, KNUST"),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.go('/account'),
                    child: Container(
                      height: 40,
                      width: 130,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: KColors.green200,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Edit Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(20.h),
            Expanded(
              child: Container(
                width: mediaQ.width,
                padding: const EdgeInsets.all(16).w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Gap(15.h),
                    GestureDetector(
                      onTap: () => context.go('/requestBin'),
                      behavior: HitTestBehavior.translucent,
                      child: ProfileTab(
                        mediaQ: mediaQ,
                        icon: IcoFontIcons.trash,
                        title: "Request Bin",
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () => context.go('/notifications'),
                      behavior: HitTestBehavior.translucent,
                      child: ProfileTab(
                        mediaQ: mediaQ,
                        icon: Icons.notifications_active_outlined,
                        title: "Notification",
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () => context.go('/support'),
                      behavior: HitTestBehavior.translucent,
                      child: ProfileTab(
                        mediaQ: mediaQ,
                        icon: IcoFontIcons.liveSupport,
                        title: "Support",
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    GestureDetector(
                      onTap: () => context.go('/about'),
                      behavior: HitTestBehavior.translucent,
                      child: ProfileTab(
                        mediaQ: mediaQ,
                        icon: Icons.info_outline,
                        title: "About App",
                      ),
                    ),
                    const Divider(
                      thickness: 1.5,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
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
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      FirebaseAuthService().signOut().then(
                                          (value) => context.go('/signIn'));
                                    },
                                    child: const Text(
                                      "Leave",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.pop();
                                    },
                                    child: const Text(
                                      "Stay",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: ProfileTab(
                        mediaQ: mediaQ,
                        icon: Icons.logout,
                        title: "Logout",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
