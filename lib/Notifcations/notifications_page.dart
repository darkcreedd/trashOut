import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            splashRadius: 25.sp,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () => context.go('/profile'),
          ),
          title: const Text("Notifications")),
      body: Padding(
        padding: const EdgeInsets.all(16.0).w,
        child: SizedBox(
          height: mediaQ.height,
          width: mediaQ.width,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.notifications_off_outlined,
                size: 150.sp,
              ),
              const Text("No New Notifications"),
            ],
          ),
        ),
      ),
    );
  }
}
