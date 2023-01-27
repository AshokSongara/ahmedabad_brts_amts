import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchRouteNumberScreen extends StatefulWidget {
  const SearchRouteNumberScreen({Key? key}) : super(key: key);

  @override
  _SearchRouteNumberScreenState createState() =>
      _SearchRouteNumberScreenState();
}

class _SearchRouteNumberScreenState extends State<SearchRouteNumberScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(
        children: [
          const SizedBox(height: Dimensions.dp25),
          const CustomToolbar(
            title: "Search Route Number",
            showOption: false,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              margin: const EdgeInsets.only(
                  left: Dimensions.dp24,
                  right: Dimensions.dp24,
                  bottom: Dimensions.dp20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray6E8EE7,
                    blurRadius: 5.0,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(Dimensions.dp10),
                ),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: Dimensions.dp5.h, bottom: Dimensions.dp5.h),
                      child: const Divider(
                        color: AppColors.darkGray,
                      ),
                    );
                  },
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.dp20.w, right: Dimensions.dp20.w),
                        child: getSearchRouteWidget());
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSearchRouteWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    height: 25.h,
                    width: 22.w,
                    child: SvgPicture.asset(
                      ImageConstant.iRedBus,
                      color: Theme.of(context).primaryColor,
                    )),
                const SizedBox(
                  width: 19,
                ),
                Text(
                  "01",
                  style: satoshiRegular.copyWith(
                      fontSize: Dimensions.dp24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkGray),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: Dimensions.dp5.h,),
        Text(
            "ADAJAN G.S.R.T.C RAILWAY STATION\nTERMINAL-ADAJAN G.S.R.T.C (CLOCKWISE)",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: satoshiRegular.copyWith(
                fontSize: Dimensions.dp15.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.darkGray)),
      ],
    );
  }
}
