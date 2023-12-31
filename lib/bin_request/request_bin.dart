import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trash_out/utils/colors.dart';
import 'package:trash_out/widgets/bin_types_card.dart';

class RequestBinPage extends StatelessWidget {
  const RequestBinPage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQ = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            splashRadius: 25.sp,
            onPressed: () => context.go('/profile'),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Request For Bin",
          style: TextStyle(color: Colors.black, fontSize: 20.sp),
        ),
        bottom: PreferredSize(
            preferredSize: Size(mediaQ.width, 30.h),
            child: Text(
              "Which type of bin suits your need?",
              style: TextStyle(
                  color: KColors.green300,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp),
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: mediaQ.height,
          width: mediaQ.width,
          child: ListView(
            children: [
              BinTypesCard(
                onPressed: () {
                  context.pushNamed("binConfirmationPage", pathParameters: {
                    'binImage': "assets/images/bin_type_1.png",
                    'material': "Metalic",
                    'price': '250',
                    'size': '200'
                  });
                },
                containerSize: mediaQ,
                image: "assets/images/bin_type_1.png",
                price: 250,
                size: 200,
                type: "Metalic",
              ),
              SizedBox(
                height: 15.h,
              ),
              BinTypesCard(
                onPressed: () {
                  context.pushNamed("binConfirmationPage", pathParameters: {
                    'binImage': "assets/images/bin_type_2.png",
                    'material': "Plastic",
                    'price': '230',
                    'size': '360'
                  });
                },
                containerSize: mediaQ,
                image: "assets/images/bin_type_2.png",
                price: 230,
                size: 360,
                type: "Plastic",
              ),
              SizedBox(
                height: 15.h,
              ),
              BinTypesCard(
                onPressed: () =>
                    context.pushNamed("binConfirmationPage", pathParameters: {
                  'binImage': "assets/images/bin_type_3.png",
                  'material': "Plastic",
                  'price': '550',
                  'size': '600'
                }),
                containerSize: mediaQ,
                image: "assets/images/bin_type_3.png",
                price: 550,
                size: 600,
                type: "Plastic",
              ),
              SizedBox(
                height: 15.h,
              ),
              BinTypesCard(
                onPressed: () =>
                    context.pushNamed("binConfirmationPage", pathParameters: {
                  'binImage': "assets/images/bin_type_4.png",
                  'material': "Plastic",
                  'price': '210',
                  'size': '270'
                }),
                containerSize: mediaQ,
                image: "assets/images/bin_type_4.png",
                price: 210,
                size: 270,
                type: "Plastic",
              ),
              SizedBox(
                height: 15.h,
              ),
              Container(
                height: 220.h,
                margin: const EdgeInsets.fromLTRB(5, 0, 5, 5).w,
                width: mediaQ.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15).r,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade500,
                        spreadRadius: 2,
                        blurRadius: 2),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/bin_type_general.png"),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Couldn't find the bin that suits your need?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 13.sp),
                    ),
                    Text(
                      "Don't stress, relax and place a custom order",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp,
                          color: Colors.blue),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0).w,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            shape: const StadiumBorder(),
                            fixedSize: Size(200.w, 40.h)),
                        onPressed: () {},
                        child: Text(
                          "020-0000-000",
                          style: TextStyle(
                              letterSpacing: 2,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
