import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';

class RouteTitleWidget extends StatelessWidget {
  final MainAxisAlignment mainAxisAlignment;
  final String startRouteName;
  final String endRouteName;
  final bool from;

  RouteTitleWidget(
      {Key? key,
        required this.mainAxisAlignment,
        required this.startRouteName,
        required this.endRouteName,
        required this.from})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.all(Dimensions.dp15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Center(
              child: Text(
                startRouteName,
                overflow: TextOverflow.ellipsis,
                style: satoshiRegularSmall,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SvgPicture.asset(ImageConstant.iWhiteRightArrow),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Center(
                child: Text(
                  endRouteName,
                  style: satoshiRegularSmall,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
