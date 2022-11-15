import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomToolbar extends StatelessWidget {
  CustomToolbar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.dp15, right: Dimensions.dp20),
      padding: EdgeInsets.only(top: Dimensions.dp10, bottom: Dimensions.dp10),
      child: Row(
        children: [
          SvgPicture.asset(ImageConstant.iLeftArrow),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: screenTitle,
              ),
            ),
          ),
          SvgPicture.asset(ImageConstant.iThreeDots),
        ],
      ),
    );
  }
}
