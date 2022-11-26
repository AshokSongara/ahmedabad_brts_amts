library order_tracker;

import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderTracker extends StatefulWidget {
  ///This variable is used to set status of order, this get only enum which is already in a package below example present.
  /// Status.order
  final Status? status;

  /// This variable is used to get list of order sub title and date to show present status of product.
  final List<TextDto>? orderTitleAndDateList;

  /// This variable is used to get list of shipped sub title and date to show present status of product.
  final List<TextDto>? shippedTitleAndDateList;

  /// This variable is used to get list of outOfDelivery sub title and date to show present status of product.
  final List<TextDto>? outOfDeliveryTitleAndDateList;

  /// This variable is used to get list of delivered sub title and date to show present status of product.
  final List<TextDto>? deliveredTitleAndDateList;

  /// This variable is used to change color of active animation border.
  final Color? activeColor;

  /// This variable is used to change color of inactive animation border.
  final Color? inActiveColor;

  /// This variable is used to change style of heading title text.
  final TextStyle? headingTitleStyle;

  /// This variable is used to change style of heading date text.
  final TextStyle? headingDateTextStyle;

  /// This variable is used to change style of sub title text.
  final TextStyle? subTitleTextStyle;

  /// This variable is used to change style of sub date text.
  final TextStyle? subDateTextStyle;

  const OrderTracker(
      {Key? key,
      required this.status,
      this.orderTitleAndDateList,
      this.shippedTitleAndDateList,
      this.outOfDeliveryTitleAndDateList,
      this.deliveredTitleAndDateList,
      this.activeColor,
      this.inActiveColor,
      this.headingTitleStyle,
      this.headingDateTextStyle,
      this.subTitleTextStyle,
      this.subDateTextStyle})
      : super(key: key);

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker>
    with TickerProviderStateMixin {
  ///This is first animation progress bar controller.
  AnimationController? controller;

  ///This is second animation progress bar controller.
  AnimationController? controller2;

  ///This is third animation progress bar controller.
  AnimationController? controller3;

  ///This is conditional variable.
  bool isFirst = false;
  bool isSecond = false;
  bool isThird = false;

  @override
  void initState() {
    if (widget.status?.name == Status.order.name) {
      ///initialize first controller
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller?.value != null && controller!.value > 0.99) {
            controller?.stop();
          }
          setState(() {});
        });
    } else if (widget.status?.name == Status.shipped.name) {
      ///initialize first controller
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller?.value != null && controller!.value > 0.99) {
            controller?.stop();
            controller2?.stop();
            isFirst = true;
            controller2?.forward(from: 0.0);
          }
          setState(() {});
        });

      ///initialize second controller
      controller2 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller2?.value != null && controller2!.value > 0.99) {
            controller2?.stop();
            controller3?.stop();
            isSecond = true;
            controller3?.forward(from: 0.0);
          }
          setState(() {});
        });
    } else if (widget.status?.name == Status.outOfDelivery.name ||
        widget.status?.name == Status.delivered.name) {
      ///initialize first controller
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller?.value != null && controller!.value > 0.99) {
            controller?.stop();
            controller2?.stop();
            controller3?.stop();
            isFirst = true;
            controller2?.forward(from: 0.0);
          }
          setState(() {});
        });

      ///initialize second controller
      controller2 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller2?.value != null && controller2!.value > 0.99) {
            controller2?.stop();
            controller3?.stop();
            isSecond = true;
            controller3?.forward(from: 0.0);
          }
          setState(() {});
        });

      ///initialize third controller
      controller3 = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      )..addListener(() {
          if (controller3?.value != null && controller3!.value > 0.99) {
            controller3?.stop();
            isThird = true;
          }
          setState(() {});
        });
    }

    controller?.repeat(reverse: false);
    controller2?.repeat(reverse: false);
    controller3?.repeat(reverse: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: widget.activeColor ?? Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Adalaj Gam",
                  style: satoshiRegularSmallDark,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Row(children: [
                    SvgPicture.asset(ImageConstant.iRedBus),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "15U",
                      style: satoshiSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: SizedBox(
                    width: 2,
                    height: widget.orderTitleAndDateList != null &&
                            widget.orderTitleAndDateList!.isNotEmpty
                        ? widget.orderTitleAndDateList!.length * 46
                        : 60,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: LinearProgressIndicator(
                        value: controller?.value ?? 0.0,
                        backgroundColor:
                            widget.inActiveColor ?? Colors.grey[300],
                        color: AppColors.darkGray,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderTitleAndDateList?[index].date ?? "",
                              style: satoshiSmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: AppColors.primaryColor),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 4,
                        );
                      },
                      itemCount: widget.orderTitleAndDateList != null &&
                              widget.orderTitleAndDateList!.isNotEmpty
                          ? widget.orderTitleAndDateList!.length
                          : 0),
                )
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 40,
                ),
                Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: widget.activeColor ?? Colors.green,
                      borderRadius: BorderRadius.circular(50)),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Ranip Cross Road",
                  style: satoshiRegularSmallDark,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                  child: Row(children: [
                    SvgPicture.asset(ImageConstant.iRedBus),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      "15U",
                      style: satoshiSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: SizedBox(
                    width: 2,
                    height: widget.orderTitleAndDateList != null &&
                            widget.orderTitleAndDateList!.isNotEmpty
                        ? widget.orderTitleAndDateList!.length * 46
                        : 60,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: LinearProgressIndicator(
                        value: controller?.value ?? 0.0,
                        backgroundColor:
                            widget.inActiveColor ?? Colors.grey[300],
                        color: AppColors.darkGray
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderTitleAndDateList?[index].date ?? "",
                              style: satoshiSmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: AppColors.primaryColor),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 4,
                        );
                      },
                      itemCount: widget.orderTitleAndDateList != null &&
                              widget.orderTitleAndDateList!.isNotEmpty
                          ? widget.orderTitleAndDateList!.length
                          : 0),
                )
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 38,
                ),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: SvgPicture.asset(ImageConstant.iLocationSolid),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Ahmedabad Airport",
                  style: satoshiRegularSmallDark,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class TextDto {
  String? title;
  String? date;

  TextDto(this.title, this.date);
}

enum Status { order, shipped, outOfDelivery, delivered }
