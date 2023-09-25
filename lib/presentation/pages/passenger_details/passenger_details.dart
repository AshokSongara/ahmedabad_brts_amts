import 'dart:convert';
import 'dart:math';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_event.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/payment_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
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
import 'package:intl/intl.dart';
import 'package:phone_pe_pg/phone_pe_pg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PassengerDetails extends StatefulWidget {
  const PassengerDetails({
    Key? key,
    required this.sourceStopId,
    required this.destinationStopId,
    required this.routeCode,
    required this.serviceType,
    this.fare
  }) : super(key: key);

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
  String? serviceTypee ;
  late PhonePePg? pePg;

  @override
  void initState() {
    super.initState();
   // initPlatformState();
    list = Get.arguments as List<String?>;
    getMemberID();

     pePg = PhonePePg(
      isUAT: true,
      saltKey: widget.serviceType == "BRTS" ? "ed6a2f0e-ddba-4a8f-881b-20828029d147" : "28ddbe05-3f0c-483a-b966-3291dd254713",
      saltIndex: "1",
    );
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



  PaymentRequest _paymentRequest({String? merchantCallBackScheme}) {
    String generateRandomString(int len) {
      const chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      Random rnd = Random();
      var s = String.fromCharCodes(Iterable.generate(
          len, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
      return s;
    }

    PaymentRequest paymentRequest = PaymentRequest(
      amount: double.tryParse(widget.fare!),
      callbackUrl: "",
      deviceContext: DeviceContext.getDefaultDeviceContext(
          merchantCallBackScheme: merchantCallBackScheme),
      merchantId: widget.serviceType == "BRTS" ?"AHMEDABADUAT" : "AMTSUAT",
      merchantTransactionId: generateRandomString(10).toUpperCase(),
      merchantUserId: generateRandomString(8).toUpperCase(),
      mobileNumber: "9601524257",
    );
    return paymentRequest;
  }

  PaymentRequest paypageRequestModel({String? merchantCallBackScheme}) =>
      _paymentRequest(merchantCallBackScheme: merchantCallBackScheme).copyWith(
          redirectUrl: "https://webhook.site/callback-url",
          redirectMode: 'GET',
          paymentInstrument: PayPagePaymentInstrument());

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
                  SizedBox(height: 20.h,),

                  // Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         decoration: const BoxDecoration(
                  //           color: AppColors.grayC4C$C$,
                  //           borderRadius: BorderRadius.all(Radius.circular(50)),
                  //         ),
                  //         margin: const EdgeInsets.only(left: 30, right: 30),
                  //         child: RadioListTile(
                  //           title: Text("PhonePe",style: poppinsMedium.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w400)),
                  //           value: "PhonePe",
                  //           activeColor: AppColors.primaryColor,
                  //           //tileColor: Colors.grey,
                  //           groupValue: selectedOption,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               selectedOption = value as String?;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //       SizedBox(height: 10.h,),
                  //       Container(
                  //         decoration: const BoxDecoration(
                  //           color: AppColors.grayC4C$C$,
                  //           borderRadius: BorderRadius.all(Radius.circular(50)),
                  //         ),
                  //         margin: const EdgeInsets.only(left: 30, right: 30),
                  //         child: RadioListTile(
                  //           title: Text("Fiserv", style: poppinsMedium.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w400)),
                  //           value: "Fiser",
                  //           activeColor: AppColors.primaryColor,
                  //           groupValue: selectedOption,
                  //           onChanged: (value) {
                  //             setState(() {
                  //               selectedOption = value as String?;
                  //             });
                  //           },
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                                        // if(selectedOption == "PhonePe")
                                        // {
                                        //   Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (_) => pePg!.startPayPageTransaction(
                                        //             onPaymentComplete:
                                        //                 (paymentResponse, paymentError) {
                                        //               Navigator.pop(context);
                                        //
                                        //               if (paymentResponse != null &&
                                        //                   paymentResponse.code ==
                                        //                       PaymentStatus.success) {
                                        //                 ScaffoldMessenger.of(context)
                                        //                     .showSnackBar(const SnackBar(
                                        //                     content: Text(
                                        //                         "Transaction Successful")));
                                        //
                                        //
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.success}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.code}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.message}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.state}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.amount}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.merchantId}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.merchantTransactionId}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.paymentInstrument}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.responseCode}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.responseCodeDescription}");
                                        //                 print("PAYMENT RESPONSE${paymentResponse?.data?.transactionId}");
                                        //
                                        //                 var paymentRequest2 = PaymentRequest2(
                                        //                     sourceStopId:  widget.sourceStopId,
                                        //                     destinationStopId:
                                        //                     widget.destinationStopId,
                                        //                     discountype: state
                                        //                         .discountResponse
                                        //                         .data![index]
                                        //                         .discountTypeCode ??
                                        //                         "",
                                        //                     txnStatus: "SUCCESS",
                                        //                     merchantId: paymentResponse?.data?.merchantId,
                                        //                     sourcecompanycode: widget.serviceType == "AMTS" ?"103" : "102",
                                        //                     destinationcompanycode: widget.serviceType == "AMTS" ?"103" : "102",
                                        //                     fpTransactionId: paymentResponse?.data?.transactionId,
                                        //                     routeCode: widget.routeCode,
                                        //                     externalTxnId: "",
                                        //                     merchantTxnId: paymentResponse?.data?.merchantTransactionId,
                                        //                     transactionDateTime:
                                        //                     "",
                                        //                     serviceType: widget.serviceType,
                                        //                     paymentType: 1,
                                        //                     paymentState: paymentResponse?.data?.state,
                                        //                     pgServiceTransactionId: paymentResponse?.data?.paymentInstrument?.pgServiceTransactionId,
                                        //                     pgTransactionId: paymentResponse?.data?.paymentInstrument?.pgTransactionId);
                                        //
                                        //                 BlocProvider.of<PaymentBloc>(context).add(
                                        //                   GetQRCodeEvent(paymentRequest: paymentRequest2),
                                        //                 );
                                        //
                                        //                 Get.to(() =>PaymentDetailsScreen());
                                        //
                                        //               } else {
                                        //                 ScaffoldMessenger.of(context)
                                        //                     .showSnackBar(SnackBar(
                                        //                     content: Text(
                                        //                         "Transaction Failed${paymentResponse?.success}")));
                                        //               }
                                        //             },
                                        //             paymentRequest: paypageRequestModel(),
                                        //           )));
                                        // }
                                        // else {
                                          Get.toNamed(
                                              RouteHelper
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
                                       // }
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
                                                color: Theme.of(context).primaryColor)),
                                        child: Text("Book Ticket",
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: Theme.of(context).primaryColor)),
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

  setPassengerData(int adultsCount, int kidsCount) {
    _addedKidsCount = kidsCount;
    _addedAdultsCount = adultsCount;
    setState(() {});
  }
}
