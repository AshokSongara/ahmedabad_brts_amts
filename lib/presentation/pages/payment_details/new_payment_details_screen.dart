import 'dart:convert';

import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/dashed_line_widget.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/full_screen_qr_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewPaymentDetailsScreen extends StatefulWidget {
  final String qrCode;
  final String serviceType;
  final String passName;
  final String ticketNo;
  final String sourceStopName;
  final String destinationStopName;
  final String routeCode;
  final String ticketType;
  final String fareAmt;
  final String length;

  const NewPaymentDetailsScreen({Key? key, required this.qrCode, required this.serviceType, required this.passName, required this.ticketNo, required this.sourceStopName, required this.destinationStopName, required this.routeCode, required this.ticketType, required this.fareAmt, required this.length}) : super(key: key);

  @override
  State<NewPaymentDetailsScreen> createState() => _NewPaymentDetailsScreenState();
}

class _NewPaymentDetailsScreenState extends State<NewPaymentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            CustomToolbar(
              title: "payment_details",
              type: "Payment",
              showOption: false,
              actionWidget: Container(
                padding: const EdgeInsets.all(Dimensions.dp3),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        Dimensions.dp5,
                      ),
                    ),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      ImageConstant.iRedTime,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: Dimensions.dp4,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                          right: Dimensions.dp43,
                          left: Dimensions.dp39),
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
                                    top: Dimensions.dp20,
                                    right: Dimensions.dp27,
                                    left: Dimensions.dp27),
                                child: Text(
                                  "Scan at your boarding gate",
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
                                      flex: 2,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            child: Image.memory(
                                                base64Decode(widget
                                                    .qrCode ??
                                                    "")),
                                            onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenQr(
                                                        qrCode: widget
                                                            .qrCode ??
                                                            ""),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            widget.serviceType ?? "",
                                            textAlign: TextAlign.center,
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp18.sp,
                                                fontWeight: FontWeight.w500,
                                                color:  widget.serviceType == "BRTS" ?AppColors.lightBlue : Color(0xffD43030)),),
                                          Text(
                                            widget.passName ?? "",
                                            textAlign: TextAlign.center,
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp14.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.lightBlue),),
                                          Text(
                                            "Click on QR code to expand",
                                            textAlign: TextAlign.center,
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.lightGray),),
                                          SizedBox(height: 5,),
                                          Text(
                                            widget.ticketNo ??
                                                "",
                                            textAlign: TextAlign.center,
                                            style:
                                            satoshiRegular.copyWith(
                                                fontSize: Dimensions
                                                    .dp12.sp,
                                                fontWeight:
                                                FontWeight.w500,
                                                color: AppColors
                                                    .darkGray),
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                              const SizedBox(
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
                                padding: EdgeInsets.only(
                                    left: Dimensions.dp8,
                                    right: Dimensions.dp8),
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
                                      margin: const EdgeInsets.only(
                                          top: Dimensions.dp33),
                                      padding: const EdgeInsets.all(
                                          Dimensions.dp8),
                                      decoration: const BoxDecoration(
                                        color: AppColors.greyF6F6F6,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              Dimensions.dp6),
                                        ),
                                      ),
                                      child: Text(
                                        "The validity period is 3 hours and the entry time is 15 minutes.",
                                        textAlign: TextAlign.center,
                                        style: satoshiRegular.copyWith(
                                            fontSize:
                                            Dimensions.dp12.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.darkGray),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp12,
                                    ),
                                    widget.sourceStopName! == "OneDayPass" ? Container()  :Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            widget
                                                .sourceStopName ??
                                                "",
                                            style: satoshiRegular
                                                .copyWith(
                                                fontSize: Dimensions
                                                    .dp16.sp,
                                                fontWeight:
                                                FontWeight.w500,
                                                color: AppColors
                                                    .darkGray,
                                                overflow:
                                                TextOverflow
                                                    .ellipsis),
                                          ),
                                        ),
                                        SvgPicture.asset(
                                            ImageConstant.iArrowRight),
                                        Expanded(
                                          child: Align(
                                            alignment:
                                            Alignment.centerRight,
                                            child: Text(
                                              widget
                                                  .destinationStopName ??
                                                  "",
                                              style: satoshiRegular
                                                  .copyWith(
                                                  fontSize:
                                                  Dimensions
                                                      .dp16.sp,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  color: AppColors
                                                      .darkGray,
                                                  overflow:
                                                  TextOverflow
                                                      .ellipsis),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp8,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          "Route Number",
                                          style:
                                          satoshiRegular.copyWith(
                                              fontSize: Dimensions
                                                  .dp12.sp,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: AppColors
                                                  .lightGray),
                                        ),
                                        Text(
                                          "Ticket Number",
                                          style:
                                          satoshiRegular.copyWith(
                                              fontSize: Dimensions
                                                  .dp12.sp,
                                              fontWeight:
                                              FontWeight.w500,
                                              color: AppColors
                                                  .lightGray),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp4,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
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
                                              widget
                                                  .routeCode
                                                  ?.replaceAll(
                                                  "[", "")
                                                  .replaceAll(
                                                  "]", "") ??
                                                  "",
                                              style:
                                              satoshiSmall.copyWith(
                                                  fontWeight:
                                                  FontWeight
                                                      .w700,
                                                  color: AppColors
                                                      .darkGray),
                                            ),
                                            const SizedBox(
                                              width: Dimensions.dp8,
                                            ),
                                            const SizedBox(
                                              width: Dimensions.dp8,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          widget.ticketNo ??
                                              "",
                                          style: satoshiSmall.copyWith(
                                              fontWeight:
                                              FontWeight.w700,
                                              color:
                                              AppColors.darkGray),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp25,
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: AppColors.lightGray,
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp15,
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Passenger",
                                        style: satoshiRegular.copyWith(
                                            fontSize:
                                            Dimensions.dp12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.lightGray),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Adults",
                                                  style: satoshiRegular
                                                      .copyWith(
                                                      fontSize:
                                                      Dimensions
                                                          .dp12
                                                          .sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                      color: AppColors
                                                          .darkGray),
                                                ),
                                                Text(
                                                  widget.ticketType == "Adult" ? "1" : "0",
                                                  style: satoshiRegular
                                                      .copyWith(
                                                      fontSize:
                                                      Dimensions
                                                          .dp16
                                                          .sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      color: AppColors
                                                          .darkGray),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 30,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "Child",
                                                  style: satoshiRegular
                                                      .copyWith(
                                                      fontSize:
                                                      Dimensions
                                                          .dp12
                                                          .sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                      color: AppColors
                                                          .darkGray),
                                                ),
                                                Text(
                                                  widget.ticketType! == "Child" ? "1" : "0",
                                                  style: satoshiRegular
                                                      .copyWith(
                                                      fontSize:
                                                      Dimensions
                                                          .dp16
                                                          .sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400,
                                                      color: AppColors
                                                          .darkGray),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Total",
                                              style: satoshiRegular
                                                  .copyWith(
                                                  fontSize:
                                                  Dimensions
                                                      .dp12.sp,
                                                  fontWeight:
                                                  FontWeight
                                                      .w700,
                                                  color: AppColors
                                                      .darkGray),
                                            ),
                                            Text(
                                              widget.length
                                                  .toString() ??
                                                  "1",
                                              style: satoshiRegular
                                                  .copyWith(
                                                  fontSize:
                                                  Dimensions
                                                      .dp16.sp,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400,
                                                  color: AppColors
                                                      .darkGray),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp25,
                                    ),
                                    const Divider(
                                      height: 1,
                                      color: AppColors.lightGray,
                                    ),
                                    const SizedBox(
                                      height: Dimensions.dp15,
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Total Fare",
                                              style: satoshiRegular
                                                  .copyWith(
                                                  fontSize:
                                                  Dimensions
                                                      .dp14.sp,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  color: AppColors
                                                      .darkGray),
                                            ),
                                            Text(
                                              "₹ ${getFare(int.parse(widget.fareAmt ?? "0"))}",
                                              style: satoshiRegular
                                                  .copyWith(
                                                  fontSize:
                                                  Dimensions
                                                      .dp14.sp,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
                                                  color: AppColors
                                                      .darkGray),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment
                                        //           .spaceBetween,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       "GST Amount",
                                        //       style: satoshiRegular
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Dimensions
                                        //                       .dp14.sp,
                                        //               fontWeight:
                                        //                   FontWeight
                                        //                       .w500,
                                        //               color: AppColors
                                        //                   .darkGray),
                                        //     ),
                                        //     Text(
                                        //       "₹ 0.00",
                                        //       style: satoshiRegular
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Dimensions
                                        //                       .dp14.sp,
                                        //               fontWeight:
                                        //                   FontWeight
                                        //                       .w500,
                                        //               color: AppColors
                                        //                   .darkGray),
                                        //     ),
                                        //   ],
                                        // ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment
                                        //           .spaceBetween,
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.center,
                                        //   children: [
                                        //     Text(
                                        //       "Free cancellation charge",
                                        //       style: satoshiRegular
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Dimensions
                                        //                       .dp14.sp,
                                        //               fontWeight:
                                        //                   FontWeight
                                        //                       .w500,
                                        //               color: AppColors
                                        //                   .darkGray),
                                        //     ),
                                        //     Text(
                                        //       "₹ 0.00",
                                        //       style: satoshiRegular
                                        //           .copyWith(
                                        //               fontSize:
                                        //                   Dimensions
                                        //                       .dp14.sp,
                                        //               fontWeight:
                                        //                   FontWeight
                                        //                       .w500,
                                        //               color: AppColors
                                        //                   .darkGray),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Net Payable",
                                          style:
                                          satoshiRegular.copyWith(
                                              fontSize: Dimensions
                                                  .dp14.sp,
                                              fontWeight:
                                              FontWeight.w700,
                                              color: AppColors
                                                  .darkGray),
                                        ),
                                        Text(
                                          "₹ ${getFare(int.parse(widget.fareAmt ?? "0"))}",
                                          style:
                                          satoshiRegular.copyWith(
                                              fontSize: Dimensions
                                                  .dp14.sp,
                                              fontWeight:
                                              FontWeight.w700,
                                              color: AppColors
                                                  .primaryColor),
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
      ),
    );
  }
}
