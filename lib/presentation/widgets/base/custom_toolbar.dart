import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomToolbar extends StatelessWidget {
  CustomToolbar({Key? key, required this.title,this.showOption=true,this.showFavourite = false}) : super(key: key);
  final String title;
  final bool showOption;
  final bool showFavourite;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: Dimensions.dp15, right: Dimensions.dp20),
      padding: const EdgeInsets.only(top: Dimensions.dp10, bottom: Dimensions.dp10),
      child: Row(
        children: [
          GestureDetector(onTap: (){
            Navigator.of(context).pop();
          }, child: SvgPicture.asset(ImageConstant.iLeftArrow)),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: screenTitle,
              ),
            ),
          ),
          if(showOption)
          SvgPicture.asset(ImageConstant.iThreeDots),
          if (showFavourite) SvgPicture.asset(ImageConstant.iEmptyFavorite,color: AppColors.primaryColor,),
        ],
      ),
    );
  }
}
