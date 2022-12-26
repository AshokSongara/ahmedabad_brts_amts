import 'dart:convert';

import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/ticket_painter.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
import 'package:http/http.dart' as http;

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen({Key? key}) : super(key: key);

  @override
  _PaymentDetailsScreenState createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  String payment_response = "";

  //Live
  // String mid = "AHMEDA34997503119008";
  // String PAYTM_MERCHANT_KEY = "ssD7Oesu2CNmw6Xh";
  // String website = "WEBSTAGING";
  bool testing = true;
  double amount = 500;
  bool loading = false;

  String orderId = "", txnToken = "";
  String result = "";
  bool isStaging = true;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;

  final String _mid = "AHMEDA34997503119008";
  final String _mKey = "ssD7Oesu2CNmw6Xh";
  final String _website = "WEBSTAGING";
  final String _url =
      'https://flutter-paytm-backend.herokuapp.com/generateTxnToken';

  String get mid => _mid;

  String get mKey => _mKey;

  String get website => _website;

  String get url => _url;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: Column(
        children: [
          const SizedBox(height: Dimensions.dp25),
          CustomToolbar(
            title: "payment_details",
            showOption: false,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 43, left: 39),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 1.2,
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    child: CustomPaint(
                      painter: TicketPainter(
                        borderColor: Colors.transparent,
                        bgColor: Colors.white,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 18, right: 18, top: 20.h),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 80.h,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Adalaj Gam",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp16.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.darkGray),
                                      ),
                                      SvgPicture.asset(
                                          ImageConstant.iArrowRight),
                                      Text(
                                        "Ahm Airport",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp16.sp,
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
                                        "Route Number",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.lightGray),
                                      ),
                                      Text(
                                        "Bus Service",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp12.sp,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              ImageConstant.iBus,
                                              color: AppColors.darkGray,
                                              width: 14.w,
                                              height: 16.h,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "4U",
                                              style: satoshiRegular.copyWith(
                                                  fontSize: Dimensions.dp14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.darkGray),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset(
                                              ImageConstant.iRightGrayArrow,
                                              color: AppColors.darkGray,
                                              width: 14.w,
                                              height: 14.h,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SvgPicture.asset(
                                              ImageConstant.iBus,
                                              color: AppColors.darkGray,
                                              width: 14.w,
                                              height: 16.h,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "18S",
                                              style: satoshiRegular.copyWith(
                                                  fontSize: Dimensions.dp14.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.darkGray),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "AMTS",
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp14.sp,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.darkGray),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Boarding Point",
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.lightGray),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Adalaj Gam",
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darkGray),
                                        ),
                                        Text(
                                          "15 Oct 2022, 09:34 PM",
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darkGray),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Dropping Point",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp12.sp,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Ahm Airport",
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darkGray),
                                        ),
                                        Text(
                                          "15 Oct 2022, 10:54 PM",
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp14.sp,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.darkGray),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 60.h, bottom: 20.h),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Travellers",
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.lightGray),
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
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          "Amit Yogi",
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.darkGray),
                                        ),
                                        const SizedBox(
                                          width: 28,
                                        ),
                                        Text(
                                          "28 yrs",
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.darkGray),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 40.h),
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
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 80.h),
                                  child: Row(
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
                                      SvgPicture.asset(
                                        ImageConstant.iTopRedArrow,
                                        height: 7,
                                        width: 14,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        "₹60.00",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp14.sp,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  payment_response != null
                      ? Text('Response: $payment_response\n')
                      : Container(),
               loading
                   ? Center(
                       child: Container(
                           width: 50,
                           height: 50,
                           child: CircularProgressIndicator()),
                     )
                   : Container(),
                  ElevatedButton(
                    onPressed: () {
                      generateTxnToken(amount,"101");
                    },
                    child: Text(
                      "Pay using Wallet",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      generateTxnToken(amount,"101");
                    },
                    child: Text(
                      "Pay using Net Banking",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      generateTxnToken(amount,"101");
                    },
                    child: Text(
                      "Pay using UPI",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      generateTxnToken(amount,"101");
                    },
                    child: Text(
                      "Pay using Credit Card",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _startTransaction() async {
    if (txnToken.isEmpty) {
      return;
    }
    var sendMap = <String, dynamic>{
      "mid": mid,
      "orderId": orderId,
      "amount": amount,
      "txnToken": txnToken,
      "callbackUrl": callbackUrl,
      "isStaging": isStaging,
      "restrictAppInvoke": restrictAppInvoke,
      "enableAssist": enableAssist
    };
    print(sendMap);
    try {
      var response = AllInOneSdk.startTransaction(
          mid,
          orderId,
          amount.toString(),
          txnToken,
          callbackUrl,
          isStaging,
          restrictAppInvoke,
          enableAssist);
      response.then((value) {
        print(value);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = onError.message.toString() +
                " \n  " +
                onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }

  String getMap(double amount, String callbackUrl, String orderId) {
    return json.encode({
      "mid": mid,
      "key_secret": mKey,
      "website": website,
      "orderId": orderId,
      "amount": amount.toString(),
      "callbackUrl": callbackUrl,
      "custId": "122",
    });
  }

  Future<void> generateTxnToken(double amount, String orderId) async {
    final callBackUrl =
        'https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=$orderId';
    final body = getMap(amount, callBackUrl, orderId);

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {'Content-type': "application/json"},
      );
      String txnToken = response.body;

      await initiateTransaction(orderId, amount, txnToken, callBackUrl);
    } catch (e) {
      print(e);
    }
  }

  Future<void> initiateTransaction(String orderId, double amount,
      String txnToken, String callBackUrl) async {
    String result = '';
    try {
      var response = AllInOneSdk.startTransaction(
        mid,
        orderId,
        amount.toString(),
        txnToken,
        callBackUrl,
        true,
        false,
      );
      response.then((value) {
        // Transaction successfull
        print(value);
      }).catchError((onError) {
        if (onError is PlatformException) {
          result = onError.message! + " \n  " + onError.details.toString();
          print(result);
        } else {
          result = onError.toString();
          print(result);
        }
      });
    } catch (err) {
      // Transaction failed
      result = err.toString();
      print(result);
    }
  }
}
