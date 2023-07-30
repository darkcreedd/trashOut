import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const Gap([this.height, this.width]);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
    );
  }
}
