import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/route_title_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/base/order_tracker.dart';

class RouteDetailScreen extends StatefulWidget {
  const RouteDetailScreen({Key? key}) : super(key: key);

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Column(children: [
        const SizedBox(height: 25),
        CustomToolbar(title: "Route Details"),
        Container(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Start Time",
                    style: screenTitle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(ImageConstant.iRedTime),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "11:38 AM",
                        style: screenTitle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Interchange",
                    style: screenTitle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(ImageConstant.iRoute)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "1",
                        style: screenTitle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Fare",
                    style: screenTitle.copyWith(
                        fontWeight: FontWeight.w700, fontSize: 16.sp),
                  ),
                  Row(
                    children: [
                      SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(ImageConstant.iTicket)),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "₹50.00",
                        style: screenTitle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        RouteTitleWidget(mainAxisAlignment: MainAxisAlignment.start),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.all(20),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: OrderTracker(
              status: Status.delivered,
              activeColor: AppColors.primaryColor,
              inActiveColor: Colors.grey[300],
              orderTitleAndDateList: AppConstant.orderList,
              shippedTitleAndDateList: AppConstant.shippedList,
              outOfDeliveryTitleAndDateList: AppConstant.outOfDeliveryList,
              deliveredTitleAndDateList: AppConstant.deliveredList,
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 40,bottom: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "ETA",
                        style: screenTitle.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 16.sp),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(ImageConstant.iRedTime),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "12 Mins",
                            style: screenTitle.copyWith(
                                fontWeight: FontWeight.w500, fontSize: 15.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      text: "Book Tickets",
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () {
                        Get.toNamed(RouteHelper.getPassengerDetailsRoute());
                      },
                      color: AppColors.primaryColor,
                      style: poppinsMedium.copyWith(
                          color: Colors.white, fontSize: 15.sp),
                      height: 53,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
