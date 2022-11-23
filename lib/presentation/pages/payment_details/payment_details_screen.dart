import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/ticket_painter.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticket_widget/ticket_widget.dart';

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
          SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "Payment Details",
            showOption: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 43, left: 39),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter: TicketPainter(
                        borderColor: Colors.transparent,
                        bgColor: Colors.white,
                      ),
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: 18, right: 18, top: MediaQuery.of(context).size.height*0.04),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Adalaj Gam",
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGray),
                                ),
                                SvgPicture.asset(ImageConstant.iArrowRight),
                                Text(
                                  "Ahm Airport",
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.darkGray),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Route Number",
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightGray),
                                ),
                                Text(
                                  "Bus Service",
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightGray),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        ImageConstant.iBus,
                                        color: AppColors.darkGray,
                                        width: 14,
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "4U",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkGray),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        ImageConstant.iRightGrayArrow,
                                        color: AppColors.darkGray,
                                        width: 14,
                                        height: 14,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SvgPicture.asset(
                                        ImageConstant.iBus,
                                        color: AppColors.darkGray,
                                        width: 14,
                                        height: 16,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "18S",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.darkGray),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "AMTS",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkGray),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.07),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Boarding Point",
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Adalaj Gam",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkGray),
                                  ),
                                  Text(
                                    "15 Oct 2022, 09:34 PM",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkGray),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Dropping Point",
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Ahm Airport",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkGray),
                                  ),
                                  Text(
                                    "15 Oct 2022, 10:54 PM",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.darkGray),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.08),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Travellers",
                                  style: satoshiRegular.copyWith(
                                      fontSize: Dimensions.dp12,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightGray),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    ImageConstant.iSelectedMan,
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    "Amit Yogi",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.darkGray),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  Text(
                                    "28 yrs",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp16,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.darkGray),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.08),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Total Fare (For 1 seat)",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkGray),
                                      ),
                                      Text(
                                        "₹50.00",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14,
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
                                            fontSize: Dimensions.dp14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkGray),
                                      ),
                                      Text(
                                        "₹10.00",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14,
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
                                            fontSize: Dimensions.dp14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkGray),
                                      ),
                                      Text(
                                        "₹60.00",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkGray),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Net Payable",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.darkGray),
                                  ),
                                  SvgPicture.asset(
                                    ImageConstant.iTopRedArrow,
                                    height: 7,
                                    width: 14,
                                    color: AppColors.primaryColor,
                                  ),
                                  Text(
                                    "₹60.00",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primaryColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
