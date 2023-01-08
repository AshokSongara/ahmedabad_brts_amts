

import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/dashed_line_widget.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: Column(
        children: [
          const SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "Payment Details",
            showOption: false,
            actionWidget: Container(
              padding: const EdgeInsets.all(Dimensions.dp3),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      Dimensions.dp5,
                    ),
                  ),
                  border: Border.all(color: AppColors.primaryColor)),
              child: Row(
                children: [
                  SvgPicture.asset(ImageConstant.iRedTime,color: AppColors.primaryColor,),
                  const SizedBox(width: Dimensions.dp4,),
                  Text("10:10 mins",
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor)),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: Dimensions.dp43, left: Dimensions.dp39),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimensions.dp24,
                          right: Dimensions.dp24,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gray6E8EE7,
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.dp15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: Dimensions.dp20, right: Dimensions.dp27, left: Dimensions.dp27),
                              child: Text(
                                "Scan at your bording gate",
                                textAlign: TextAlign.center,
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.lightGray),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: SvgPicture.asset(
                                        ImageConstant.iLeftArrow)),
                                Expanded(
                                    flex: 2,
                                    child: Image.asset(ImageConstant.iBarcode)),
                                Expanded(
                                    flex: 1,
                                    child: RotatedBox(
                                        quarterTurns: 2,
                                        child: SvgPicture.asset(
                                          ImageConstant.iLeftArrow,
                                        ))),
                              ],
                            ),
                            Text(
                              "Passenger 01",
                              textAlign: TextAlign.center,
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.darkGray),
                            ),
                            SizedBox(
                              height: Dimensions.dp15,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          left: Dimensions.dp24,
                          right: Dimensions.dp24,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gray6E8EE7,
                              blurRadius: 3.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.dp15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: Dimensions.dp8, right: Dimensions.dp8),
                              child: DashLineView(
                                fillRate: 0.6,
                                dashColor: AppColors.grayC4C$C$,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimensions.dp23),
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: Dimensions.dp33),
                                    padding: EdgeInsets.all(Dimensions.dp8),
                                    decoration: const BoxDecoration(
                                      color: AppColors.greyF6F6F6,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(Dimensions.dp6),
                                      ),
                                    ),
                                    child: Text(
                                      "The validity period is 2 hours and the entry time is 15 minutes.",
                                      textAlign: TextAlign.center,
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.darkGray),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp12,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Fatakwadi",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkGray),
                                      ),
                                      SvgPicture.asset(
                                          ImageConstant.iArrowRight),
                                      Text(
                                        "Canal Juction VIP Road",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkGray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp8,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Route Number",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.lightGray),
                                      ),
                                      Text(
                                        "Ticket Number",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.lightGray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp4,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            ImageConstant.iRedBus,
                                            color: AppColors.darkGray,
                                          ),
                                          const SizedBox(
                                            width: Dimensions.dp3,
                                          ),
                                          Text(
                                            "4U",
                                            style: satoshiSmall.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.darkGray),
                                          ),
                                          const SizedBox(
                                            width: Dimensions.dp8,
                                          ),
                                          SvgPicture.asset(
                                              ImageConstant.iRightGrayArrow),
                                          const SizedBox(
                                            width: Dimensions.dp8,
                                          ),
                                          SvgPicture.asset(
                                            ImageConstant.iRedBus,
                                            color: AppColors.darkGray,
                                          ),
                                          const SizedBox(
                                            width: Dimensions.dp4,
                                          ),
                                          Text(
                                            "15D",
                                            style: satoshiSmall.copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.darkGray),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "500100122395034",
                                        style: satoshiSmall.copyWith(
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkGray),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp25,
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: AppColors.lightGray,
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp15,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Passenger",
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.lightGray),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Adults",
                                                style: satoshiRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.dp12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.darkGray),
                                              ),
                                              Text(
                                                "2",
                                                style: satoshiRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.dp16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.darkGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 30,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Kids",
                                                style: satoshiRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.dp12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.darkGray),
                                              ),
                                              Text(
                                                "0",
                                                style: satoshiRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.dp16.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.darkGray),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Total",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp12.sp,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.darkGray),
                                          ),
                                          Text(
                                            "2",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp16.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.darkGray),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp25,
                                  ),
                                  const Divider(
                                    height: 1,
                                    color: AppColors.lightGray,
                                  ),
                                  SizedBox(
                                    height: Dimensions.dp15,
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total Fare",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGray),
                                          ),
                                          Text(
                                            "₹50.00",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGray),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "GST Amount",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGray),
                                          ),
                                          Text(
                                            "₹10.00",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGray),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Free cancellation charge",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGray),
                                          ),
                                          Text(
                                            "₹60.00",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.darkGray),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Net Payable",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkGray),
                                      ),
                                      Text(
                                        "₹60.00",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14.sp,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: Dimensions.dp15,
                                  ),
                                  SvgPicture.asset(
                                    ImageConstant.iTopRedArrow,
                                    height: Dimensions.dp7,
                                    width: Dimensions.dp14,
                                  ),
                                  const SizedBox(
                                    height: Dimensions.dp21,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: Dimensions.dp20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}