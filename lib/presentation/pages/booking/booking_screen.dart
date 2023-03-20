import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground2,
      body: SafeArea(
        child: Column(
          children: [
            CustomToolbar(
              title: "booking",
              showOption: false,
              back: widget.from == "home" ? true : false,
            ),
            Expanded(
              child: Center(
                child: Text(
                  "No Data Found",
                  style: screenTitle,
                ),
              ),
            )
            // Expanded(
            //   child: ListView.builder(
            //     padding: EdgeInsets.zero,
            //       shrinkWrap: true,
            //       itemCount: 5,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           padding: const EdgeInsets.symmetric(
            //               horizontal: Dimensions.dp16, vertical: Dimensions.dp26),
            //           margin: const EdgeInsets.only(
            //               left: Dimensions.dp16,
            //               right: Dimensions.dp16,
            //               top: Dimensions.dp10),
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
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: [
            //                   Expanded(
            //                     child: Text(
            //                       "16 Nov, 2022, 08:04 PM",
            //                       textAlign: TextAlign.center,
            //                       style: satoshiRegular.copyWith(
            //                           fontSize: Dimensions.dp14,
            //                           fontWeight: FontWeight.w400,
            //                           color: AppColors.black),
            //                     ),
            //                   ),
            //                   Expanded(
            //                     child: Text(
            //                       "Payment Received",
            //                       textAlign: TextAlign.center,
            //                       style: satoshiRegular.copyWith(
            //                           fontSize: Dimensions.dp15,
            //                           fontWeight: FontWeight.w500,
            //                           color: AppColors.black),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 14.h,
            //               ),
            //               Text(
            //                 AppLocalizations.of(context)?.translate('amount') ?? "",
            //                 textAlign: TextAlign.center,
            //                 style: satoshiRegular.copyWith(
            //                     fontSize: Dimensions.dp15,
            //                     fontWeight: FontWeight.w500,
            //                     color: AppColors.black),
            //               ),
            //               Text(
            //                 "₹50.00",
            //                 textAlign: TextAlign.center,
            //                 style: satoshiRegular.copyWith(
            //                     fontSize: Dimensions.dp14,
            //                     fontWeight: FontWeight.w400,
            //                     color: AppColors.black),
            //               ),
            //               SizedBox(
            //                 height: 12.h,
            //               ),
            //               Text(
            //                 AppLocalizations.of(context)?.translate('orderid') ?? "",
            //                 textAlign: TextAlign.center,
            //                 style: satoshiRegular.copyWith(
            //                     fontSize: Dimensions.dp15,
            //                     fontWeight: FontWeight.w500,
            //                     color: AppColors.black),
            //               ),
            //               Text(
            //                 "e459956s-56ff-11ee-12fdg-745254856",
            //                 textAlign: TextAlign.center,
            //                 style: satoshiRegular.copyWith(
            //                     fontSize: Dimensions.dp14,
            //                     fontWeight: FontWeight.w400,
            //                     color: AppColors.black),
            //               ),
            //               SizedBox(
            //                 height: 18.h,
            //               ),
            //               const Divider(
            //                 thickness: 1,
            //                 height: 1,
            //                 color: AppColors.lightGray,
            //               ),
            //               SizedBox(
            //                 height: 21.h,
            //               ),
            //               Row(
            //                 children: [
            //                   SvgPicture.asset(ImageConstant.iRedBus),
            //                   const SizedBox(
            //                     width: 3,
            //                   ),
            //                   Text(
            //                     "4U",
            //                     style: satoshiSmall.copyWith(
            //                         fontWeight: FontWeight.w700,
            //                         color: Theme.of(context).primaryColor),
            //                   ),
            //                   const SizedBox(
            //                     width: Dimensions.dp8,
            //                   ),
            //                   SvgPicture.asset(ImageConstant.iRightGrayArrow),
            //                   const SizedBox(
            //                     width: Dimensions.dp8,
            //                   ),
            //                   SvgPicture.asset(
            //                     ImageConstant.iRedBus,
            //                     color: AppColors.primaryColor,
            //                   ),
            //                   const SizedBox(
            //                     width: Dimensions.dp4,
            //                   ),
            //                   Text(
            //                     "15D",
            //                     style: satoshiSmall.copyWith(
            //                         fontWeight: FontWeight.w700,
            //                         color: AppColors.primaryColor),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 21.h,
            //               ),
            //               Row(
            //                 children: [
            //                   SvgPicture.asset(
            //                     ImageConstant.iRoute,
            //                     color: AppColors.primaryColor,
            //                     height: Dimensions.dp16,
            //                     width: Dimensions.dp16,
            //                   ),
            //                   const SizedBox(
            //                     width: 5,
            //                   ),
            //                   RichText(
            //                     text: TextSpan(
            //                       text: AppLocalizations.of(context)?.translate('changeat') ?? "",
            //                       style: satoshiRegular.copyWith(
            //                           fontSize: Dimensions.dp14,
            //                           fontWeight: FontWeight.w400,
            //                           color: AppColors.darkGray),
            //                       children: <TextSpan>[
            //                         TextSpan(
            //                             text: " ",
            //                             style: satoshiRegular.copyWith(
            //                                 fontSize: Dimensions.dp14,
            //                                 fontWeight: FontWeight.w700)),
            //                         TextSpan(
            //                             text: "RTO Circle",
            //                             style: satoshiRegular.copyWith(
            //                                 color: AppColors.darkGray,
            //                                 fontSize: Dimensions.dp14,
            //                                 fontWeight: FontWeight.w700)),
            //                       ],
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //               SizedBox(
            //                 height: 18.h,
            //               ),
            //               const Divider(
            //                 thickness: 1,
            //                 height: 1,
            //                 color: AppColors.lightGray,
            //               ),
            //               SizedBox(
            //                 height: 21.h,
            //               ),
            //               RichText(
            //                 text: TextSpan(
            //                   text: AppLocalizations.of(context)?.translate("ticketStatus") ?? "",
            //                   style: satoshiRegular.copyWith(
            //                       fontSize: Dimensions.dp14,
            //                       fontWeight: FontWeight.w700,
            //                       color: AppColors.darkGray),
            //                   children: <TextSpan>[
            //                     TextSpan(
            //                         text: "Failed",
            //                         style: satoshiRegular.copyWith(
            //                             color: AppColors.darkGray,
            //                             fontSize: Dimensions.dp14,
            //                             fontWeight: FontWeight.w400)),
            //                   ],
            //                 ),
            //               ),
            //               RichText(
            //                 text: TextSpan(
            //                   text: AppLocalizations.of(context)?.translate("refundStatus") ?? "",
            //                   style: satoshiRegular.copyWith(
            //                       fontSize: Dimensions.dp14,
            //                       fontWeight: FontWeight.w700,
            //                       color: AppColors.darkGray),
            //                   children: <TextSpan>[
            //                     TextSpan(
            //                         text: "Refunded",
            //                         style: satoshiRegular.copyWith(
            //                             color: AppColors.darkGray,
            //                             fontSize: Dimensions.dp14,
            //                             fontWeight: FontWeight.w400)),
            //                   ],
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 12.h,
            //               ),
            //               Text(
            //                 "Amount has been refunded vide ARN no 74585652325 drom AMC to your issuing bank. Kindly Contact your issuing bank for status update.",
            //                 textAlign: TextAlign.start,
            //                 style: satoshiRegular.copyWith(
            //                     fontSize: Dimensions.dp14,
            //                     fontWeight: FontWeight.w400,
            //                     color: AppColors.black),
            //               ),
            //               SizedBox(
            //                 height: 8.h,
            //               ),
            //             ],
            //           ),
            //         );
            //       }),
            // )
          ],
        ),
      ),
    );
  }
}
