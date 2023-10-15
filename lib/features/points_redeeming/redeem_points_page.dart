// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/widgets/company_card.dart';

class RedeemPointsPage extends StatefulWidget {
  const RedeemPointsPage({super.key});

  @override
  State<RedeemPointsPage> createState() => _RedeemPointsPageState();
}

class _RedeemPointsPageState extends State<RedeemPointsPage> {
  List cards = [
    "assets/compcards/amazon_card.png",
    "assets/compcards/kikuu_card.png",
    "assets/compcards/walmart_card.png",
    "assets/compcards/jumia_card.png",
    "assets/compcards/melcom_card.png",
    "assets/compcards/costco_card.png",
  ];

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.sizeOf(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => context.go('/home'),
              splashRadius: 25.r,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          title: const Text("Redeem Points"),
          bottom: PreferredSize(
              preferredSize: Size(mediaQ.width, 50.h),
              child: const Text(
                  "Redeem points as gift card from one of these shops")),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20).w,
          child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 16 / 10,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            children: [
              GestureDetector(
                onTap: () {
                  String companyName = "Amazon";
                  String companyLogo = "assets/compcards/amazon_card.png";
                  context.pushNamed("companyPage", pathParameters: {
                    'companyName': companyName,
                    'companyLogo': companyLogo
                  });
                },
                child: CompanyCard(
                  companyLogo: cards[0],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String companyName = "Kikuu";
                  String companyLogo = "assets/compcards/kikuu_card.png";
                  context.pushNamed("companyPage", pathParameters: {
                    'companyName': companyName,
                    'companyLogo': companyLogo
                  });
                },
                child: CompanyCard(
                  companyLogo: cards[1],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String companyName = "Walmart";
                  String companyLogo = "assets/compcards/walmart_card.png";
                  context.pushNamed("companyPage", pathParameters: {
                    'companyName': companyName,
                    'companyLogo': companyLogo
                  });
                },
                child: CompanyCard(
                  companyLogo: cards[2],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String companyName = "Jumia";
                  String companyLogo = "assets/compcards/jumia_card.png";
                  context.pushNamed("companyPage", pathParameters: {
                    'companyName': companyName,
                    'companyLogo': companyLogo
                  });
                },
                child: CompanyCard(
                  companyLogo: cards[3],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String companyName = "Melcom";
                  String companyLogo = "assets/compcards/melcom_card.png";
                  context.pushNamed("companyPage", pathParameters: {
                    'companyName': companyName,
                    'companyLogo': companyLogo
                  });
                },
                child: CompanyCard(
                  companyLogo: cards[4],
                ),
              ),
              GestureDetector(
                onTap: () {
                  String companyName = "Costco";
                  String companyLogo = "assets/compcards/costco_card.png";
                  context.pushNamed("companyPage", pathParameters: {
                    'companyName': companyName,
                    'companyLogo': companyLogo
                  });
                },
                child: CompanyCard(
                  companyLogo: cards[5],
                ),
              )
            ],
          ),
        ));
  }
}
