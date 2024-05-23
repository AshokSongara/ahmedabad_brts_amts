import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/payment_new_response.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_event.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/json_request.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/new_payment_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/payment_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/pending_screen/pending_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_upi/get_upi.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:upi_pay/upi_pay.dart';

class PassengerDetails extends StatefulWidget {
  const PassengerDetails(
      {Key? key,
      required this.sourceStopId,
      required this.destinationStopId,
      required this.routeCode,
      required this.serviceType,
      required this.from,
      this.fare})
      : super(key: key);

  final String? sourceStopId;
  final String? destinationStopId;
  final String? routeCode;
  final String? serviceType;
  final String? fare;
  final String? from;

  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  int _addedAdultsCount = 0;
  int _addedKidsCount = 0;
  List<String?> list = [];
  String? selectedOption = "PhonePe";
  String token = "";
  String? serviceTypee;
  List<UpiObject> appNamesList = [];
  UpiObject? selectedPackageName;

  // bool areButtonsVisible = false;
  // bool areupiappsvisible = false;
  String? discount;

  PhonepeRequest? phonepeRequest;

  List upiAppsListAndroid = [];
  bool appOpen = false;
  String discountCode = '';
  bool isLoading = false;
  String showFare = "";

  @override
  initState() {
    super.initState();

    // initPlatformState();
    list = Get.arguments as List<String?>;
    print(widget.fare);
    setState(() {
      showFare = widget.fare ?? "";
    });

    getMemberID();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstant.accessToken) ?? "";
    if (token.isNotEmpty) {
      getData();
      if (widget.from == "h") getUpiList();
    }
  }

  getData() {
    BlocProvider.of<DiscountBloc>(context).add(const GetDiscountEvent());
  }

  getUpiList() async {
    List<UpiObject> upiAppsList = [];
    List<dynamic> upiAppsList2 = [];
    if (Platform.isAndroid) {
      var values = await GetUPI.apps();
      upiAppsList = values.data;
      appNamesList.clear();
      upiAppsList.forEach((element) {
        appNamesList.add(UpiObject(
            name: element.name,
            packageName: element.packageName,
            icon: element.icon));
      });
    } else if (Platform.isIOS) {
      final List<ApplicationMeta> appMetaList =
          await UpiPay.getInstalledUpiApplications();
      appMetaList.forEach((element) {
        appNamesList.add(UpiObject(
            name: element.upiApplication.appName,
            packageName: element.packageName,
            icon: ''));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BlocConsumer<DiscountBloc, DiscountState>(
        listener: (context, state) {
          if (state is DiscountLoadingState) {
            Loader.show(context);
          } else if (state is DiscountSuccessState) {
            discountCode =
                state.discountResponse.data?.first.discountTypeCode ?? "";
            Loader.hide();
          } else if (state is DiscountFailedState) {
            Loader.hide();
          }
        },
        builder: (context, state) {
          if (state is DiscountSuccessState) {
            return isLoading
                ? Center(child: CircularProgressIndicator())
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomToolbar(
                            title: "passenger_details",
                            showOption: false,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 19, vertical: 24),
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
                                Radius.circular(Dimensions.dp10),
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    getSourceDestination(list[0] ?? "",
                                        "${DateFormat('dd MMM yyyy').format(DateTime.now())}, ${list[2]}"),
                                    Expanded(
                                      flex: 1,
                                      child: SvgPicture.asset(
                                          ImageConstant.iArrowRight),
                                    ),
                                    getSourceDestination(list[1] ?? "",
                                        "${DateFormat('dd MMM yyyy').format(DateTime.now())}, ${list[3]}")
                                  ],
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Fare  ",
                                      style: satoshiRegular.copyWith(
                                          fontSize: 14.5.sp,
                                          color: AppColors.darkGray),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: "₹${formatString(showFare)}",
                                            style: satoshiRegularSmall.copyWith(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 19.sp,
                                                color: AppColors.darkGray)),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                          // Center(
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       _showBottomSheet();
                          //     },
                          //     child: Text('Select UPI App'),
                          //   ),
                          // ),

                          // Center(
                          //   child: Column(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       // Container(
                          //       //   decoration: const BoxDecoration(
                          //       //     color: AppColors.grayC4C$C$,
                          //       //     borderRadius: BorderRadius.all(Radius.circular(50)),
                          //       //   ),
                          //       //   margin: const EdgeInsets.only(left: 30, right: 30),
                          //       //   child: RadioListTile(
                          //       //     title: Text("UPI apps",
                          //       //         style: poppinsMedium.copyWith(
                          //       //             fontSize: 18.sp,
                          //       //             fontWeight: FontWeight.w400)),
                          //       //     value: "PhonePe",
                          //       //     activeColor: AppColors.primaryColor,
                          //       //     //tileColor: Colors.grey,
                          //       //     groupValue: selectedOption,
                          //       //     onChanged: (value) {
                          //       //       setState(() {
                          //       //         selectedOption = value as String?;
                          //       //       });
                          //       //     },
                          //       //   ),
                          //       // ),
                          //
                          //       // Container(
                          //       //   decoration: const BoxDecoration(
                          //       //     color: AppColors.grayC4C$C$,
                          //       //     borderRadius: BorderRadius.all(Radius.circular(50)),
                          //       //   ),
                          //       //   margin: const EdgeInsets.only(left: 30, right: 30),
                          //       //   child: RadioListTile(
                          //       //     title: Text("Fiserv",
                          //       //         style: poppinsMedium.copyWith(
                          //       //             fontSize: 18.sp,
                          //       //             fontWeight: FontWeight.w400)),
                          //       //     value: "Fiser",
                          //       //     activeColor: AppColors.primaryColor,
                          //       //     groupValue: selectedOption,
                          //       //     onChanged: (value) {
                          //       //       setState(() {
                          //       //         selectedOption = value as String?;
                          //       //       });
                          //       //     },
                          //       //   ),
                          //       // ),
                          //     ],
                          //   ),
                          // ),
                          SizedBox(
                            height: 20.h,
                          ),

                          // Code hidden from below
                          // ListView.builder(
                          //     shrinkWrap: true,
                          //     itemCount: state.discountResponse.data?.length,
                          //     itemBuilder: (context, index) {
                          //       return SingleChildScrollView(
                          //         child: Container(
                          //           margin: const EdgeInsets.only(
                          //               left: Dimensions.dp24,
                          //               right: Dimensions.dp24,
                          //               top: Dimensions.dp15),
                          //           decoration: const BoxDecoration(
                          //             color: Colors.white,
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: AppColors.gray6E8EE7,
                          //                 blurRadius: 5.0,
                          //               ),
                          //             ],
                          //             borderRadius: BorderRadius.all(
                          //               Radius.circular(Dimensions.dp10),
                          //             ),
                          //           ),
                          //           child: Padding(
                          //             padding: const EdgeInsets.only(
                          //                 top: 15, right: 18, left: 18),
                          //             child: Column(
                          //               children: [
                          //                 Row(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.spaceBetween,
                          //                   children: [
                          //                     Text(
                          //                       state.discountResponse.data![index]
                          //                               .catPassSubCateName ??
                          //                           "",
                          //                       style: satoshiRegular.copyWith(
                          //                           fontSize: Dimensions.dp16.sp,
                          //                           fontWeight: FontWeight.w500,
                          //                           color: AppColors.darkGray),
                          //                     ),
                          //                     InkWell(
                          //                       onTap: () async{
                          //                         setState(() {
                          //                           discount = state
                          //                                   .discountResponse
                          //                                   .data![index].discountTypeCode ??
                          //                               "";
                          //                           // areButtonsVisible =
                          //                           //     !areButtonsVisible;
                          //                         });
                          //
                          //
                          //
                          //                         List<UpiObject> upiAppsList = [];
                          //                         List<dynamic> upiAppsList2 = [];
                          //                         if(Platform.isAndroid) {
                          //                           var values = await GetUPI.apps();
                          //                           upiAppsList = values.data;
                          //                           appNamesList.clear();
                          //                           upiAppsList.forEach((element) {
                          //                             appNamesList.add(UpiObject(
                          //                                 name: element.name,
                          //                                 packageName: element.packageName,
                          //                                 icon: element.icon));
                          //                           });
                          //                         }
                          //                         else if (Platform.isIOS) {
                          //                           //Write Ios code here
                          //                           var valueIos = await GetUPI.iosApps();
                          //                           upiAppsList2 = valueIos;
                          //                           upiAppsList2.forEach((element) {
                          //                             appNamesList.add(UpiObject(
                          //                                 name: element.name,
                          //                                 packageName: element.packageName,
                          //                                 icon: element.icon));
                          //                           });
                          //                         }
                          //
                          //                         // setState(() {
                          //                         //   areupiappsvisible = !areupiappsvisible;
                          //                         // });
                          //                         // if (selectedOption == "PhonePe") {
                          //                         //   apiCall(state
                          //                         //           .discountResponse
                          //                         //           .data![index]
                          //                         //           .discountTypeCode ??
                          //                         //       "",'');
                          //                         // } else {
                          //                         //   Get.toNamed(RouteHelper
                          //                         //       .getPaymentDetailsRoute(
                          //                         //           widget.sourceStopId ?? "",
                          //                         //           widget.destinationStopId ??
                          //                         //               "",
                          //                         //           state
                          //                         //                   .discountResponse
                          //                         //                   .data![index]
                          //                         //                   .discountTypeCode ??
                          //                         //               "",
                          //                         //           "",
                          //                         //           "",
                          //                         //           "",
                          //                         //           "",
                          //                         //           widget.routeCode ?? "",
                          //                         //           widget.serviceType ?? "",
                          //                         //           "Payment"));
                          //                         // }
                          //                       },
                          //                       child: Container(
                          //                         padding: const EdgeInsets.symmetric(
                          //                             vertical: 8, horizontal: 15),
                          //                         decoration: BoxDecoration(
                          //                             borderRadius:
                          //                                 const BorderRadius.all(
                          //                               Radius.circular(
                          //                                 Dimensions.dp5,
                          //                               ),
                          //                             ),
                          //                             border: Border.all(
                          //                                 color: Theme.of(context)
                          //                                     .primaryColor)),
                          //                         child: Text("Book Ticket",
                          //                             style: satoshiRegular.copyWith(
                          //                                 fontSize:
                          //                                     Dimensions.dp15.sp,
                          //                                 fontWeight: FontWeight.w500,
                          //                                 color: Theme.of(context)
                          //                                     .primaryColor)),
                          //                       ),
                          //                     )
                          //                   ],
                          //                 ),
                          //                 const SizedBox(
                          //                   height: 10,
                          //                 ),
                          //               ],
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     }),
                          // SizedBox(
                          //   height: 18.h,
                          // ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: Text("How would you want to pay?",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black)),
                          ),

                          // if(widget.serviceType == "BRTS")     GestureDetector(
                          //   onTap: () async {
                          //     List<UpiObject> upiAppsList = [];
                          //     List<dynamic> upiAppsList2 = [];
                          //     if(Platform.isAndroid) {
                          //       var values = await GetUPI.apps();
                          //       upiAppsList = values.data;
                          //       appNamesList.clear();
                          //       upiAppsList.forEach((element) {
                          //         appNamesList.add(UpiObject(
                          //             name: element.name,
                          //             packageName: element.packageName,
                          //             icon: element.icon));
                          //       });
                          //     }
                          //     else if (Platform.isIOS) {
                          //       //Write Ios code here
                          //       var valueIos = await GetUPI.iosApps();
                          //       upiAppsList2 = valueIos;
                          //       upiAppsList2.forEach((element) {
                          //         appNamesList.add(UpiObject(
                          //             name: element.name,
                          //             packageName: element.packageName,
                          //             icon: element.icon));
                          //       });
                          //     }
                          //
                          //     // setState(() {
                          //     //   areupiappsvisible = !areupiappsvisible;
                          //     // });
                          //   },
                          //   child: Container(
                          //     width: Get.width,
                          //     height: 50.h,
                          //     margin:  EdgeInsets.only(
                          //         left: Dimensions.dp24,
                          //         right: Dimensions.dp24,
                          //         top: Dimensions.dp10),
                          //     decoration:  BoxDecoration(
                          //       color: Theme.of(context).primaryColor,
                          //       boxShadow: [
                          //         BoxShadow(
                          //           color: AppColors.gray6E8EE7,
                          //           blurRadius: 5.0,
                          //         ),
                          //       ],
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(Dimensions.dp10),
                          //       ),
                          //     ),
                          //     child: Center(
                          //       child: Text("Pay via UPI apps",
                          //           style: satoshiRegular.copyWith(
                          //               fontSize: Dimensions.dp18.sp,
                          //               fontWeight: FontWeight.w700,
                          //               color: Colors.white)),
                          //     ),
                          //   ),
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Display buttons using ElevatedButton
                              for (UpiObject upiObject in appNamesList)
                                GestureDetector(
                                  onTap: () {
                                    onButtonPressed(upiObject);
                                  },
                                  child: Container(
                                    width: Get.width,
                                    height: 70.h,
                                    margin: const EdgeInsets.only(
                                        left: Dimensions.dp24,
                                        right: Dimensions.dp24,
                                        top: Dimensions.dp10),
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
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: (Image.memory(
                                              decodeIcon(upiObject.icon))),
                                        ),
                                        SizedBox(
                                          width: 15.w,
                                        ),
                                        Container(
                                          width: 280.w,
                                          child: Text(upiObject.name,
                                              style: satoshiRegular.copyWith(
                                                  fontSize: Dimensions.dp20.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        ),
                                        SvgPicture.asset(
                                          ImageConstant.iRightGrayArrow,
                                          color: Theme.of(context).primaryColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              // Display selected package name if needed
                              // if (selectedPackageName != null)
                              //   Text(
                              //       'Selected Package Name: ${selectedPackageName?.name ?? ''}'),
                            ],
                          ),

                          GestureDetector(
                            child: Container(
                              width: Get.width,
                              height: 70.h,
                              margin: const EdgeInsets.only(
                                  left: Dimensions.dp24,
                                  right: Dimensions.dp24,
                                  top: Dimensions.dp10),
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
                              child: Center(
                                child: Text("Pay via Fiserv",
                                    style: satoshiRegular.copyWith(
                                        fontSize: Dimensions.dp20.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Theme.of(context).primaryColor)),
                              ),
                            ),
                            onTap: () {
                              Get.toNamed(RouteHelper.getPaymentDetailsRoute(
                                  widget.sourceStopId ?? "",
                                  widget.destinationStopId ?? "",
                                  "01",
                                  "",
                                  "",
                                  "",
                                  "",
                                  widget.routeCode ?? "",
                                  widget.serviceType ?? "",
                                  "Payment"));
                            },
                          ),
                          // Expanded(
                          //   child: Align(
                          //     alignment: Alignment.bottomCenter,
                          //     child: Container(
                          //       margin: const EdgeInsets.all(20),
                          //       height: 53,
                          //       child: CustomButton(
                          //         color: AppColors.primaryColor,
                          //         text: "Payment",
                          //         onPressed: () {
                          //
                          //         },
                          //         width: MediaQuery.of(context).size.width,
                          //         style: poppinsMedium.copyWith(
                          //             color: Colors.white, fontSize: 15.sp),
                          //         height: 53,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  Widget getSourceDestination(String title, String schedule) {
    return Expanded(
      flex: 2,
      child: Column(
        children: [
          Text(
            title,
            style: satoshiRegular.copyWith(
                fontSize: Dimensions.dp16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray),
          ),
          Text(schedule,
              style: satoshiRegular.copyWith(
                  fontSize: Dimensions.dp10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray)),
        ],
      ),
    );
  }

  void apiCall(String discountType, String packageName) async {
    setState(() {
      isLoading = true;
    });
    phonepeRequest = PhonepeRequest(
      startStopCode: widget.sourceStopId,
      endStopCode: widget.destinationStopId,
      discountype: discountType,
      routeCode: widget.routeCode,
      routeType: widget.serviceType == "BRTS" ? 1 : 2,
      deviceOS: Platform.isAndroid ? "ANDROID" : "IOS",
      paymentInstrumentType: "UPI_INTENT",
      targateApp: packageName,
    );

    String jsonStr = jsonEncode(phonepeRequest);
    String url = 'https://www.transportapp.co.in/PhonepePG/PayRequest';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonStr,
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      // appNamesList.clear();
      print('Request successful! Response data:');
      print(response.body);

      final responseData = json.decode(response.body);
      print(responseData);

      String? intentUrl =
          responseData['data']['data']['instrumentResponse']['intentUrl'];
      String? merchantTxnId =
          responseData['data']['data']['merchantTransactionId'];

      print(merchantTxnId);
      List<UpiObject> upiAppsList = [];
      List<dynamic> upiAppsList2 = [];

      if (Platform.isAndroid) {
        var values = await GetUPI.apps();
        upiAppsList = values.data;
        upiAppsList.forEach((element) {
          appNamesList.add(element);
        });
      } else if (Platform.isIOS) {
        final List<ApplicationMeta> appMetaList =
            await UpiPay.getInstalledUpiApplications();
        appMetaList.forEach((element) {
          appNamesList.add(UpiObject(
              name: element.upiApplication.appName,
              packageName: element.packageName,
              icon: ''));
        });
      }

      String result = '';
      try {
        var data = {"intentUrl": intentUrl, "packageName": packageName};

        MethodChannel channel = const MethodChannel('nativeChannel');
        result = await channel.invokeMethod('startPayment', data);
        print('$result resultttttt');
        //  appNamesList.clear();
      } on PlatformException catch (e) {
        //Get.to(PendingScreen());
        print('Failed 2: ${e.message}');
      }

      Map<String, String> apiData = {"merchantTransactionId": merchantTxnId!};
      var apiUrl = 'https://www.transportapp.co.in/AddTransaction/BookedTicket';

      setState(() {
        isLoading = true;
      });

      var response2 = await http.post(Uri.parse(apiUrl),
          headers: headers, body: jsonEncode(apiData));

      if (response2.statusCode == 200) {
        Map<String, dynamic> responseJson = jsonDecode(response2.body);
        PaymentNewResponse paymentResponse =
            PaymentNewResponse.fromJson(responseJson);

        if (paymentResponse.data != null) {
          print(
              'Transaction Status: ${paymentResponse.data!.transactionStatus}');
          print('Ticket No: ${paymentResponse.data!.ticketNo}');
        } else {
          Get.to(() => PendingScreen());
          print('Response data is null');
        }

        setState(() {
          isLoading = false;
        });

        if (paymentResponse.data!.transactionStatus == 'PAYMENT_SUCCESS') {
          showCustomSnackBar("SUCCESS", context, isError: false);
          appNamesList.clear();

          Get.to(() => NewPaymentDetailsScreen(
                qrCode: paymentResponse.data!.qrCode ?? "",
                serviceType: widget.serviceType ?? "",
                ticketNo: paymentResponse.data!.ticketNo ?? "",
                passName: paymentResponse.data!.passName ?? "",
                sourceStopName: paymentResponse.data!.sourceStopName ?? "",
                destinationStopName:
                    paymentResponse.data!.destinationStopName ?? "",
                routeCode: paymentResponse.data!.routeCode ?? "",
                ticketType: paymentResponse.data!.ticketType ?? "",
                fareAmt: paymentResponse.data!.fareAmt ?? "",
                length: "1",
              ));
        } else if (paymentResponse.data!.transactionStatus == null ||
            paymentResponse.data!.transactionStatus == 'PAYMENT_PENDING') {
          showCustomSnackBar("PENDING", context, isError: false);
          Get.to(() => PendingScreen());
          appNamesList.clear();
        } else if (paymentResponse.data!.transactionStatus == 'PAYMENT_ERROR') {
          showCustomSnackBar("FAILED", context, isError: false);
          appNamesList.clear();
          Get.toNamed(RouteHelper.transactionStatus);
        } else {
          print("pending case else");
          Get.to(() => PendingScreen());
        }
      } else {
        print('new pending');
        Get.to(PendingScreen());
        //appNamesList.clear();
        print('Request failed with status code: ${response2.statusCode}');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      showCustomSnackBar("Please try again", context);
      throw Exception('Failed to load data');
    }
  }

  setPassengerData(int adultsCount, int kidsCount) {
    _addedKidsCount = kidsCount;
    _addedAdultsCount = adultsCount;
    setState(() {});
  }

  // void onRadioChanged(UpiObject? value) {
  //   // Update the selected package name
  //   selectedPackageName = value;
  //   apiCall(discountCode, selectedPackageName?.packageName ?? '');
  // }

  // Future<void> _showBottomSheet() async {
  //   List<UpiObject> upiAppsList = [];
  //
  //   var values = await GetUPI.apps();
  //   upiAppsList = values.data;
  //   appNamesList.clear();
  //   upiAppsList.forEach((element) {
  //     appNamesList.add(UpiObject(
  //         name: element.name,
  //         packageName: element.packageName,
  //         icon: element.icon));
  //   });
  //
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           // Display radio buttons using RadioListTile
  //           Column(
  //             children: appNamesList.map((UpiObject upiObject) {
  //               return RadioListTile<UpiObject>(
  //                 title: Text(upiObject.name),
  //                 value: upiObject,
  //                 groupValue: selectedPackageName,
  //                 onChanged: (UpiObject? value) {
  //                   onRadioChanged(value);
  //                   Navigator.pop(context);
  //                 },
  //               );
  //             }).toList(),
  //           ),
  //           // Display selected package name
  //         ],
  //       );
  //     },
  //   );
  // }

  void onButtonPressed(UpiObject upiObject) {
    setState(() {
      selectedPackageName = upiObject;
    });

    apiCall("01", selectedPackageName?.packageName ?? '');
  }

  Uint8List decodeIcon(String base64String) {
    return base64Decode(base64String);
  }

  String formatString(String value) {
    double number = double.parse(value);
    return (number % 1 == 0) ? number.toInt().toString() : value;
  }
}

// Map<String, String> apiData = {"merchantTransactionId": merchantTxnId!};
// var apiUrl = 'https://www.transportapp.co.in/PhonepePG/PayResponce';
// // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
// // String? token = sharedPreferences.getString(AppConstant.accessToken);
//
// Map<String, String> headers = {
//   'Content-Type': 'application/json',
//   "Authorization": "Bearer $token"
// };
// setState(() {
//   isLoading = true;
// });
//
//
// Future.delayed(Duration(seconds: 0), () async{
//
// var response2 = await http.post(Uri.parse(apiUrl),
//     headers:headers,
//     body: jsonEncode(apiData));
//
// if (response2.statusCode == 200) {
//   var jsonResponse2 = json.decode(response2.body);
//
//   var responseData2 = jsonResponse2['data'];
//
//   var responceStatus = responseData2['responceStatus'];
//   var transactionId = responseData2['transactionId'];
//   var isResponceReceived = responseData2['isResponceReceived'];
//   setState(() {
//     isLoading = false;
//   });
//
//   print('$responceStatus status');
//   if (responceStatus == 'PAYMENT_SUCCESS') {
//     showCustomSnackBar("SUCCESS", context, isError: false);
//    // print("$sepratedList Separated List");
//
//     appNamesList.clear();
//
//     var paymentRequest2 = PaymentRequest2(
//         sourceStopId: widget.sourceStopId,
//         destinationStopId: widget.destinationStopId,
//         discountype: discountType,
//         txnStatus: responceStatus == "PAYMENT_SUCCESS" ? "SUCCESS" : "FAILED",
//         merchantId: "",
//         sourcecompanycode: widget.serviceType == "AMTS" ? "103" : "102",
//         destinationcompanycode:
//         widget.serviceType == "AMTS" ? "103" : "102",
//         fpTransactionId: "",
//         routeCode: widget.routeCode,
//         externalTxnId: "",
//         merchantTxnId: merchantTxnId,
//         transactionDateTime: "",
//         serviceType: widget.serviceType,
//         paymentType: 1,
//         paymentState: "",
//         pgServiceTransactionId: "",
//         pgTransactionId: "");
//
//     BlocProvider.of<PaymentBloc>(context).add(
//       GetQRCodeEvent(paymentRequest: paymentRequest2),
//     );
//
//     Get.to(() => PaymentDetailsScreen());
//   }
//   else if (responceStatus == null || responceStatus == 'PAYMENT_PENDING'
//   ) {
//     showCustomSnackBar("PENDING", context, isError: false);
//
//     var paymentRequest2 = PaymentRequest2(
//         sourceStopId: widget.sourceStopId,
//         destinationStopId: widget.destinationStopId,
//         discountype: discountType,
//         txnStatus:"PENDING",
//         merchantId: "",
//         sourcecompanycode: widget.serviceType == "AMTS" ? "103" : "102",
//         destinationcompanycode:
//         widget.serviceType == "AMTS" ? "103" : "102",
//         fpTransactionId: "",
//         routeCode: widget.routeCode,
//         externalTxnId: "",
//         merchantTxnId: merchantTxnId,
//         transactionDateTime: "",
//         serviceType: widget.serviceType,
//         paymentType: 1,
//         paymentState: "",
//         pgServiceTransactionId: "",
//         pgTransactionId: "");
//
//     BlocProvider.of<PaymentBloc>(context).add(
//       GetQRCodeEvent(paymentRequest: paymentRequest2),
//     );
//     Get.to(() => PendingScreen());
//     appNamesList.clear();
//   }
//   else if (responceStatus == 'PAYMENT_ERROR') {
//     showCustomSnackBar("FAILED", context, isError: false);
//
//     var paymentRequest2 = PaymentRequest2(
//         sourceStopId: widget.sourceStopId,
//         destinationStopId: widget.destinationStopId,
//         discountype: discountType,
//         txnStatus:"FAILED",
//         merchantId: "",
//         sourcecompanycode: widget.serviceType == "AMTS" ? "103" : "102",
//         destinationcompanycode:
//         widget.serviceType == "AMTS" ? "103" : "102",
//         fpTransactionId: "",
//         routeCode: widget.routeCode,
//         externalTxnId: "",
//         merchantTxnId: merchantTxnId,
//         transactionDateTime: "",
//         serviceType: widget.serviceType,
//         paymentType: 1,
//         paymentState: "",
//         pgServiceTransactionId: "",
//         pgTransactionId: "");
//
//     BlocProvider.of<PaymentBloc>(context).add(
//       GetQRCodeEvent(paymentRequest: paymentRequest2),
//     );
//     appNamesList.clear();
//     Get.toNamed(RouteHelper.transactionStatus);
//   }
// } else {
//   appNamesList.clear();
//   print('Request failed with status code: ${response2.statusCode}');
// }
// });
