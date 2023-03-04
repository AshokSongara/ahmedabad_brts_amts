import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/add_favourite_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/search_route_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/route_title_widget.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/search_result_item.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SearchResultScreen extends StatefulWidget {
  final String? startRoute;
  final String? endRoute;
  final String? startRouteName;
  final String? endRouteName;
  final String? serviceType;

  const SearchResultScreen(
      {Key? key,
      required this.startRoute,
      required this.endRoute,
      required this.startRouteName,
      required this.endRouteName,
      required this.serviceType})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    var request = SearchRouteRequest(
        startCode: widget.startRoute ?? "",
        endCode: widget.endRoute ?? "",
        serviceType: widget.serviceType ?? "BRTS");

    BlocProvider.of<SearchResultRouteBloc>(context).add(
      GetSearchResultRouteEvent(searchRouteRequest: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: BlocConsumer<SearchResultRouteBloc, SearchResultRouteState>(
          listener: (context, state) {
            if (state is SearchResultRouteSuccessState) {
              Loader.hide();
              print("#####${state.value}");
              if (state.value == true) {
                showCustomSnackBar("Favourite Route Added", context,
                    isError: false);
              }
            }
          },
          builder: (context, state) {
            if (state is SearchResultRouteLoadingState) {
              Loader.show(context);
            } else if (state is SearchResultRouteSuccessState) {
              Loader.hide();
              return Column(children: [
                // const SizedBox(height: 25),
                Container(
                  margin:  const EdgeInsets.only(
                      left: Dimensions.dp15, right: Dimensions.dp20),
                  padding:  const EdgeInsets.only(
                      top: Dimensions.dp10, bottom: Dimensions.dp10),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(ImageConstant.iLeftArrow)),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Search Result",
                            style: screenTitle,
                          ),
                        ),
                      ),
                      GestureDetector(
                        child: SvgPicture.asset(ImageConstant.iEmptyFavorite),
                        onTap: () {
                          var request = AddFavouriteRequest(
                            startStop: widget.startRoute ?? "",
                            endStop: widget.endRoute ?? "",
                          );

                          SearchRouteResponse response = SearchRouteResponse();
                          response = state.searchRouteResponse;

                          BlocProvider.of<SearchResultRouteBloc>(context).add(
                            AddFavouriteRouteEvent(
                                addFavouriteRequest: request,
                                searchRouteResponse: response),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                RouteTitleWidget(
                  mainAxisAlignment: MainAxisAlignment.center,
                  startRouteName: widget.startRouteName ?? "",
                  endRouteName: widget.endRouteName ?? "",
                ),
                Expanded(
                  child: state.searchRouteResponse.data!.isNotEmpty
                      ? ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: state.searchRouteResponse.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getRouteDetailsRoute(
                                      state.searchRouteResponse.data![index]
                                              .routeDetails![0].startStopName ??
                                          "",
                                      state.searchRouteResponse.data![index].interChanges!.isEmpty
                                          ? state
                                              .searchRouteResponse
                                              .data![index]
                                              .routeDetails![0]
                                              .startStopCode
                                              .toString()
                                          : widget.startRoute ?? "",
                                      state.searchRouteResponse.data![index].interChanges!.isEmpty
                                          ? state.searchRouteResponse.data![index]
                                                  .routeDetails![0].endStopName ??
                                              ""
                                          : state.searchRouteResponse.data![index].routeDetails![state.searchRouteResponse.data![index].routeDetails!.length - 1].endStopName ??
                                              "",
                                      state.searchRouteResponse.data![index].interChanges!.isEmpty
                                          ? state
                                              .searchRouteResponse
                                              .data![index]
                                              .routeDetails![0]
                                              .endStopCode
                                              .toString()
                                          : widget.endRoute ?? "",
                                      state.searchRouteResponse.data![index].routeDetails![0].routeCode
                                          .toString(),
                                      state
                                              .searchRouteResponse
                                              .data![index]
                                              .routeDetails![0]
                                              .startArrivalTime ??
                                          "0",
                                      state.searchRouteResponse.data![index].interChanges?.length.toString() ?? "0",
                                      "No",
                                      state.searchRouteResponse.data![index].routeDetails![0].startStopCode.toString(),
                                      state.searchRouteResponse.data![index].routeDetails![0].endStopCode.toString(),
                                      widget.serviceType ?? "BRTS",
                                      state.searchRouteResponse.data![index].interChanges!.isNotEmpty ? state.searchRouteResponse.data![index].interChanges![0] : "",
                                    state.searchRouteResponse.data![index].routeDetails!.length > 1
                                          ? state.searchRouteResponse.data![index].routeDetails![1].routeCode ?? "": "",
                                    state.searchRouteResponse.data![index].routeDetails!.length > 1
                                        ? state.searchRouteResponse.data![index].routeDetails![1].startStopSequenceNumber.toString() ?? "": "",
                                    state.searchRouteResponse.data![index].routeDetails!.length > 1
                                        ? state.searchRouteResponse.data![index].routeDetails![1].endStopSequenceNumber.toString() ?? "": "",
                                    state.searchRouteResponse.data![index]
                                        .endTime
                                        .toString(),));
                                },
                                child: SearchResultItem(
                                  routeResult:
                                      state.searchRouteResponse.data![index],
                                  serviceType: widget.serviceType,
                                ));
                          })
                      : Center(
                          child: Text(
                            "No Route Available",
                            style: satoshiRegularSmall.copyWith(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                ),
              ]);
            } else if (state is AddFavouriteRouteLoadingState) {
              Loader.show(context);
            }else {
              Loader.hide();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
