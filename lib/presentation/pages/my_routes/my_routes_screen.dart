import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/responseModels/my_routes_internal_model.dart';

class MyRoutesScreen extends StatefulWidget {
  const MyRoutesScreen({Key? key}) : super(key: key);

  @override
  _MyRoutesScreenState createState() => _MyRoutesScreenState();
}

class _MyRoutesScreenState extends State<MyRoutesScreen> {
  List<MyRouteInternalModel> routeList = [];

  @override
  void initState() {
    super.initState();
    routeList.add(MyRouteInternalModel("Adalaj Gam", "Ahm Airport", true, "15 Oct 2022, 10:54 PM"));
    routeList.add(MyRouteInternalModel("Adalaj Gam", "Ahm Airport", true, "15 Oct 2022, 10:54 PM"));
    routeList.add(MyRouteInternalModel("Adalaj Gam", "Ahm Airport", true, "15 Oct 2022, 10:54 PM"));
    routeList.add(MyRouteInternalModel("Adalaj Gam", "Ahm Airport", true, "15 Oct 2022, 10:54 PM"));
    routeList.add(MyRouteInternalModel("Adalaj Gam", "Ahm Airport", true, "15 Oct 2022, 10:54 PM"));
    routeList.add(MyRouteInternalModel("Adalaj Gam", "Ahm Airport", true, "15 Oct 2022, 10:54 PM"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(
        children: [
          const SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "My Routes",
            showOption: false,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: routeList.length,
                itemBuilder: (context, index) {
                  return getMyRoutesWidget(routeList[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget getMyRoutesWidget(MyRouteInternalModel model) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 24),
      margin: const EdgeInsets.only(
          left: Dimensions.dp24, right: Dimensions.dp24, bottom: Dimensions.dp20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    model.source,
                    style: satoshiRegular.copyWith(
                        fontSize: Dimensions.dp16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGray),
                  ),
                  const SizedBox(
                    width: 19,
                  ),
                  SvgPicture.asset(ImageConstant.iArrowRight),
                  const SizedBox(
                    width: 19,
                  ),
                  Text(
                    model.destination,
                    style: satoshiRegular.copyWith(
                        fontSize: Dimensions.dp16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGray),
                  ),
                ],
              ),
              SvgPicture.asset(ImageConstant.iFavorite),
            ],
          ),
          Text(model.schedule,
              style: satoshiRegular.copyWith(
                  fontSize: Dimensions.dp10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray)),
        ],
      ),
    );
  }
}
