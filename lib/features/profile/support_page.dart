import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25.sp,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => context.go('/profile'),
        ),
        title: const Text("Support"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
            child: Text(
          textAlign: TextAlign.center,
          "For live support reach out to us on these social media platforms\nTwitter: @darkcreeddd\nWhatsApp: 0505160795/0207644110",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
