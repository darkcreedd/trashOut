import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

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
        title: const Text("About App"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
            child: Text(
          textAlign: TextAlign.center,
          "This is a waste management app prototype, a possible solution to waste management issues in our society. Developed by Ofosu Effah Samuel as a mini project.",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
