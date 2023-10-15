import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/widgets/gap.dart';
import 'package:trash_out/widgets/giftcard.dart';

class CompanyPage extends StatefulWidget {
  const CompanyPage(
      {super.key, required this.companyName, required this.companyLogo});
  final String companyName;
  final String companyLogo;

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  List<bool> vouchertriggers = [true, true, true, true];
  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              splashRadius: 25.sp,
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: Text(widget.companyName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0).w,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: mediaQ.height * 0.2,
              width: mediaQ.width,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.grey.shade300),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(widget.companyLogo),
                ),
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            Gap(20.h),
            const Text("You can only redeem only one giftcard per month"),
            Gap(20.h),
            Wrap(
              children: [
                GestureDetector(
                  onTapDown: (onTapDown) {
                    String companyLogo = widget.companyLogo;
                    String points = "5000";
                    String price = "50";

                    context.pushNamed("cardConfirmation", pathParameters: {
                      'companyLogo': companyLogo,
                      'points': points,
                      'price': price,
                    });
                  },
                  child: GiftCard(
                      imagePath: widget.companyLogo,
                      trigger: vouchertriggers[0],
                      points: 5000,
                      price: 50),
                ),
                GestureDetector(
                  onTapDown: (onTapDown) {
                    String companyLogo = widget.companyLogo;
                    String points = "6000";
                    String price = "60";

                    context.pushNamed("cardConfirmation", pathParameters: {
                      'companyLogo': companyLogo,
                      'points': points,
                      'price': price,
                    });
                  },
                  child: GiftCard(
                      imagePath: widget.companyLogo,
                      trigger: vouchertriggers[1],
                      points: 6000,
                      price: 60),
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    String companyLogo = widget.companyLogo;
                    String points = "8000";
                    String price = "80";

                    context.pushNamed("cardConfirmation", pathParameters: {
                      'companyLogo': companyLogo,
                      'points': points,
                      'price': price,
                    });
                  },
                  child: GiftCard(
                      imagePath: widget.companyLogo,
                      trigger: vouchertriggers[2],
                      points: 8000,
                      price: 80),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTapDown: (TapDownDetails details) {
                    String companyLogo = widget.companyLogo;
                    String points = "9000";
                    String price = "90";

                    context.pushNamed("cardConfirmation", pathParameters: {
                      'companyLogo': companyLogo,
                      'points': points,
                      'price': price,
                    });
                  },
                  child: GiftCard(
                    imagePath: widget.companyLogo,
                    trigger: vouchertriggers[3],
                    points: 9000,
                    price: 90,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
