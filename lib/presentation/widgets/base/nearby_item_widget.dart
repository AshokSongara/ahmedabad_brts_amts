import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/image_constant.dart';
import '../../../utils/styles.dart';

class NearByItemWidget extends StatelessWidget {
  const NearByItemWidget({Key? key, required this.nearme}) : super(key: key);

  final Data nearme;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: Dimensions.dp10,
          top: Dimensions.dp15,
          right: Dimensions.dp10,
          bottom: Dimensions.dp15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: SvgPicture.asset(ImageConstant.iClock,color: Theme.of(context).primaryColor,),
          ),
          Expanded(
            child: Text(
              nearme.stopName ?? "",
              style: satoshiRegularSmall.copyWith(color: AppColors.darkGray),
            ),
          ),
          Text(
            getDistanceInMeters(nearme.distance.toString()),
            style: satoshiRegularSmall.copyWith(
                color: AppColors.gray777777, fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
