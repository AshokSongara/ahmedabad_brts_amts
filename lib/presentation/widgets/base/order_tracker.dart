library order_tracker;

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
  final List<dynamic>? orderTitleAndDateList;
  final List<dynamic>? orderTitleAndDateList2;
  final Color? activeColor;
  final Color? inActiveColor;
  final TextStyle? headingTitleStyle;
  final String? interChange;
  final String? interChangeName;
  final String? routeCodeTwo;
  final String from;

  const OrderTracker(
      {Key? key,
      required this.startRouteTitle,
      required this.endRouteTitle,
      required this.routeCode,
      this.orderTitleAndDateList,
      this.orderTitleAndDateList2,
      this.activeColor,
      this.inActiveColor,
      this.headingTitleStyle,
      this.interChange = "",
      this.interChangeName = "",
      this.routeCodeTwo = "",
        this.from = "No"})
      : super(key: key);

  @override
  State<OrderTracker> createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  bool showList = false;

  @override
  void initState() {
    super.initState();
    if (widget.from != "No") {
      widget.orderTitleAndDateList
        ?..removeAt(0)
        ..removeAt(widget.orderTitleAndDateList!.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 60,
              ),
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                    color: widget.activeColor,
                    borderRadius: BorderRadius.circular(50)),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.startRouteTitle,
                    maxLines: 1,
                    style: satoshiRegularSmallDark,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: 60,
                child: Row(children: [
                  SvgPicture.asset(
                    ImageConstant.iRedBus,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Expanded(
                    child: Text(
                      widget.routeCode,
                      style: satoshiSmall.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: widget.orderTitleAndDateList != null &&
                    widget.orderTitleAndDateList!.isNotEmpty &&
                    showList
                    ? widget.orderTitleAndDateList!.length * 42.sp
                    : 100,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: SizedBox(
                        width: 2,
                        height: widget.orderTitleAndDateList != null &&
                            widget.orderTitleAndDateList!.isNotEmpty &&
                            showList
                            ? widget.orderTitleAndDateList!.length * 42.sp
                            : 100,
                        child: LinearProgressIndicator(
                          backgroundColor:
                          widget.inActiveColor ?? Colors.grey[300],
                          color: AppColors.darkGray,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: showList
                            ? widget.orderTitleAndDateList!.length * 42.sp
                            : 100,
                        width: MediaQuery.of(context).size.width / 2,
                        child: showList
                            ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemExtent: 42.sp,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    top: 5, bottom: 5),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: SvgPicture.asset(
                                          ImageConstant.iStop),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Text(
                                          widget.orderTitleAndDateList?[index]
                                              .stopName ??
                                              "",
                                          maxLines: 1,
                                          style: satoshiRegularSmallDark,

                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            itemCount: widget.orderTitleAndDateList !=
                                null &&
                                widget.orderTitleAndDateList!.isNotEmpty
                                ? widget.orderTitleAndDateList!.length
                                : 0)
                            : GestureDetector(
                          onTap: () {
                            setState(() {
                              showList = true;
                            });
                          },
                          child: Center(
                            child: Text(
                              widget.orderTitleAndDateList?.length != null
                                  ? "${widget.orderTitleAndDateList?.length.toString()}+"
                                  : "0+",
                              style: satoshiSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                width: 0,
              ),
            ],
          ),
          Visibility(
            visible: widget.interChangeName!.isNotEmpty,
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      widget.interChangeName ?? widget.endRouteTitle,
                      style: satoshiRegularSmallDark.copyWith(fontWeight: FontWeight.w900),
                      // maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: widget.interChangeName!.isNotEmpty,
            child: Row(
              children: [
                SizedBox(
                  width: 60,
                  child: Row(children: [
                    SvgPicture.asset(
                      ImageConstant.iRedBus,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Expanded(
                      child: Text(
                        widget.routeCodeTwo ?? "",
                        maxLines: 1,
                        style: satoshiSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: widget.orderTitleAndDateList2 != null &&
                      widget.orderTitleAndDateList2!.isNotEmpty &&
                      showList
                      ? widget.orderTitleAndDateList2!.length * 42.sp
                      : 100,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: SizedBox(
                          width: 2,
                          height: widget.orderTitleAndDateList2 != null &&
                              widget.orderTitleAndDateList2!.isNotEmpty &&
                              showList
                              ? widget.orderTitleAndDateList2!.length * 42.sp
                              : 100,
                          child: LinearProgressIndicator(
                            backgroundColor:
                            widget.inActiveColor ?? Colors.grey[300],
                            color: AppColors.darkGray,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: widget.orderTitleAndDateList2!.length * 42.sp,
                          width: MediaQuery.of(context).size.width / 2,
                          child: showList
                              ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemExtent: 42.sp,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      top: 5, bottom: 5),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: SvgPicture.asset(
                                            ImageConstant.iStop),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(
                                            widget
                                                .orderTitleAndDateList2?[
                                            index]
                                                .stopName ??
                                                "",
                                            maxLines: 1,
                                            style: satoshiRegularSmallDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: widget.orderTitleAndDateList2 !=
                                  null &&
                                  widget.orderTitleAndDateList2!
                                      .isNotEmpty
                                  ? widget.orderTitleAndDateList2!.length
                                  : 0)
                              : GestureDetector(
                            onTap: () {
                              setState(() {
                                showList = true;
                              });
                            },
                            child: Center(
                              child: Text(
                                "${widget.orderTitleAndDateList2?.length.toString()}+",
                                style: satoshiSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  width: 0,
                ),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(
                width: 60,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.endRouteTitle,
                    style: satoshiRegularSmallDark,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
