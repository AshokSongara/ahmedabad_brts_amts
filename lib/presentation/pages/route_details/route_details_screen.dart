import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/route_title_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../widgets/base/order_tracker.dart';

class RouteDetailScreen extends StatefulWidget {
  final String? startRouteName;
  final String? startRouteCode;
  final String? endRouteName;
  final String? endRouteCode;
  final String? routeCode;
  final String? startTime;
  final String? interChange;
  final String? fromHome;
  final String? originStart;
  final String? originEnd;
  final String? serviceType;
  final String? interChangeName;
  final String? routeTwo;
  final String? startRouteTwo;
  final String? endRouteTwo;
  final String? endTime;
  final String? startStopSequenceNumber;
  final String? endStopSequenceNumber;
  final String? startID;
  final String? endID;

  const RouteDetailScreen({
    Key? key,
    required this.startRouteName,
    required this.startRouteCode,
    required this.endRouteName,
    required this.endRouteCode,
    required this.routeCode,
    required this.startTime,
    required this.interChange,
    required this.fromHome,
    required this.originStart,
    required this.originEnd,
    required this.serviceType,
    required this.interChangeName,
    required this.routeTwo,
    required this.startRouteTwo,
    required this.endRouteTwo,
    required this.endTime,
    this.startStopSequenceNumber,
    this.endStopSequenceNumber,
    required this.startID,
    required this.endID,
  }) : super(key: key);

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  @override
  void initState() {
    super.initState();
    RouteDetailsRequest routeDetailsRequest = RouteDetailsRequest();
    routeDetailsRequest.startCode = widget.startRouteCode;
    routeDetailsRequest.endCode = widget.endRouteCode;
    routeDetailsRequest.routeCode = widget.routeCode;
    routeDetailsRequest.fromHome = widget.fromHome;
    routeDetailsRequest.originStart = widget.originStart;
    routeDetailsRequest.originEnd = widget.originEnd;
    routeDetailsRequest.serviceType = widget.serviceType;
    routeDetailsRequest.routeTwo = widget.routeTwo;
    routeDetailsRequest.startRouteTwo = widget.startRouteTwo;
    routeDetailsRequest.endRouteTwo = widget.endRouteTwo;
    routeDetailsRequest.startStopSequenceNumber =
        widget.startStopSequenceNumber;
    routeDetailsRequest.endStopSequenceNumber = widget.endStopSequenceNumber;

    BlocProvider.of<RouteDetailsBloc>(context).add(
      GetRouteDetailsEvent(request: routeDetailsRequest),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackground,
        body: SafeArea(
          child: BlocBuilder<RouteDetailsBloc, RouteDetailsState>(
              builder: (context, state) {
            if (state is RouteDetailsLoadingState) {
              Loader.show(context);
            } else if (state is RouteDetailsSuccessState) {
              Loader.hide();
              return Column(children: [
                // const SizedBox(height: 25),
                const CustomToolbar(title: "route_detail"),
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
                              SvgPicture.asset(ImageConstant.iRedTime,
                                  color: Theme.of(context).primaryColor),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.startTime ?? "",
                                style: screenTitle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
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
                                  child: SvgPicture.asset(ImageConstant.iRoute,
                                      color: Theme.of(context).primaryColor)),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                widget.interChange ?? "0",
                                style: screenTitle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
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
                                  child: SvgPicture.asset(
                                    ImageConstant.iTicket,
                                    color: Theme.of(context).primaryColor,
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "₹${getFare(state.fareResponse.data?.adult ?? 0)}",
                                style: screenTitle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                RouteTitleWidget(
                  mainAxisAlignment: MainAxisAlignment.start,
                  startRouteName: widget.startRouteName ?? "",
                  endRouteName: widget.endRouteName ?? "",
                  from: false,
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: const EdgeInsets.all(20),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: OrderTracker(
                        activeColor: Theme.of(context).primaryColor,
                        inActiveColor: AppColors.darkGray,
                        orderTitleAndDateList: widget.fromHome == "No"
                            ? state.routeDetailsResponse.data
                            : state.routeStopListResponse.data,
                        orderTitleAndDateList2: widget.fromHome == "No"
                            ? state.routeDetailsResponse1.data
                            : state.routeStopListResponse.data,
                        startRouteTitle: widget.startRouteName ?? "",
                        endRouteTitle: widget.endRouteName ?? "",
                        routeCode: widget.routeCode ?? "",
                        interChangeName: widget.interChangeName,
                        interChange: widget.interChange,
                        routeCodeTwo: widget.routeTwo,
                        from: widget.fromHome ?? "No",
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 40),
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
                                SvgPicture.asset(ImageConstant.iRedTime,
                                    color: Theme.of(context).primaryColor),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  state.etaResponse.data!.isNotEmpty
                                      ? toMinutes(
                                          "${state.etaResponse.data![0].eta}"
                                          ""
                                          "")
                                      : "",
                                  style: screenTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: CustomButton(
                            color: Theme.of(context).primaryColor,
                            text: "Book Tickets",
                            width: MediaQuery.of(context).size.width / 2,
                            onPressed: () {
                              Get.toNamed(
                                  RouteHelper.getPassengerDetailsRoute(
                                      widget.startID ?? "",
                                      widget.endID ?? "",
                                      widget.routeCode ?? ""),
                                  arguments: [
                                    widget.startRouteName,
                                    widget.endRouteName,
                                    widget.startTime,
                                    widget.endTime
                                  ]);
                            },
                            style: poppinsMedium.copyWith(
                                color: Colors.white, fontSize: 15.sp),
                            height: 53,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]);
            } else if (state is RouteDetailsFailedState) {
              Loader.hide();
            }
            return Container();
          }),
        ));
  }
}
