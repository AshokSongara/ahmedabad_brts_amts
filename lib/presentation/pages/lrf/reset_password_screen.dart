import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)),
              child: AspectRatio(
                aspectRatio: 1 / 0.35,
                child: Container(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: Dimensions.dp20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: Dimensions.dp25),
                  child: Row(children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset(ImageConstant.iLeftArrow)),
                    Text(
                      "Reset Password",
                      style: satoshiRegular.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGray),
                    ),
                  ]),
                ),
                const SizedBox(
                  height: Dimensions.dp20,
                ),
                Container(
                  margin: const EdgeInsets.only(
                      left: Dimensions.dp35, right: Dimensions.dp35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Under Development",
                        style: satoshiRegular.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.darkGray),
                      ),
                      const SizedBox(
                        height: Dimensions.dp75,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }

}
