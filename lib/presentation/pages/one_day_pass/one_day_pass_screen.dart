import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/one_day_pass_response.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import '../../../utils/dimensions.dart';

class LocalModel {
  String name;
  String price;
  bool isChecked;
  bool isEnable;

  LocalModel(this.name, this.price, this.isChecked, this.isEnable);
}

class OneDayPassScreen extends StatefulWidget {
  final String? sourceStationID;
  final String? serviceType;

  const OneDayPassScreen({Key? key,required this.sourceStationID,required this.serviceType}) : super(key: key);

  @override
  _OneDayPassScreenState createState() => _OneDayPassScreenState();
}

class _OneDayPassScreenState extends State<OneDayPassScreen> {
  String token = "";
  Data? data;
  @override
  void initState() {
    super.initState();
   // getMemberID();
    getData();
  }

  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstant.accessToken) ?? "";
    if (token.isNotEmpty) {
      getData();
    }
  }

  getData() {
    BlocProvider.of<OneDayBloc>(context).add(const GetOneDayEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: BlocConsumer<OneDayBloc, OneDayState>(
          listener: (context, state) {
            if (state is OneDayLoadingState) {
              Loader.show(context);
            } else if (state is OneDaySuccessState) {
              Loader.hide();
            } else if (state is OneDayFailedState) {
              Loader.hide();
            }
          },
          builder: (context, state) {
            if(state is OneDaySuccessState){
              return Column(
                children: [
                  CustomToolbar(
                    title: "onedaypass",
                  ),
                  const SizedBox(
                    height: Dimensions.dp10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 29,
                    ),
                    margin: const EdgeInsets.only(
                        left: Dimensions.dp24, right: Dimensions.dp24),
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
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: AppColors.profileBackgroundGrey,
                      ),
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.oneDayPassResponse.data?.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      data = state.oneDayPassResponse.data![index];
                                    });
                                    // state.oneDayPassResponse.data![index].isChecked = state.oneDayPassResponse.data![index].isChecked;
                                    // setState(() {});
                                  },
                                  child: RadioListTile(
                                    value: state.oneDayPassResponse.data![index],
                                    groupValue: data,
                                    onChanged: (Data? value){
                                      setState(() {
                                        data = value;
                                      });
                                    },
                                    activeColor: Theme.of(context).primaryColor,
                                    title: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.oneDayPassResponse.data![index].catPassSubCateName ?? "",
                                            maxLines: 2,
                                            style: satoshiRegular.copyWith(
                                              overflow: TextOverflow.ellipsis,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors
                                                    .black),
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          getFare(int.parse(state.oneDayPassResponse.data![index].passFare.toString())),
                                          style: satoshiRegular.copyWith(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w500,
                                              color:
                                              AppColors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: Dimensions.dp10,
                                right: Dimensions.dp10,
                                top: Dimensions.dp14),
                            child: CustomButton(
                              text: "Proceed To Payment",
                              width: MediaQuery.of(context).size.width,
                              onPressed: () {
                                if (data == null) {
                                  showCustomSnackBar(
                                      "Please Select Ticket", context,
                                      isError: true);
                                } else {
                                  AppConstant.nameData.isEmpty ?
                                  Get.toNamed(RouteHelper.getSplashRoute())  : getPaymentUrl(
                                      data!.discountTypeCode.toString() ?? "");
                                }
                              },
                              style: satoshiRegular.copyWith(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                              height: Dimensions.dp53, color: Theme.of(context).primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  getPaymentUrl(String discountType) {
    Get.toNamed(RouteHelper.getPaymentDetailsRoute(
        widget.sourceStationID ?? "",
        "PASS" ?? "",
        data!.discountTypeCode ?? "",
        "",
        "",
        "",
        "",
        "" ?? "",
        widget.serviceType ?? "",
        "Payment"));
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }
}
