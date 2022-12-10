import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RouteTitleWidget extends StatelessWidget {
  final String startRouteName;
  final String endRouteName;

  RouteTitleWidget(
      {Key? key,
      required this.mainAxisAlignment,
      required this.startRouteName,
      required this.endRouteName})
      : super(key: key);

  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.all(Dimensions.dp15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            startRouteName,
            style: satoshiRegularSmall,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SvgPicture.asset(ImageConstant.iWhiteRightArrow),
          ),
          Text(
            endRouteName,
            style: satoshiRegularSmall,
          )
        ],
      ),
    );
  }
}
