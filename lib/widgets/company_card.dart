import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({
    super.key,
    required this.companyLogo,
  });

  final String companyLogo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        height: 100,
        width: 200,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(companyLogo)),
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.white),
      ),
    );
  }
}
