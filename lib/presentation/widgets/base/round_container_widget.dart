import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RoundContainerWidget extends StatelessWidget {
  const RoundContainerWidget(
      {Key? key, required this.imagePath, required this.menuTitle})
      : super(key: key);
  final String imagePath;
  final String menuTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(RouteHelper.getLoginRoute());
      },
      child: Container(
        height: Dimensions.dp56,
        margin:
            const EdgeInsets.only(left: Dimensions.dp30, right: Dimensions.dp30),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.buttonColor,
            ),
            color: AppColors.buttonColor,
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.dp8))),
        child: Container(
          margin: const EdgeInsets.only(left: Dimensions.dp50),
          child: Row(children: [
            SvgPicture.asset(imagePath),
            const SizedBox(
              width: Dimensions.dp10,
            ),
            Text(
              menuTitle,
              style: satoshiRegular.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
