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

  const RouteDetailScreen(
      {Key? key,
      required this.startRouteName,
      required this.startRouteCode,
      required this.endRouteName,
      required this.endRouteCode,
      required this.routeCode})
      : super(key: key);

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  @override
  void initState() {
    super.initState();
    RouteDetailsRequest routeDetailsRequest = RouteDetailsRequest();

    BlocProvider.of<RouteDetailsBloc>(context).add(
      GetRouteDetailsEvent(request: routeDetailsRequest),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackground,
        body: BlocBuilder<RouteDetailsBloc, RouteDetailsState>(
            builder: (context, state) {
          if (state is RouteDetailsLoadingState) {
            Loader.show(context);
          } else if (state is RouteDetailsSuccessState) {
            Loader.hide();
            return Column(children: [
              const SizedBox(height: 25),
              CustomToolbar(title: "route_detail"),
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
                              "???50.00",
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
              RouteTitleWidget(
                mainAxisAlignment: MainAxisAlignment.start,
                startRouteName: widget.startRouteName ?? "",
                endRouteName: widget.endRouteName ?? "",
              ),
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
                    activeColor: Theme.of(context).primaryColor,
                    inActiveColor: AppColors.darkGray,
                    orderTitleAndDateList: state.routeDetailsRepsonse.data,
                    startRouteTitle: widget.startRouteName ?? "",
                    endRouteTitle: widget.endRouteName ?? "",
                    routeCode: widget.routeCode ?? "",
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
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
                                  RouteHelper.getPassengerDetailsRoute());
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
              ),
            ]);
          } else if (state is RouteDetailsFailedState) {
            Loader.hide();
          }
          return Container();
        }));
  }
}
