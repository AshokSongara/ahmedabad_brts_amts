import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_state.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/dashed_line_widget.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_webview/payment_webvieW_screen.dart';
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

import 'full_screen_qr_screen.dart';

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen(
      {Key? key,
      required this.sourceStopId,
      required this.destinationStopId,
      required this.discountype,
      required this.txnStatus,
      required this.merchantId,
      required this.sourcecompanycode,
      required this.destinationcompanycode,
      required this.routeCode,
      required this.serviceType,
      required this.type})
      : super(key: key);

  final String? sourceStopId;
  final String? destinationStopId;
  final String? discountype;
  final String? txnStatus;
  final String? merchantId;
  final String? sourcecompanycode;
  final String? destinationcompanycode;
  final String? routeCode;
  final String? serviceType;
  final String? type;

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  List<LocalSliderModel> modelList = [];
  CarouselController carouselController = CarouselController();
  String status = "";

  @override
  void initState() {
    super.initState();
    disableScreenshot();
    getData();
  }

  getData() {
    var paymentRequest = PaymentRequest(
        sourceStopId: widget.sourceStopId,
        destinationStopId: widget.destinationStopId,
        discountype: widget.discountype,
        txnStatus: "SUCCESS",
        merchantId: "20230201022556",
        sourcecompanycode: "102",
        destinationcompanycode: "103",
        routeCode: widget.routeCode,
        serviceType: widget.serviceType);

    BlocProvider.of<PaymentBloc>(context).add(
      GetPaymentUrlEvent(paymentRequest: paymentRequest),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
            RouteHelper.dashboard, (Route<dynamic> route) => false);
        return true;
      },
      child: Scaffold(
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
                  child: BlocConsumer<PaymentBloc, PaymentState>(
                    listener: (context, state) {
                      if (state is PaymentUrlLoadingState) {
                        Loader.show(context);
                      } else if (state is PaymentUrlSuccessState) {
                        Loader.hide();

                        navigateToWebview(
                            state.qrCodeResponse.data?.paymentURL ?? "");
                      } else if (state is PaymentLoadingState) {
                        Loader.show(context);
                      }else if (state is PaymentSuccessState) {
                        if (status == "FAILED") {
                          Loader.hide();
                          Get.toNamed(RouteHelper.transactionStatus);
                        }
                        Loader.hide();
                      } else if (state is PaymentFailedState) {
                        Loader.hide();
                      }
                    },
                    builder: (context, state) {
                      if (state is PaymentSuccessState) {
                        return Column(
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
                                              flex: 2,
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    child: Image.memory(
                                                        base64Decode(state
                                                                .paymentInitResponseModel
                                                                .data![0]
                                                                .qrCode ??
                                                            "")),
                                                    onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            FullScreenQr(
                                                                qrCode: state
                                                                        .paymentInitResponseModel
                                                                        .data![
                                                                            0]
                                                                        .qrCode ??
                                                                    ""),
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    "Click on QR code to expand",
                                                    textAlign: TextAlign.center,
                                                    style: satoshiRegular.copyWith(
                                                        fontSize: Dimensions.dp12.sp,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors.lightGray),),
                                                  SizedBox(height: 5,),
                                                  Text(
                                                    state.paymentInitResponseModel
                                                            .data![0].ticketNo ??
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
                                                  state.paymentInitResponseModel.data![0].sourceStopName! == "OneDayPass" ?
                                                  Text("ONE DAY PASS", style: satoshiRegular.copyWith(
                                                      fontSize:
                                                      Dimensions
                                                          .dp16
                                                          .sp,
                                                      fontWeight:
                                                      FontWeight
                                                          .w700,
                                                      color: AppColors
                                                          .lightBlue)) : SizedBox(height: 0,)
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
                                                "The validity period is 2 hours and the entry time is 15 minutes.",
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
                                            state.paymentInitResponseModel.data![0].sourceStopName! == "OneDayPass" ? Container()  :Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    state
                                                            .paymentInitResponseModel
                                                            .data![0]
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
                                                      state
                                                              .paymentInitResponseModel
                                                              .data![0]
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
                                                      state
                                                              .paymentInitResponseModel
                                                              .data![0]
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
                                                  state.paymentInitResponseModel
                                                          .data![0].ticketNo ??
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
                                                          state.paymentInitResponseModel
                                                              .data![0].ticketType! == "Adult" ? "1" : "0",
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
                                                          state.paymentInitResponseModel
                                                              .data![0].ticketType! == "Child" ? "1" : "0",
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
                                                      state.paymentInitResponseModel
                                                              .data?.length
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
                                                      "₹ ${getFare(int.parse(state.paymentInitResponseModel.data![0].fareAmt ?? "0"))}",
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "GST Amount",
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
                                                      "₹ 0.00",
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "Free cancellation charge",
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
                                                      "₹ 0.00",
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
                                                  "₹ ${getFare(int.parse(state.paymentInitResponseModel.data![0].fareAmt ?? "0"))}",
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    disposeDisableScreenshot();
    Loader.hide();
  }

  Future<void> navigateToWebview(url) async {
    String? data = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => WebViewScreen(url: url)));

    if (Platform.isAndroid) {
      if (data == null) {
        Navigator.of(context).pop();
      }
      else if (data.length < 5000) {
        status = "FAILED";
        print("#####WEBVIEW${data}");
        List<String>? list = data.split(' ');

        if (data.isNotEmpty) {
          var paymentRequest = PaymentRequest(
              sourceStopId: widget.sourceStopId,
              destinationStopId:
              widget.type!.isEmpty ? "PASS" : widget.destinationStopId,
              discountype: status == "FAILED" ? "0" : widget.discountype,
              txnStatus: status,
              merchantId: "470000012117828",
              sourcecompanycode: "102",
              destinationcompanycode: "103",
              fpTransactionId: list[54].substring(27, 43),
              routeCode: widget.routeCode,
              externalTxnId: "",
              merchantTxnId: "",
              transactionDateTime: DateTime.now().toString(),
              serviceType: widget.serviceType);

          BlocProvider.of<PaymentBloc>(context).add(
            GetQRCodeEvent(paymentRequest: paymentRequest),
          );
        }
      }
      else {
        status = "SUCCESS";
        print("#####WEBVIEW${data}");
        List<String>? list = data.split(' ');

        if (data.isNotEmpty) {
          var paymentRequest = PaymentRequest(
              sourceStopId: widget.type!.isEmpty ? "PASS" : widget.sourceStopId,
              destinationStopId:
              widget.type!.isEmpty ? "PASS" : widget.destinationStopId,
              discountype: widget.discountype,
              txnStatus: status,
              merchantId: "470000012117828",
              sourcecompanycode: "102",
              destinationcompanycode: "103",
              fpTransactionId: list[54].substring(27, 43),
              routeCode: widget.routeCode,
              externalTxnId: list[127].substring(25, 36),
              merchantTxnId: list[108].substring(18, 61),
              transactionDateTime:
              "${list[90].substring(25, list[90].length)}T${list[91].substring(
                  0, 12)}",
              serviceType: widget.serviceType);

          BlocProvider.of<PaymentBloc>(context).add(
            GetQRCodeEvent(paymentRequest: paymentRequest),
          );
        }
      }
    }
    else{
      if (data == null) {
        Navigator.of(context).pop();
      }
      else if (data.length < 3000) {
        status = "FAILED";
        print("#####WEBVIEW${data}");
        List<String>? list = data.split(' ');

        if (data.isNotEmpty) {
          var paymentRequest = PaymentRequest(
              sourceStopId: widget.sourceStopId,
              destinationStopId:
              widget.type!.isEmpty ? "PASS" : widget.destinationStopId,
              discountype: status == "FAILED" ? "0" : widget.discountype,
              txnStatus: status,
              merchantId: "470000012117828",
              sourcecompanycode: "102",
              destinationcompanycode: "103",
              fpTransactionId: list[54].substring(27, 43),
              routeCode: widget.routeCode,
              externalTxnId: "",
              merchantTxnId: "",
              transactionDateTime: DateTime.now().toString(),
              serviceType: widget.serviceType);

          BlocProvider.of<PaymentBloc>(context).add(
            GetQRCodeEvent(paymentRequest: paymentRequest),
          );
        }
      }
      else {
        status = "SUCCESS";
        print("#####WEBVIEW${data}");
        List<String>? list = data.split(' ');

        if (data.isNotEmpty) {
          var paymentRequest = PaymentRequest(
              sourceStopId: widget.type!.isEmpty ? "PASS" : widget.sourceStopId,
              destinationStopId:
              widget.type!.isEmpty ? "PASS" : widget.destinationStopId,
              discountype: widget.discountype,
              txnStatus: status,
              merchantId: "470000012117828",
              sourcecompanycode: "102",
              destinationcompanycode: "103",
              fpTransactionId: list [54].substring(27, 43),
              routeCode: widget.routeCode,
              externalTxnId: list[127].substring(25, 36),
              merchantTxnId: list[108].substring(18, 61),
              transactionDateTime:
              "${list[90].substring(25, list[90].length)}T${list[91].substring(
                  0, 12)}",
              serviceType: widget.serviceType);

          BlocProvider.of<PaymentBloc>(context).add(
            GetQRCodeEvent(paymentRequest: paymentRequest),
          );
        }
      }
    }
  }
}

class LocalSliderModel {
  String path;
  String passengerRank;

  LocalSliderModel(this.path, this.passengerRank);
}
