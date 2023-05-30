import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/responsemodels/search_route_response.dart';

class SearchResultItem extends StatelessWidget {
  final Data routeResult;
  final String? serviceType;

  const SearchResultItem(
      {Key? key, required this.routeResult, required this.serviceType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp20),
                child: Row(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Container(
                          height: 40,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: serviceType == "AMTS"
                              ? Image.asset(ImageConstant.iAMTS)
                              : Image.asset(ImageConstant.iJanmarg)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "${roundDouble(routeResult.totalDistance, 2)} Km",
                        style: satoshiRegularSmall.copyWith(
                            color: AppColors.darkGray),
                      ),
                    ),
                    Text(
                      "${routeResult.totalTime} Min",
                      style: satoshiRegularSmall.copyWith(
                          color: AppColors.darkGray, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.dp15,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          routeResult.startTime ?? "",
                          style: screenTitle.copyWith(
                              fontSize: Dimensions.dp18.sp),
                        ),
                        Text(
                          "Depart",
                          style: satoshiSmall,
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grayD0D0D0,
                              ),
                            ),
                            Container(
                              height: 2,
                              width: 37,
                              color: AppColors.grayD0D0D0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: 45,
                              height: 45,
                              child: SvgPicture.asset(ImageConstant.iBus,),
                              decoration:  BoxDecoration(
                                  shape: BoxShape.circle, color : Theme.of(context).primaryColor,),
                            ),
                            Container(
                              height: 2,
                              width: 37,
                              color: AppColors.grayD0D0D0,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grayD0D0D0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          routeResult.endTime ?? "",
                          style: screenTitle.copyWith(
                              fontSize: Dimensions.dp18.sp),
                        ),
                        Align(
                          child: Text(
                            "Arrive",
                            style: satoshiSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimensions.dp15,
              ),
              Container(
                height: 0.5,
                color: AppColors.gray6E8EE7,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp20),
                height: 60.h,
                width: double.infinity,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: routeResult.routes!.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.dp5, right: Dimensions.dp5),
                          child:
                              SvgPicture.asset(ImageConstant.iRightGrayArrow)),
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        SvgPicture.asset(ImageConstant.iRedBus,color: Theme.of(context).primaryColor,),
                        const SizedBox(
                          width: 3,
                        ),
                        Text(
                          routeResult.routes![index],
                          style: satoshiSmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                height: 0.5,
                color: AppColors.gray6E8EE7,
              ),
              const SizedBox(
                height: 5,
              ),
              routeResult.interChanges!.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.dp20, right: Dimensions.dp20),
                      child: Row(
                        children: [
                          SizedBox(
                              height: 20,
                              width: 20,
                              child: SvgPicture.asset(ImageConstant.iRoute,color: Theme.of(context).primaryColor,)),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "Change at ",
                                style: satoshiRegular.copyWith(
                                    fontSize: 12.sp, color: AppColors.darkGray),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: routeResult.interChanges![0],
                                      style: satoshiRegularSmall.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.sp,
                                          color: AppColors.darkGray,
                                        overflow: TextOverflow.ellipsis,)),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.dp20,
                    right: Dimensions.dp20,
                    bottom: Dimensions.dp10),
                child: Row(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: AppColors.lightPink,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageConstant.iInfo,color: Theme.of(context).primaryColor,),
                            const SizedBox(
                              width: 5,
                            ),
                            Text("Route Details",
                                style: satoshiRegularSmall.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10.sp,
                                    color: Theme.of(context).primaryColor)),
                          ],
                        )),
                    const Spacer(),
                    RichText(
                      text: TextSpan(
                        text: "Fare  ",
                        style: satoshiRegular.copyWith(
                            fontSize: 14.5.sp, color: AppColors.darkGray),
                        children: <TextSpan>[
                          TextSpan(
                              text: "₹${getFare(routeResult.fare ?? 0)}",
                              style: satoshiRegularSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19.sp,
                                  color: AppColors.darkGray)),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
