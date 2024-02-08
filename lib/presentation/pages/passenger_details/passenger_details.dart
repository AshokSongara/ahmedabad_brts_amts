import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_event.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/json_request.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/payment_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
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

class PassengerDetails extends StatefulWidget {
  const PassengerDetails(
      {Key? key,
      required this.sourceStopId,
      required this.destinationStopId,
      required this.routeCode,
      required this.serviceType,
      this.fare})
      : super(key: key);

  final String? sourceStopId;
  final String? destinationStopId;
  final String? routeCode;
  final String? serviceType;
  final String? fare;

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
  List<String> appNamesList = [];
  String? selectedPackageName;


  PhonepeRequest? phonepeRequest;

  List upiAppsListAndroid = [];
  bool appOpen = false;

  @override
   initState()  {
    super.initState();

    // initPlatformState();
    list = Get.arguments as List<String?>;

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
    }
  }

  getData() {
    BlocProvider.of<DiscountBloc>(context).add(const GetDiscountEvent());
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
            Loader.hide();
          } else if (state is DiscountFailedState) {
            Loader.hide();
          }
        },
        builder: (context, state) {
          if (state is DiscountSuccessState) {
            return SafeArea(
              child: Column(
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
                        top: Dimensions.dp35),
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
                        getSourceDestination(list[0] ?? "",
                            "${DateFormat('dd MMM yyyy').format(DateTime.now())}, ${list[2]}"),
                        Expanded(
                          flex: 1,
                          child: SvgPicture.asset(ImageConstant.iArrowRight),
                        ),
                        getSourceDestination(list[1] ?? "",
                            "${DateFormat('dd MMM yyyy').format(DateTime.now())}, ${list[3]}")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        _showBottomSheet();
                      },
                      child: Text('Select UPI App'),
                    ),
                  ),

                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.grayC4C$C$,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: RadioListTile(
                            title: Text("UPI apps",
                                style: poppinsMedium.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400)),
                            value: "PhonePe",
                            activeColor: AppColors.primaryColor,
                            //tileColor: Colors.grey,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value as String?;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.grayC4C$C$,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: RadioListTile(
                            title: Text("Fiserv",
                                style: poppinsMedium.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400)),
                            value: "Fiser",
                            activeColor: AppColors.primaryColor,
                            groupValue: selectedOption,
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value as String?;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.discountResponse.data?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              left: Dimensions.dp24,
                              right: Dimensions.dp24,
                              top: Dimensions.dp35),
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 18, left: 18),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.discountResponse.data![index]
                                              .catPassSubCateName ??
                                          "",
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.darkGray),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (selectedOption == "PhonePe") {
                                          apiCall(state
                                                  .discountResponse
                                                  .data![index]
                                                  .discountTypeCode ??
                                              "");
                                        } else {
                                          Get.toNamed(RouteHelper
                                              .getPaymentDetailsRoute(
                                                  widget.sourceStopId ?? "",
                                                  widget.destinationStopId ??
                                                      "",
                                                  state
                                                          .discountResponse
                                                          .data![index]
                                                          .discountTypeCode ??
                                                      "",
                                                  "",
                                                  "",
                                                  "",
                                                  "",
                                                  widget.routeCode ?? "",
                                                  widget.serviceType ?? "",
                                                  "Payment"));
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 15),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                Dimensions.dp5,
                                              ),
                                            ),
                                            border: Border.all(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        child: Text("Book Ticket",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
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

  void apiCall(String discountType) async {
    // var value = await GetUPI.apps();
    // print(value.data);
    // upiAppsListAndroid = value.data;

    phonepeRequest = PhonepeRequest(
        startStopCode: widget.sourceStopId,
        endStopCode: widget.destinationStopId,
        discountype: "01",
        routeCode: widget.routeCode,
        routeType: 1,
        mobileNumber: "9601524257",
        deviceOS: Platform.isAndroid ? "ANDROID" : "IOS",
        paymentInstrumentType: "UPI_INTENT",
        targateApp: "com.google.android.apps.nbu.paisa.user");

    String jsonStr = jsonEncode(phonepeRequest);

    String url = 'https://www.transportapp.co.in:8081/PhonepePG/PayRequest';

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(AppConstant.accessToken);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonStr,
    );

    if (response.statusCode == 200) {
      print('Request successful! Response data:');
      print(response.body);

      final responseData = json.decode(response.body);

      String? intentUrl =
          responseData['data']['data']['instrumentResponse']['intentUrl'];
      String? merchantTxnId =
          responseData['data']['data']['merchantTransactionId'];

      print(merchantTxnId);
      List<UpiObject> upiAppsList = [];

      var values = await GetUPI.apps();
      upiAppsList = values.data;
      upiAppsList.forEach((element) {
        appNamesList.add(element.name);


      });
      print(appNamesList);

      MethodChannel channel = const MethodChannel('nativeChannel');
      await channel.invokeMethod('startPayment', intentUrl);

      // showCustomSnackBar(
      //     "$data",
      //     context,
      //     isError: false);
      //
      //
      //
      //                 var paymentRequest2 = PaymentRequest2(
      //                     sourceStopId:  widget.sourceStopId,
      //                     destinationStopId:
      //                     widget.destinationStopId,
      //                     discountype: discountType,
      //                     txnStatus: data == "Success" ? "SUCCESS" : "FAILED",
      //                     merchantId: "",
      //                     sourcecompanycode: widget.serviceType == "AMTS" ?"103" : "102",
      //                     destinationcompanycode: widget.serviceType == "AMTS" ?"103" : "102",
      //                     fpTransactionId: "",
      //                     routeCode: widget.routeCode,
      //                     externalTxnId: "",
      //                     merchantTxnId: merchantTxnId,
      //                     transactionDateTime: "",
      //                     serviceType: widget.serviceType,
      //                     paymentType: 1,
      //                     paymentState: "",
      //                     pgServiceTransactionId: "",
      //                     pgTransactionId: "");
      //
      //
      //                 BlocProvider.of<PaymentBloc>(context).add(
      //                   GetQRCodeEvent(paymentRequest: paymentRequest2),
      //                 );

      Get.to(() => PaymentDetailsScreen());
    } else {
      print('Request failed with status code: ${response.statusCode}');
    }
  }

  setPassengerData(int adultsCount, int kidsCount) {
    _addedKidsCount = kidsCount;
    _addedAdultsCount = adultsCount;
    setState(() {});
  }

  void onRadioChanged(String? value) {
    // Update the selected package name
    selectedPackageName = value;
    // You can perform additional actions based on the selected package name
    print('Selected Package Name: $value');
  }

  Future<void> _showBottomSheet() async {
    List<UpiObject> upiAppsList = [];

    var values = await GetUPI.apps();
    upiAppsList = values.data;
    upiAppsList.forEach((element) {
      appNamesList.add(element.name);


    });
    print(appNamesList);
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Display radio buttons using RadioListTile
            Column(
              children: appNamesList.map((String packageName) {
                return RadioListTile(
                  title: Text(packageName),
                  value: packageName,
                  groupValue: selectedPackageName,
                  onChanged: (String? value) {
                    // Handle radio button selection
                    onRadioChanged(value);
                    setState(() {
                      appNamesList.clear();
                    });
                    // Close the bottom sheet after selection
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
            // Display selected package name
          ],
        );
      },
    );
  }
}
