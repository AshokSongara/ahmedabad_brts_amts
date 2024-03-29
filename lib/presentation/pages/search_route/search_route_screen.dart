import 'package:ahmedabad_brts_amts/data/requestmodels/add_route_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_route/search_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_route/search_route_state.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/search_route/on_tap_search_route_number_screen.dart';
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
import 'package:hive/hive.dart';

import '../../blocs/search_route/search_route_event.dart';
import '../../widgets/base/custom_snackbar.dart';

class SearchRouteScreen extends StatefulWidget {
  const SearchRouteScreen({Key? key, required this.selectedLanguage, this.from, this.stopType})
      : super(key: key);
  final String? selectedLanguage;
  final String? from;
  final String? stopType;


  @override
  _SearchRouteScreenState createState() => _SearchRouteScreenState();
}

class _SearchRouteScreenState extends State<SearchRouteScreen> {
  BrtsRoutesResponseModel? localBrtsStopResponseModel;
  TextEditingController controller = TextEditingController();
  List<RouteData> brtsStopList = [];
  List<RouteData> localBrtsStopList = [];
  bool _isAmts = false;

  @override
  void initState() {
    super.initState();
    Box brtsBox = getLocalBrtsRoutesData();
    BrtsRoutesResponseModel? brtsData = brtsBox.get("key");
    Box amtsBox = getLocalAmtsRoutesData();
    BrtsRoutesResponseModel? amtsData = amtsBox.get("key");
  //  localBrtsStopResponseModel = Get.arguments[0] as BrtsRoutesResponseModel;
    localBrtsStopResponseModel = widget.stopType == "BRTS" ?brtsBox.get("key"):amtsBox.get("key");
    _isAmts = Get.arguments[1] as bool;
    brtsStopList = localBrtsStopResponseModel?.data ?? [];
    localBrtsStopList = localBrtsStopResponseModel?.data ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: BlocConsumer<SearchRouteBloc, SearchRouteState>(
            listener: (context, state) {
              if(state is SearchRouteAddFavFailureState){
                showCustomSnackBar(state.message,context);
              }else if(state is SearchRouteAddFavState){
                showCustomSnackBar("Favourite Added...!", context,isError: false);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  // const SizedBox(height: Dimensions.dp25),
                  const CustomToolbar(
                    title: "search_route_number",
                    showOption: false,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: Dimensions.dp24,
                        right: Dimensions.dp24,
                        top: Dimensions.dp26),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        localBrtsStopList = brtsStopList.where((element) {
                          return element.routeCode
                                  ?.toLowerCase()
                                  .contains(value.toLowerCase()) ??
                              false;
                        }).toList();
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 18),
                        border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                            style: BorderStyle.solid,
                          ),
                        ),
                        suffix: controller.text.isEmpty
                            ? SvgPicture.asset(ImageConstant.iSearch,
                                height: 20, width: 20)
                            : InkWell(
                                onTap: () {
                                  controller.text = "";
                                },
                                child: SvgPicture.asset(
                                  ImageConstant.iCancel,
                                  height: 20,
                                  width: 20,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                      ),
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp18.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.darkGray),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      margin: const EdgeInsets.all(20),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        itemCount: localBrtsStopList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 24.h,
                                            width: 24.h,
                                            child: SvgPicture.asset(
                                              ImageConstant.iBus,
                                              color:
                                                  Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5.w,
                                          ),
                                          Text(
                                            localBrtsStopList[index].routeCode ??
                                                "",
                                            style: satoshiRegularSmallDark
                                                .copyWith(fontSize: 22.sp),
                                          ),
                                          const Spacer(),

                                         widget.from == "com" ?  Spacer() :
                                         InkWell(
                                            onTap: () {
                                              localBrtsStopList[index].setFav(
                                                  !localBrtsStopList[index]
                                                      .isFav);
                                              localBrtsStopResponseModel=localBrtsStopResponseModel?.copyWith(data: localBrtsStopList);
                                              BlocProvider.of<SearchRouteBloc>(
                                                      context)
                                                  .add(SearchRouteFavoriteEvent(
                                                      request: AddRouteRequest(
                                                          routeID:
                                                              localBrtsStopList[
                                                                      index]
                                                                  .routeCode,
                                                          isAmts: _isAmts,
                                                          model:
                                                              localBrtsStopResponseModel!),
                                                      status:
                                                          localBrtsStopList[index]
                                                              .isFav));
                                            },
                                            child: SvgPicture.asset(
                                              localBrtsStopList[index].isFav
                                                  ? ImageConstant.iFavorite
                                                  : ImageConstant.iUnselected,
                                              color:
                                                  Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.selectedLanguage == "gu"
                                            ? localBrtsStopList[index]
                                                    .routeNameGujarati ??
                                                ""
                                            : localBrtsStopList[index]
                                                    .routeName ??
                                                "",
                                        style: satoshiRegular.copyWith(
                                            fontSize: Dimensions.dp18.sp,
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.darkGray),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    widget.from == "com" ? Get.back(result: localBrtsStopList[index])   :    Get.to(OnTapSearchBusRouteScreen(title: widget.selectedLanguage == "gu"
                                        ? localBrtsStopList[index]
                                        .routeNameGujarati ??
                                        ""
                                        : localBrtsStopList[index]
                                        .routeName ??
                                        "",
                                      routeCode: localBrtsStopList[index].routeCode ??
                                          "",
                                     ));

                                  },
                                ),
                                const Divider(
                                  height: 1,
                                  color: AppColors.lightGray,
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  Box<BrtsRoutesResponseModel> getLocalBrtsRoutesData() {
    return Hive.box<BrtsRoutesResponseModel>(AppConstant.brtsRoutesListBox);
  }

  Box<BrtsRoutesResponseModel> getLocalAmtsRoutesData() {
    return Hive.box<BrtsRoutesResponseModel>(AppConstant.amtsRoutesListBox);
  }
}
