import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trash_out/utils/colors.dart';

class WasteTypeTab extends StatefulWidget {
  const WasteTypeTab(
      {Key? key, required this.label, required this.icon, required this.color})
      : super(key: key);

  final String label;
  final IconData icon;
  final Color color;

  @override
  State<WasteTypeTab> createState() => _WasteTypeTabState();
}

class _WasteTypeTabState extends State<WasteTypeTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10).w,
      height: 80.w,
      width: 90.w,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(color: KColors.green200.withOpacity(.4), width: 1.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Icon(widget.icon), Text(widget.label)],
      ),
    );
  }
}

class WasteTypeTab1 extends StatefulWidget {
  const WasteTypeTab1(
      {Key? key, required this.label, required this.icon, required this.color})
      : super(key: key);

  final String label;
  final String icon;
  final Color color;

  @override
  State<WasteTypeTab1> createState() => _WasteTypeTab1State();
}

class _WasteTypeTab1State extends State<WasteTypeTab1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10).w,
      height: 80.w,
      width: 90.w,
      decoration: BoxDecoration(
        // color: KColors.grey,
        color: widget.color,
        border: Border.all(color: KColors.green200.withOpacity(.4), width: 1.5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ImageIcon(AssetImage(widget.icon)), Text(widget.label)],
      ),
    );
  }
}
