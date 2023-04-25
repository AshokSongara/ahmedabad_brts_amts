import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list_data/favourite_list_data_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list_data/favourite_list_data_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list_data/favourite_route_data_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/responsemodels/favourite_routes_response_list.dart';

class MyRoutesScreenTwo extends StatefulWidget {
  const MyRoutesScreenTwo({Key? key}) : super(key: key);

  @override
  _MyRoutesScreenTwoState createState() => _MyRoutesScreenTwoState();
}

class _MyRoutesScreenTwoState extends State<MyRoutesScreenTwo> {
  String token = "";

  @override
  void initState() {
    super.initState();
    getMemberID();
  }

  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstant.accessToken) ?? "";
    if (token.isNotEmpty) {
      getData();
    }
  }

  getData() {
    BlocProvider.of<FavouriteRouteListDataBloc>(context)
        .add(const GetFavouriteRouteListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child:
            BlocConsumer<FavouriteRouteListDataBloc, FavouriteRouteListState>(
          listener: (context, state) {
            if (state is FavouriteRouteLoadingState) {
              Loader.show(context);
            } else {
              Loader.hide();
            }
          },
          builder: (context, state) {
            if (state is FavouriteRouteSuccessState) {
              return Column(
                children: [
                  SizedBox(height: 10,),
                  Expanded(
                    child: state.favouriteRouteResponse.data!.isNotEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount:
                                state.favouriteRouteResponse.data?.length,
                            itemBuilder: (context, index) {
                              return getMyRoutesWidget(
                                  state.favouriteRouteResponse.data![index]);
                            })
                        : Center(
                            child: Text(
                            "No Data Found",
                            style: screenTitle,
                          )),
                  ),
                ],
              );
            } else if (state is FavouriteRouteFailedState) {
              Loader.hide();
              showCustomSnackBar("Something Went Wrong Try again..!", context,
                  isError: false);
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  Widget getMyRoutesWidget(Data model) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getPolyLinePageRoute(model.routeId ?? ""));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 19),
        margin: const EdgeInsets.only(
            left: Dimensions.dp24,
            right: Dimensions.dp24,
            bottom: Dimensions.dp20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColors.gray6E8EE7,
              blurRadius: 5.0,
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(Dimensions.dp10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 25,
                          width: 2,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(50)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    model.routeLongName!,
                    maxLines: 2,
                    style: satoshiRegularSmallDark,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
