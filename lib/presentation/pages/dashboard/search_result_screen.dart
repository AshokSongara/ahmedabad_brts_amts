import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/search_route_request.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_state.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/route_title_widget.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/search_result_item.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SearchResultScreen extends StatefulWidget {
  final String? startRoute;
  final String? endRoute;
  final String? startRouteName;
  final String? endRouteName;

  const SearchResultScreen(
      {Key? key,
      required this.startRoute,
      required this.endRoute,
      required this.startRouteName,
      required this.endRouteName})
      : super(key: key);

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  void initState() {
    super.initState();
    var request = SearchRouteRequest(
        startCode: widget.startRoute ?? "", endCode: widget.endRoute ?? "");

    BlocProvider.of<SearchResultRouteBloc>(context).add(
      GetSearchResultRouteEvent(searchRouteRequest: request),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BlocBuilder<SearchResultRouteBloc, SearchResultRouteState>(
        builder: (context, state) {
          if (state is SearchResultRouteLoadingState) {
            Loader.show(context);
          } else if (state is SearchResultRouteSuccessState) {
            Loader.hide();
            return Column(children: [
              const SizedBox(height: 25),
              CustomToolbar(title: "search_result"),
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
                                Get.toNamed(
                                    RouteHelper.getRouteDetailsRoute("", "","","",""));
                              },
                              child: SearchResultItem(
                                routeResult:
                                    state.searchRouteResponse.data![index],
                              ));
                        })
                    : Center(
                        child: Text(
                          "No Route Available",
                          style: satoshiRegularSmall.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
              ),
            ]);
          } else {
            Loader.hide();
          }
          return Container();
        },
      ),
    );
  }
}
