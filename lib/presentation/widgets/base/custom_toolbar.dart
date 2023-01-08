import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomToolbar extends StatelessWidget {
  CustomToolbar(
      {Key? key,
      required this.title,
      this.showOption = true,
        this.actionWidget,
        this.showFavourite = false,
      this.back = true})
      : super(key: key);
  final String title;
  final bool showOption;
  final bool showFavourite;
  final bool back;
  final Widget? actionWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(left: Dimensions.dp15, right: Dimensions.dp20),
      padding:
          const EdgeInsets.only(top: Dimensions.dp10, bottom: Dimensions.dp10),
      child: Row(
        children: [
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Visibility(
                  visible: back,
                  child: SvgPicture.asset(ImageConstant.iLeftArrow))),
          Expanded(
            child: Center(
              child: Text(
                AppLocalizations.of(context)?.translate(title) ?? "",
                style: screenTitle,
              ),
            ),
          ),
          if (showOption) SvgPicture.asset(ImageConstant.iThreeDots),
          if (showFavourite)
            SvgPicture.asset(ImageConstant.iEmptyFavorite,
                color: Theme.of(context).primaryColor),
          if(actionWidget!=null) actionWidget!,
        ],
      ),
    );
  }
}
