library order_tracker;

import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderTracker extends StatefulWidget {
  final String startRouteTitle;
  final String endRouteTitle;
  final String routeCode;
  final List<Data>? orderTitleAndDateList;
  final Color? activeColor;
  final Color? inActiveColor;
  final TextStyle? headingTitleStyle;

  const OrderTracker(
      {Key? key,
      required this.startRouteTitle,
      required this.endRouteTitle,
      required this.routeCode,
      this.orderTitleAndDateList,
      this.activeColor,
      this.inActiveColor,
      this.headingTitleStyle})
      : super(key: key);

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  bool showList = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 50,
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
              widget.startRouteTitle,
              style: satoshiRegularSmallDark,
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 50,
              child: Row(children: [
                SvgPicture.asset(
                  ImageConstant.iRedBus,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  widget.routeCode,
                  style: satoshiSmall.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).primaryColor),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: SizedBox(
                width: 2,
                height: widget.orderTitleAndDateList != null &&
                        widget.orderTitleAndDateList!.isNotEmpty
                    ? widget.orderTitleAndDateList!.length * 30
                    : 60,
                child: LinearProgressIndicator(
                  backgroundColor: widget.inActiveColor ?? Colors.grey[300],
                  color: AppColors.darkGray,
                ),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: showList
                  ? ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderTitleAndDateList?[index].stopName ??
                                  "",
                              style: satoshiSmall.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13.sp,
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 0,
                        );
                      },
                      itemCount: widget.orderTitleAndDateList != null &&
                              widget.orderTitleAndDateList!.isNotEmpty
                          ? widget.orderTitleAndDateList!.length
                          : 0)
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          showList = true;
                        });
                      },
                      child: Text(
                        "${widget.orderTitleAndDateList?.length.toString()}+",
                        style: satoshiSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
            )
          ],
        ),
        Row(
          children: [
            const SizedBox(
              width: 50,
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
              widget.endRouteTitle,
              style: satoshiRegularSmallDark,
            ),
          ],
        ),
      ],
    );
  }
}

