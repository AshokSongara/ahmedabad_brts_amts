import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_state.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class PassengerDetails extends StatefulWidget {
  const PassengerDetails({
    Key? key,
    required this.sourceStopId,
    required this.destinationStopId,
    required this.routeCode,
    required this.serviceType,
  }) : super(key: key);

  final String? sourceStopId;
  final String? destinationStopId;
  final String? routeCode;
  final String? serviceType;

  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {
  int _addedAdultsCount = 0;
  int _addedKidsCount = 0;
  List<String?> list = [];
  String? selectedOption = "PhonePe";
  String token = "";

  @override
  void initState() {
    super.initState();
    list = Get.arguments as List<String?>;
    getMemberID();
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
                  SizedBox(height: 20.h,),

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
                            title: Text("PhonePe",style: poppinsMedium.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w400)),
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
                        SizedBox(height: 10.h,),
                        Container(
                          decoration: const BoxDecoration(
                            color: AppColors.grayC4C$C$,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: RadioListTile(
                            title: Text("Fiser", style: poppinsMedium.copyWith(fontSize: 18.sp,fontWeight: FontWeight.w400)),
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
                                        Get.toNamed(
                                            RouteHelper.getPaymentDetailsRoute(
                                                widget.sourceStopId ?? "",
                                                widget.destinationStopId ?? "",
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
                                                widget.serviceType ?? "","Payment"));
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
