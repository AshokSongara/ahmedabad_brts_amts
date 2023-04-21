import 'dart:convert';

import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/ticket/ticket_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/ticket/ticket_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/ticket/ticket_state.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/dashed_line_widget.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../payment_details/full_screen_qr_screen.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen(
      {Key? key,
      required this.ticketNumber,})
      : super(key: key);

  final String? ticketNumber;

  @override
  _TicketDetailsScreenState createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  List<LocalSliderModel> modelList = [];
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    disableScreenshot();
    getData();
  }

  getData() {
    BlocProvider.of<TicketBloc>(context).add(
      GetTicketEvent(ticketNumber: widget.ticketNumber ?? ""),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            // const SizedBox(height: Dimensions.dp25),
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
                    SvgPicture.asset(
                      ImageConstant.iRedTime,
                      color: AppColors.primaryColor,
                    ),
                    const SizedBox(
                      width: Dimensions.dp4,
                    ),
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
                child: BlocConsumer<TicketBloc, TicketState>(
                  listener: (context, state) {
                     if (state is TicketLoadingState) {
                      Loader.show(context);
                    } else if (state is TicketSuccessState) {
                      Loader.hide();
                    } else if (state is TicketFailedState) {
                      Loader.hide();
                    }
                  },
                  builder: (context, state) {
                    if (state is TicketSuccessState) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                right: Dimensions.dp43, left: Dimensions.dp39),
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
                                            child: GestureDetector(
                                              onTap: () {
                                                carouselController
                                                    .previousPage();
                                              },
                                              child: SvgPicture.asset(
                                                  ImageConstant.iLeftArrow),
                                            )),
                                        Expanded(
                                            flex: 2,
                                            child: CarouselSlider(
                                              carouselController:
                                                  carouselController,
                                              options: CarouselOptions(
                                                scrollPhysics:
                                                    const NeverScrollableScrollPhysics(),
                                                height: 200.0,
                                                viewportFraction: 1,
                                                enlargeFactor: 0.3,
                                              ),
                                              items: state
                                                  .paymentInitResponseModel.data
                                                  ?.map((i) => Builder(
                                                          builder: (context) {
                                                        return Column(
                                                          children: [
                                                            GestureDetector(
                                                              child: Image.memory(
                                                                  base64Decode(
                                                                      i.qrCodeString ??
                                                                          "")),
                                                              onTap: () =>
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          FullScreenQr(qrCode: i.qrCodeString ?? ""),
                                                                    ),
                                                                  ),
                                                            ),
                                                            Text(
                                                              i.ticketNumber ?? "",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: satoshiRegular.copyWith(
                                                                  fontSize:
                                                                      Dimensions
                                                                          .dp12
                                                                          .sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .darkGray),
                                                            ),
                                                          ],
                                                        );
                                                      }))
                                                  .toList(),
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: GestureDetector(
                                              onTap: () {
                                                carouselController.nextPage();
                                              },
                                              child: RotatedBox(
                                                  quarterTurns: 2,
                                                  child: SvgPicture.asset(
                                                    ImageConstant.iLeftArrow,
                                                  )),
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
                                    const Padding(
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
                                          const SizedBox(
                                            height: Dimensions.dp12,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  state
                                                          .paymentInitResponseModel
                                                          .data![0]
                                                          .sourceStopName ??
                                                      "",
                                                  style:
                                                      satoshiRegular.copyWith(
                                                          fontSize: Dimensions
                                                              .dp16.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .darkGray,
                                                          overflow: TextOverflow
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
                                                    state
                                                            .paymentInitResponseModel
                                                            .data![0]
                                                            .destinationStopName ??
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
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: Dimensions.dp8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Route Number",
                                                style: satoshiRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.dp12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.lightGray),
                                              ),
                                              Text(
                                                "Ticket Number",
                                                style: satoshiRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.dp12.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.lightGray),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
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
                                                    style:
                                                        satoshiSmall.copyWith(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
                                                  const SizedBox(
                                                    width: Dimensions.dp8,
                                                  ),
                                                  SvgPicture.asset(ImageConstant
                                                      .iRightGrayArrow),
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
                                                    style:
                                                        satoshiSmall.copyWith(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                state.paymentInitResponseModel
                                                        .data![0].ticketNumber ??
                                                    "",
                                                style: satoshiSmall.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.darkGray),
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
                                                  fontSize: Dimensions.dp12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors.lightGray),
                                            ),
                                          ),
                                          const SizedBox(
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
                                                        state.paymentInitResponseModel
                                                                .data?.length
                                                                .toString() ??
                                                            "1",
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
                                                        "0",
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
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp12.sp,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
                                                  Text(
                                                    state.paymentInitResponseModel
                                                            .data?.length
                                                            .toString() ??
                                                        "1",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp16.sp,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
                                                  Text(
                                                    "₹ ${getFare(int.parse(state.paymentInitResponseModel.data![0].tripFare.toString() ?? "0"))}",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
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
                                                    "GST Amount",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
                                                  Text(
                                                    "₹ 0.00",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
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
                                                    "Free cancellation charge",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .darkGray),
                                                  ),
                                                  Text(
                                                    "₹ 0.00",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .dp14.sp,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .darkGray),
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
                                                    fontSize:
                                                        Dimensions.dp14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.darkGray),
                                              ),
                                              Text(
                                                "₹ ${getFare(int.parse(state.paymentInitResponseModel.data![0].tripFare.toString() ?? "0"))}",
                                                style: satoshiRegular.copyWith(
                                                    fontSize:
                                                        Dimensions.dp14.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color:
                                                        AppColors.primaryColor),
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
                      );
                    } else if (state is PaymentUrlFailedState) {
                      return Container(
                        child: const Text("Error"),
                      );
                    }
                    return Container();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposeDisableScreenshot();
    Loader.hide();
  }
}

class LocalSliderModel {
  String path;
  String passengerRank;

  LocalSliderModel(this.path, this.passengerRank);
}