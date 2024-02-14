import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            CustomToolbar(
              title: "Transaction Status",
              showOption: false,
              type: "Payment",
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              height: 100.h,
              width: 100.w,
              child: SvgPicture.asset(
                ImageConstant.pending,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Transaction Pending",
                style:
                satoshiRegular.copyWith(fontSize: 25.sp, color: Colors.red),
              ),
            ),
            SizedBox(
              height: 250.h,
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(RouteHelper.getBookingRoute("home"));
                },
              child: Container(
                width: 300.w,
                height: 50.h,
                decoration: const BoxDecoration(
                  color:  Color(0xffD43030),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gray6E8EE7,
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.dp16),
                  ),
                ),
                margin: const EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp30),
                child: Center(
                  child: Text(
                    "Go to Transaction History",
                    style: satoshiRegular.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
