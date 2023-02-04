library order_tracker;

import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
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
      this.routeCodeTwo = ""})
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
              Text(
                widget.startRouteTitle,
                style: satoshiRegularSmallDark,
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
                        widget.orderTitleAndDateList!.isNotEmpty && showList
                    ? widget.orderTitleAndDateList!.length * 30
                    : 100,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: SizedBox(
                        width: 2,
                        height: widget.orderTitleAndDateList != null &&
                                widget.orderTitleAndDateList!.isNotEmpty && showList
                            ? widget.orderTitleAndDateList!.length * 30
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
                            ? widget.orderTitleAndDateList!.length * 30
                            : 100,
                        width: MediaQuery.of(context).size.width / 2,
                        child: showList
                            ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
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
                                          child: Text(
                                            widget.orderTitleAndDateList?[index]
                                                    .stopName ??
                                                "",
                                            style: satoshiRegularSmallDark,
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
                                    "${widget.orderTitleAndDateList?.length.toString()}+",
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
                Text(
                  widget.interChangeName ?? widget.endRouteTitle,
                  style: satoshiRegularSmallDark,
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
                        style: satoshiSmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ]),
                ),
                SizedBox(
                  height: widget.orderTitleAndDateList2 != null &&
                      widget.orderTitleAndDateList2!.isNotEmpty && showList
                      ? widget.orderTitleAndDateList2!.length * 30
                      : 100,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: SizedBox(
                          width: 2,
                          height: widget.orderTitleAndDateList2 != null &&
                                  widget.orderTitleAndDateList2!.isNotEmpty && showList
                              ? widget.orderTitleAndDateList2!.length * 40
                              : 100,
                          child: LinearProgressIndicator(
                            backgroundColor:
                                widget.inActiveColor ?? Colors.grey[300],
                            color: AppColors.darkGray,
                          ),
                        ),
                      ),
                      SizedBox(
                          height: widget.orderTitleAndDateList2!.length * 40,
                          width: MediaQuery.of(context).size.width / 2,
                          child: showList
                              ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
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
                                            child: Text(
                                              widget
                                                      .orderTitleAndDateList2?[
                                                          index]
                                                      .stopName ??
                                                  "",
                                              style: satoshiRegularSmallDark,
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
                                          color:
                                              Theme.of(context).primaryColor),
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
              Text(
                widget.endRouteTitle,
                style: satoshiRegularSmallDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
