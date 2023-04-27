import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/booking/booking_list_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/booking/booking_list_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/booking/booking_list_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/app_colors.dart';

class BookingScreen extends StatefulWidget {
  final String? from;

  const BookingScreen({Key? key, required this.from}) : super(key: key);

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  String token = "";

  @override
  void initState() {
    super.initState();
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
    BlocProvider.of<BookingListBloc>(context)
        .add(GetBookingListEvent(from: widget.from ?? "home"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            CustomToolbar(
              title: widget.from == "home" ? "transaction_history" : "booking",
              showOption: false,
              back: widget.from == "home" ? true : false,
            ),
            BlocBuilder<BookingListBloc, BookingListState>(
              builder: (context, state) {
                if (state is BookingListLoadingState) {
                  Loader.show(context);
                } else if (state is BookingListSuccessState) {
                  Loader.hide();
                  if (state.bookingListResponse.data!.isEmpty) {
                    return Center(
                        child: Text(
                      "No Booking Available",
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp19,
                          fontWeight: FontWeight.w500,
                          color: AppColors.darkGray),
                    ));
                  } else {
                    return Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: state.bookingListResponse.data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteHelper.getRouteTicket(state
                                        .bookingListResponse
                                        .data![index]
                                        .ticketNo
                                        .toString() ??
                                    ""));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Dimensions.dp16,
                                    vertical: Dimensions.dp26),
                                margin: const EdgeInsets.only(
                                    left: Dimensions.dp16,
                                    right: Dimensions.dp16,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          toDate(state
                                                  .bookingListResponse
                                                  .data![index]
                                                  .transactionDatetime ??
                                              ""),
                                          textAlign: TextAlign.center,
                                          style: satoshiRegular.copyWith(
                                              fontSize: Dimensions.dp14,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black),
                                        ),
                                        Spacer(),
                                        Expanded(
                                          child: Text(
                                            "Payment Received",
                                            textAlign: TextAlign.center,
                                            style: satoshiRegular.copyWith(
                                                fontSize: Dimensions.dp15,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 14.h,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)
                                              ?.translate('amount') ??
                                          "",
                                      textAlign: TextAlign.center,
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    Text(
                                      "₹ ${getFare(int.parse(state.bookingListResponse.data![index].fareAmt.toString().isEmpty ? "0" : state.bookingListResponse.data![index].fareAmt.toString()))}",
                                      textAlign: TextAlign.center,
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Text(
                                      "Order ID ",
                                      textAlign: TextAlign.center,
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp15,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.black),
                                    ),
                                    Text(
                                      state.bookingListResponse.data![index]
                                              .transactionNo ??
                                          "",
                                      textAlign: TextAlign.center,
                                      style: satoshiRegular.copyWith(
                                          fontSize: Dimensions.dp14,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black),
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: AppColors.lightGray,
                                    ),
                                    SizedBox(
                                      height: 21.h,
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          ImageConstant.iRoute,
                                          color: Theme.of(context).primaryColor,
                                          height: Dimensions.dp16,
                                          width: Dimensions.dp16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text: state
                                                            .bookingListResponse
                                                            .data![index]
                                                            .sourceStopName ??
                                                        "",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: AppColors
                                                                .darkGray,
                                                            fontSize:
                                                                Dimensions.dp14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                TextSpan(
                                                    text: " TO ",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontSize:
                                                                Dimensions.dp14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                TextSpan(
                                                    text: state
                                                            .bookingListResponse
                                                            .data![index]
                                                            .destinationStopName ??
                                                        "",
                                                    style:
                                                        satoshiRegular.copyWith(
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            color: AppColors
                                                                .darkGray,
                                                            fontSize:
                                                                Dimensions.dp14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    const Divider(
                                      thickness: 1,
                                      height: 1,
                                      color: AppColors.lightGray,
                                    ),
                                    SizedBox(
                                      height: 21.h,
                                    ),
                                    // RichText(
                                    //   text: TextSpan(
                                    //     text: AppLocalizations.of(context)
                                    //             ?.translate("ticketStatus") ??
                                    //         "",
                                    //     style: satoshiRegular.copyWith(
                                    //         fontSize: Dimensions.dp14,
                                    //         fontWeight: FontWeight.w700,
                                    //         color: AppColors.darkGray),
                                    //     children: <TextSpan>[
                                    //       TextSpan(
                                    //           text: "Failed",
                                    //           style: satoshiRegular.copyWith(
                                    //               color: AppColors.darkGray,
                                    //               fontSize: Dimensions.dp14,
                                    //               fontWeight: FontWeight.w400)),
                                    //     ],
                                    //   ),
                                    // ),
                                    // RichText(
                                    //   text: TextSpan(
                                    //     text: AppLocalizations.of(context)
                                    //             ?.translate("refundStatus") ??
                                    //         "",
                                    //     style: satoshiRegular.copyWith(
                                    //         fontSize: Dimensions.dp14,
                                    //         fontWeight: FontWeight.w700,
                                    //         color: AppColors.darkGray),
                                    //     children: <TextSpan>[
                                    //       TextSpan(
                                    //           text: "Refunded",
                                    //           style: satoshiRegular.copyWith(
                                    //               color: AppColors.darkGray,
                                    //               fontSize: Dimensions.dp14,
                                    //               fontWeight: FontWeight.w400)),
                                    //     ],
                                    //   ),
                                    // ),
                                    // SizedBox(
                                    //   height: 12.h,
                                    // ),
                                    // Text(
                                    //   "Amount has been refunded vide ARN no 74585652325 drom SMC to your issuing bank. Kindly Contact your issuing bank for status update.",
                                    //   textAlign: TextAlign.start,
                                    //   style: satoshiRegular.copyWith(
                                    //       fontSize: Dimensions.dp14,
                                    //       fontWeight: FontWeight.w400,
                                    //       color: AppColors.black),
                                    // ),
                                    // SizedBox(
                                    //   height: 8.h,
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  }
                } else if (state is BookingListFailedState) {
                  Loader.hide();
                }
                return Center(
                    child: Text(
                  "No Booking Available",
                  style: satoshiRegular.copyWith(
                      fontSize: Dimensions.dp19,
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGray),
                ));
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }
}
