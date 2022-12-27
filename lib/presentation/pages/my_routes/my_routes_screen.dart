import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list/favourite_list_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list/favourite_list_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list/favourite_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_toolbar.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/responsemodels/favourite_route_response.dart';

class MyRoutesScreen extends StatefulWidget {
  const MyRoutesScreen({Key? key}) : super(key: key);

  @override
  _MyRoutesScreenState createState() => _MyRoutesScreenState();
}

class _MyRoutesScreenState extends State<MyRoutesScreen> {
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
    BlocProvider.of<FavouriteRouteListBloc>(context)
        .add(GetFavouriteRouteListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BlocConsumer<FavouriteRouteListBloc, FavouriteRouteListState>(
        listener: (context, state) {
          if (state is FavouriteDeleteRouteSuccessState) {
            Loader.hide();
            getData();
          }
          else if (state is FavouriteRouteLoadingState) {
            Loader.show(context);
          } else {
            Loader.hide();
          }
        },
        builder: (context, state) {
          if (state is FavouriteRouteSuccessState) {
            return Column(
              children: [
                const SizedBox(height: Dimensions.dp25),
                CustomToolbar(
                  title: "myroutes",
                  showOption: false,
                ),
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.favouriteRouteResponse.data?.length,
                      itemBuilder: (context, index) {
                        return getMyRoutesWidget(
                            state.favouriteRouteResponse.data![index]);
                      }),
                ),
              ],
            );
          } else if (state is FavouriteRouteFailedState) {
            Loader.hide();
            showCustomSnackBar("Something Went Wrong Try again..!", context,
                isError: false);
          }
          return Center(
            child: Container(
              height: 53,
              margin: EdgeInsets.all(50),
              child: CustomButton(
                color: Theme.of(context).primaryColor,
                text: AppLocalizations.of(context)?.translate("go_to_login") ?? "",
                width: MediaQuery.of(context).size.width,
                onPressed: () {
                  Get.offNamed(RouteHelper.login);
                },
                style: poppinsMedium.copyWith(
                    color: Colors.white, fontSize: 15.sp),
                height: 53,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getMyRoutesWidget(Data model) {
    return Container(
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
                  Text(
                    model.routeName ?? "",
                    style: satoshiRegular.copyWith(
                        fontSize: Dimensions.dp16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.darkGray),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    BlocProvider.of<FavouriteRouteListBloc>(context).add(
                        DeleteFavouriteRouteEvent(
                            routeId: model.id.toString()));
                  },
                  child: SvgPicture.asset(
                    ImageConstant.iFavorite,
                    color: Theme.of(context).primaryColor,
                  )),
            ],
          ),
          Text(DateTime.now().toString(),
              style: satoshiRegular.copyWith(
                  fontSize: Dimensions.dp10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.darkGray)),
        ],
      ),
    );
  }
}
