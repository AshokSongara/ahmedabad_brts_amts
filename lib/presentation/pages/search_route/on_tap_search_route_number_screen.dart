import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/on_tap_search_bus_route/on_tap_search_bus_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/on_tap_search_bus_route/on_tap_search_bus_route_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/on_tap_search_bus_route/on_tap_search_bus_route_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/responsemodels/brts_stop_respons_model.dart' as brtsModel;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class OnTapSearchBusRouteScreen extends StatefulWidget {
  final String title;
  final String routeCode;
  const OnTapSearchBusRouteScreen({Key? key, required this.title, required this.routeCode}) : super(key: key);

  @override
  State<OnTapSearchBusRouteScreen> createState() => _OnTapSearchRouteNumberScreenState();
}

class _OnTapSearchRouteNumberScreenState extends State<OnTapSearchBusRouteScreen> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 1, vsync: this);

    var request = RouteDetailsRequest(routeCode: widget.routeCode);

    BlocProvider.of<OnTapSearchBusRouteDetailsBloc>(context).add(
      GetOnTapSearchBusRouteDetailsEvent(request: request),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.appBackground,
        body: BlocConsumer<OnTapSearchBusRouteDetailsBloc, OnTapSearchBusRouteDetailsState>(
            listener: (context,state){
              if (state is OnTapSearchBusRouteSuccessState) {
                Loader.hide();
                print("#####${state.value}");
                if (state.value == true) {
                  showCustomSnackBar("Favourite Route Added", context,
                      isError: false);
                }else if(state.error == true){
                  showCustomSnackBar("Route Already Added", context,
                      isError: true);
                }
              }
            },
            builder: (context, state) {
              if (state is OnTapSearchBusRouteDetailsLoadingState) {
                Loader.show(context);
              } else if (state is OnTapSearchBusRouteSuccessState) {
                Loader.hide();
                return SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                        const EdgeInsets.only(left: Dimensions.dp15, right: Dimensions.dp20),
                        padding:
                        const EdgeInsets.only(top: Dimensions.dp10, bottom: Dimensions.dp10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(child: SvgPicture.asset(ImageConstant.iLeftArrow),
                              onTap: (){Get.back();},
                            ),
                            Expanded(
                              child: Text(widget.title,
                                style: screenTitle,
                                maxLines: 2,
                              ),
                            ),
                            SizedBox(width: 0,)


                          ],
                        ),
                      ),
                      Container(
                        color: Theme.of(context).primaryColor,
                        height: Dimensions.dp60.h,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            top: Dimensions.dp10,
                            bottom: Dimensions.dp10,
                            left: Dimensions.dp40,
                            right: Dimensions.dp40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.routeCode,
                                  style: satoshiRegularSmall,
                                ),
                                // GestureDetector(
                                //   onTap: (){
                                //     var request = AddRouteRequest(
                                //         routeID: widget.routeCode,
                                //         isAmts: false,
                                //         model: BrtsRoutesResponseModel()
                                //     );
                                //
                                //     RouteStopListResponse response = RouteStopListResponse();
                                //     response = state.routeStopListResponse;
                                //
                                //     BlocProvider.of<OnTapFavDetailsBloc>(context).add(
                                //       AddFavouriteRouteEvent(
                                //           request: request, routeStopListResponse: response),
                                //     );
                                //   },
                                //   child: SvgPicture.asset(ImageConstant.iEmptyFavorite,
                                //       color: Colors.white),
                                // )
                              ],
                            ),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(RouteHelper.getPolyLinePageRoute(widget.routeCode ?? ""));
                              },
                              child: ImageIcon(AssetImage(ImageConstant.iRightArrow),
                                  color: Colors.white),
                            ),

                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: TabBar(
                          labelColor: Theme.of(context).primaryColor,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorWeight: 4.0,
                          unselectedLabelColor: AppColors.lightGray,
                          labelStyle: satoshiRegularSmallDark.copyWith(fontSize: 18),
                          controller: _controller,
                          tabs: [
                            Tab(
                              text:
                              '${state.routeStopListResponse.data?.length ?? "0"} Stops',
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _controller,
                          children: [
                            Card(
                              margin:  const EdgeInsets.all(Dimensions.dp20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white,
                              child: ListView.builder(
                                itemCount:
                                state.routeStopListResponse.data?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      print("onTap Pressed");
                                       Get.close(2);
                                      BlocProvider.of<HomeScreenBloc>(context).add(
                                          SourceSelectionFromSearchBusRouteScreenEvent(brtsModel.Data(
                                              stopName: state.routeStopListResponse
                                                  .data?[index].stopName,
                                              stationCode: state.routeStopListResponse
                                                  .data?[index].stationCode)));

                                    },
                                    child: TimelineTile(
                                      indicatorStyle:  IndicatorStyle(
                                          color: Theme.of(context).primaryColor, width: 10),
                                      beforeLineStyle: const LineStyle(
                                          thickness: 2, color: AppColors.darkGray),
                                      axis: TimelineAxis.vertical,
                                      alignment: TimelineAlign.manual,
                                      lineXY: 0.10,
                                      endChild: Container(
                                        margin: const EdgeInsets.all(20),
                                        constraints: const BoxConstraints(
                                          minWidth: 120,
                                        ),
                                        color: Colors.white,
                                        child: Text(
                                          state.routeStopListResponse.data?[index]
                                              .stopName ??
                                              "",
                                          style: satoshiRegularSmall.copyWith(
                                              color: AppColors.darkGray),
                                        ),
                                      ),
                                      startChild: Container(
                                        color: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.all(20),
                      //   child: CustomButton(
                      //     text: "Buy Ticket",
                      //     width: MediaQuery.of(context).size.width,
                      //     onPressed: () {},
                      //     style: satoshiRegular.copyWith(
                      //         fontSize: 20.sp,
                      //         fontWeight: FontWeight.w700,
                      //         color: Colors.white),
                      //     height: Dimensions.dp53,
                      //   ),
                      // ),
                    ],
                  ),
                );
              }else if (state is AddFavouriteRouteLoadingState) {
                Loader.show(context);
              } else if (state is OnTapSearchBusRouteSuccessState) {
                Loader.hide();
                print("#####${state.value}");
                if (state.value == true) {
                  showCustomSnackBar("Favourite Route Added", context,
                      isError: false);
                }
              } else if (state is AddFavouriteRouteFailedState) {
                showCustomSnackBar("Favourite Route Not Added", context,
                    isError: true);
              } else {
                Loader.hide();
              }
              return Container();
            }));
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }
}

