import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchResultItem extends StatelessWidget {
  const SearchResultItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp20),
                child: Row(
                  children: [
                    Card(
                      color: Colors.white,
                      child: Container(
                          height: 40,
                          padding: EdgeInsets.all(5),
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Image.asset(ImageConstant.iJanmarg)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "21.40 Km",
                        style: satoshiRegularSmall.copyWith(
                            color: AppColors.darkGray),
                      ),
                    ),
                    Text(
                      "1 hr 19 min",
                      style: satoshiRegularSmall.copyWith(
                          color: AppColors.darkGray, fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.dp15,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp20),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "11:38 AM",
                          style:
                              screenTitle.copyWith(fontSize: Dimensions.dp18),
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
                        margin: EdgeInsets.only(left: 15, right: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.grayD0D0D0,
                              ),
                            ),
                            Container(
                              height: 2,
                              width: 40,
                              color: AppColors.grayD0D0D0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              width: 45,
                              height: 45,
                              child: SvgPicture.asset(ImageConstant.iBus),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.red),
                            ),
                            Container(
                              height: 2,
                              width: 40,
                              color: AppColors.grayD0D0D0,
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
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
                          "12:57 PM",
                          style:
                              screenTitle.copyWith(fontSize: Dimensions.dp18),
                        ),
                        Align(
                          child: const Text(
                            "Arrive",
                            style: satoshiSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.dp15,
              ),
              Container(
                height: 0.5,
                color: AppColors.gray6E8EE7,
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp20),
                child: Row(
                  children: [
                    SvgPicture.asset(ImageConstant.iRedBus),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "4U",
                      style: satoshiSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                    SvgPicture.asset(ImageConstant.iRightGrayArrow),
                    SvgPicture.asset(ImageConstant.iRedBus),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      "15D",
                      style: satoshiSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 0.5,
                color: AppColors.gray6E8EE7,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp20, right: Dimensions.dp20),
                child: Row(
                  children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(ImageConstant.iRoute)),
                    SizedBox(
                      width: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Change at ",
                        style: satoshiRegular.copyWith(
                            fontSize: 12, color: AppColors.darkGray),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Ranip Cross Road  ",
                              style: satoshiRegularSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                  color: AppColors.darkGray)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: Dimensions.dp20,
                    right: Dimensions.dp20,
                    bottom: Dimensions.dp10),
                child: Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(5),
                        decoration: new BoxDecoration(
                          color: AppColors.lightPink,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(ImageConstant.iInfo),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Route Details",
                                style: satoshiRegularSmall.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    color: AppColors.primaryColor)),
                          ],
                        )),
                    Spacer(),
                    RichText(
                      text: TextSpan(
                        text: "From  ",
                        style: satoshiRegular.copyWith(
                            fontSize: 14.5, color: AppColors.darkGray),
                        children: <TextSpan>[
                          TextSpan(
                              text: "₹50.00",
                              style: satoshiRegularSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19,
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
