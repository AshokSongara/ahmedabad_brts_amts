import 'dart:io';

import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/core/theme/theme_service.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/routes_request_model.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/stop_request_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/language/language_cubit.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/complaint/complaint_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/complaint_history/complaint_history_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/search_result_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/maps/nearby_maps_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/notification/notification_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/tnc/terms_and_conditions_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/home_dialog.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/source_destination_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/app_util.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/responseModels/quick_link_internal_model.dart';
import '../../../data/responsemodels/brts_stop_respons_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isAmts = false;
  List<QuickLinkInternalModel> quickLinkList = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double fontSize = Dimensions.dp16.sp;
  BrtsRoutesResponseModel? brtsRoutesResponseModel;
  BrtsStopResponseModel? operationBrtsStopResponseModel;
  RouteData? routeData;
  DataHive? newFromSelectedStation, oldFromSelectedStation;
  DataHive? newToSelectedStation, oldToSelectedStation;
  String? selectedLanguage;
  String userName = "Guest User";
  static const platform = MethodChannel('nativeChannel');
  bool isLoading = false;
  String? startCode;
  String? endCode;
  DateTime? ctime;



  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () {
      ThemeService().switchTheme(isAmts);
    });
    context.read<LanguageCubit>().getCurrentSelectedLanguage().then((value) {
      selectedLanguage = value;
    });

    BlocProvider.of<HomeScreenBloc>(context).add(
        GetAvailableStopsEvent(StopRequestModel(stopType: isAmts ? 2 : 1)));
    BlocProvider.of<HomeScreenBloc>(context).add(
        GetAvailableRoutesEvent(RoutesRequestModel(stopType: isAmts ? 2 : 1)));
    Loader.show(context);
    setQuickLinks();
  }

  Future<SearchRouteResponse> fetchData() async {
    final url = "https://www.transportapp.co.in/Route/BRTS/plan/start/${newFromSelectedStation?.stationCode
        .toString() ??
        ""}/end/${newToSelectedStation?.stationCode
        .toString() ??
        ""}";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SearchRouteResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  void openDialogBox() async {
    setState(() {
      isLoading = true;
    });

    final searchResponse = await fetchData();
    if(searchResponse.data!.length == 0){

      setState(() {
        startCode = newFromSelectedStation?.stationCode
            .toString();
        endCode = newToSelectedStation?.stationCode
            .toString();
      });

    }
    else {
      startCode = searchResponse.data![0].routeDetails![0].startStopCode;
      endCode =
      searchResponse.data![0].interChanges!.isEmpty ? searchResponse.data![0]
          .routeDetails![0].endStopCode ?? "" : searchResponse.data![0]
          .routeDetails![searchResponse.data![0].routeDetails!.length - 1]
          .endStopCode
          .toString();
    }

    Future<FareResponse> fetchData2() async {
      final url = "https://www.transportapp.co.in/fare/BRTS/startStop/${startCode}/endStop/${endCode}";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return FareResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load data');
      }
    }

    final fareResponse = await fetchData2();

    setState(() {
      isLoading = false;
      showDialog(
        context: context,
        builder: (context) => MyDialog(
          data: fareResponse.data,
          data2: searchResponse.data!.length != 0 ? searchResponse.data![0] : null,
          startName: newFromSelectedStation?.stopName.toString(),
          endName: newToSelectedStation?.stopName.toString(),
          isLoading: isLoading,
          onCancel: () {
            Navigator.of(context).pop();
          },
          onProceed: () {
            AppConstant.nameData.isEmpty ?
            Get.toNamed(RouteHelper.getSplashRoute())  : Get.toNamed(
                RouteHelper.getPassengerDetailsRoute(
                  startCode ?? "",
                  endCode ?? "",
                   "",
                   "BRTS",
                    getFare(fareResponse.data?.adult ?? 0)

                ),
                arguments: [
                  searchResponse.data!.length != 0 ? searchResponse.data![0].routeDetails![0].startStopName : newFromSelectedStation?.stopName.toString(),
                  searchResponse.data!.length != 0 ? searchResponse.data![0].interChanges!.isEmpty ? searchResponse.data![0].routeDetails![0].endStopName ?? "" :  searchResponse.data![0].routeDetails![searchResponse.data![0].routeDetails!.length - 1].endStopName ?? ""
                  "" : newToSelectedStation?.stopName.toString(),
                  "",
                  ""
                ]);
           },
        ),
      );
    });
  }

  setQuickLinks(){
    quickLinkList.clear();
    quickLinkList.add(QuickLinkInternalModel("mticket", ImageConstant.iTicket));
    // quickLinkList
    //     .add(QuickLinkInternalModel("smartrecharge", ImageConstant.iMobileRed));
    quickLinkList.add(QuickLinkInternalModel("near_me", ImageConstant.iRoute));
    quickLinkList.add(QuickLinkInternalModel("myroutes", ImageConstant.iRate));
    if (!isAmts) {
      quickLinkList
          .add(QuickLinkInternalModel("transitmap", ImageConstant.iMap));
    }
    else{
      quickLinkList
          .add(QuickLinkInternalModel("complaint", ImageConstant.iComplaint));
    }
    quickLinkList.add(QuickLinkInternalModel("feedback", ImageConstant.iChat));
  }
  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppConstant.IsLoggedIn = prefs.getString(AppConstant.accessToken) ?? "";
    AppConstant.nameData = prefs.getString(AppConstant.name) ?? "";
    AppConstant.emailData = prefs.getString(AppConstant.email) ?? "";
    AppConstant.lastNameData = prefs.getString(AppConstant.lastName) ?? "";
  }


  @override
  Widget build(BuildContext context) {
    print("#####Home build ${AppConstant.nameData}");
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBackground,
        endDrawer: Drawer(
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(
                top: Dimensions.dp24,
                left: Dimensions.dp43,
                right: Dimensions.dp20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  InkWell(
                      onTap: () {
                        print("back clicked");
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(ImageConstant.iClose)),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.dp35),
                    child: GestureDetector(

                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: Dimensions.dp22,
                            backgroundColor: AppColors.profileBackgroundGrey,
                            child: ClipOval(
                              child: Image.asset(
                                ImageConstant.iAvatar,
                                height: Dimensions.dp41,
                                width: Dimensions.dp38,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: Dimensions.dp14,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppConstant.nameData.isEmpty ? "Guest User" : AppConstant.nameData,
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp19,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: (){
                        AppConstant.IsLoggedIn.isNotEmpty ? Get.toNamed(RouteHelper.profile) :  Get.toNamed(RouteHelper.splash);

                      },
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.dp28,
                  ),
                  const Divider(
                    thickness: Dimensions.dp2,
                    color: AppColors.gray6E8EE7,
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iTransactionHistory,
                      color: Colors.white,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                              ?.translate("transaction_history") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getBookingRoute("home"));
                    },
                  ),
                  // ListTile(
                  //   leading: SvgPicture.asset(
                  //     ImageConstant.iRoute,
                  //     color: Colors.white,
                  //     height: Dimensions.dp20,
                  //     width: Dimensions.dp20,
                  //   ),
                  //   title: Text(
                  //     AppLocalizations.of(context)
                  //             ?.translate("smart_card_recharge") ??
                  //         "",
                  //     style: satoshiRegular.copyWith(
                  //         fontSize: 14.sp,
                  //         fontWeight: FontWeight.w500,
                  //         color: Colors.white),
                  //   ),
                  //   onTap: () {
                  //     Get.toNamed(RouteHelper.getCardDetailsRoute());
                  //   },
                  // ),
                  ListTile(
                    leading:Container(
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                      child: const Icon(Icons.near_me, color: Colors.white,),
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("near_me") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                     // Get.toNamed(RouteHelper.getNearByMapScreenRoute(isAmts ? "2" : "1"));
                     Get.to( NearByMapsScreen(from: "drawer", stopType: isAmts ? "2" : "1",));
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iRate,
                      color: Colors.white,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("myroutes") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {

                      Get.toNamed(RouteHelper.getMyRoutesTabScreenRoute(!isAmts ? "BRTS" : "AMTS", "drawer"));
                      setState(() {
                        routeData = null;

                      });
                    },
                  ),
                  if (!isAmts)
                    ListTile(
                      leading: SvgPicture.asset(
                        ImageConstant.iMap,
                        color: Colors.white,
                        height: Dimensions.dp20,
                        width: Dimensions.dp20,
                      ),
                      title: Text(
                        AppLocalizations.of(context)?.translate("transitmap") ??
                            "",
                        style: satoshiRegular.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      onTap: () {
                        Get.toNamed(RouteHelper.getTransitMapScreenRoute());
                      },
                    ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iChat,
                      color: Colors.white,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("feedback") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getFeedbackRoute());
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.iComplaint,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                      color: Colors.white,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("complaint") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(ComplaintScreen(stopType: isAmts ? "AMTS" : "BRTS",));
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.iComplaintHistory,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                      color: Colors.white,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("complaint_history") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(ComplaintHistoryScreen());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iSpeaker,
                      color: Colors.white,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                              ?.translate("invite_friends") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      if (Platform.isAndroid) {
                        Share.share("https://play.google.com/store/apps/details?id=com.ahmedabad_brts_amts.ahmedabad_brts_amts");
                      } else if (Platform.isIOS) {
                        Share.share("Appstore Link");
                      }
                    },
                  ),
                  ListTile(
                    leading: Image.asset(
                      ImageConstant.iTnc,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                      color: Colors.white,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("tnc") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.to(TermsAndConditionScreen());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iCall,
                      color: Colors.white,
                      height: Dimensions.dp20,
                      width: Dimensions.dp20,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("contact_us") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getContactUsRoute());
                    },
                  ),
                  ListTile(
                    leading: Container(
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                      child: const Icon(Icons.language_sharp, color: Colors.white,),
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                              ?.translate("change_langauge") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      selectedLanguage = await Get.toNamed(
                          RouteHelper.getChangeLangaugeScreenRoute()) as String;
                    },
                  ),
                  Visibility(
                    visible: AppConstant.nameData.isNotEmpty,
                    child: ListTile(
                      leading: SvgPicture.asset(
                        ImageConstant.iSignOut,
                        color: Colors.white,
                        height: Dimensions.dp20,
                        width: Dimensions.dp20,
                      ),
                      title: Text(
                        AppLocalizations.of(context)?.translate("signout") ?? "",
                        style: satoshiRegular.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      onTap: () async {
                        SharedPreferences preferences =
                            await SharedPreferences.getInstance();
                        await preferences.clear();
                        AppConstant.nameData = "";
                        Get.offNamed(RouteHelper.getSplashRoute());
                      },
                    ),
                  ),
                  Visibility(
                    visible: AppConstant.nameData.isEmpty,
                    child: ListTile(
                      leading: SvgPicture.asset(
                        ImageConstant.iSignOut,
                        color: Colors.white,
                        height: Dimensions.dp28,
                        width: Dimensions.dp28,
                      ),
                      title: Text(
                        "Login",
                        style: satoshiRegular.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      onTap: () async {
                        Get.toNamed(RouteHelper.getSplashRoute());
                      },
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.dp50,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: BlocConsumer<HomeScreenBloc, HomeState>(listener: (context, state) {
          if (state is StopsResponseState) {
              operationBrtsStopResponseModel = state.model;
          }
          if (state is SourceSelectionFromMapScreenState) {
              newFromSelectedStation = state.data;
              if (newToSelectedStation != null &&
                  newToSelectedStation?.stopName ==
                      newFromSelectedStation?.stopName) {
                newToSelectedStation = null;
              }
              // operationBrtsStopResponseModel?.data
              //     ?.removeWhere((element) => element.stopName == state.data.stopName);
              // operationBrtsStopResponseModel?.data?.add(newFromSelectedStation!);
          }
          if (state is SourceSelectionFromFavScreenState) {
              newFromSelectedStation = state.data;
              if (newToSelectedStation != null &&
                  newToSelectedStation?.stopName ==
                      newFromSelectedStation?.stopName) {
                newToSelectedStation = null;
              }
              // operationBrtsStopResponseModel?.data
              //     ?.removeWhere((element) => element.stopName == state.data.stopName);
              // operationBrtsStopResponseModel?.data?.add(newFromSelectedStation!);
          }
          if (state is SourceSelectionFromSearchBusRouteScreenState) {
              newFromSelectedStation = state.data;
              if (newToSelectedStation != null &&
                  newToSelectedStation?.stopName ==
                      newFromSelectedStation?.stopName) {
                newToSelectedStation = null;
              }
              // operationBrtsStopResponseModel?.data
              //     ?.removeWhere((element) => element.stopName == state.data.stopName);
              // operationBrtsStopResponseModel?.data?.add(newFromSelectedStation!);
          }

          if (state is RoutesResponseState) {
              brtsRoutesResponseModel = state.model;
              Loader.hide();
          }
           if(state is TicketBookState){
              setState(() {
                // newFromSelectedStation = null;
                // operationBrtsStopResponseModel?.data?.add(newFromSelectedStation!);
                // operationBrtsStopResponseModel?.data?.add(newToSelectedStation!);
              });
              print(operationBrtsStopResponseModel?.data);

              print("ticket book state called");

          }
           if(state is ReturnHomeState){
              setState(() {
                // operationBrtsStopResponseModel?.data?.add(newFromSelectedStation!);
                // operationBrtsStopResponseModel?.data?.add(newToSelectedStation!);
                // newFromSelectedStation = null;
                // newToSelectedStation = null;

              });
              print("return home");

          }
          if (state is HomeLoadingState) {
          } else {
              FocusScope.of(context).unfocus();
          }
        }, builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              if (_scaffoldKey.currentState?.isEndDrawerOpen == true) {
                // If the drawer is open, close it
                _scaffoldKey.currentState!.openEndDrawer();
                return true; // Prevent the default back button behavior
              }
              MoveToBackground.moveTaskToBack();
              print("back back h");
              // DateTime now = DateTime.now();
              // if (ctime == null ||
              //     now.difference(ctime!) > const Duration(seconds: 2)) {
              //   //add duration of press gap
              //   ctime = now;
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //       content: Text(
              //           'Press Back Button Again to Exit'))); //scaffold message, you can show Toast message too.
              //   return false;
              // }
              return false;
            },
              child: ListView(
                children: [
                  const SizedBox(
                    height: Dimensions.dp10,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          isAmts = !isAmts;
                          routeData = null;
                          newFromSelectedStation = null;
                          oldFromSelectedStation = null;
                          newToSelectedStation = null;
                          oldToSelectedStation = null;
                          BlocProvider.of<HomeScreenBloc>(context).add(
                              GetAvailableStopsEvent(
                                  StopRequestModel(stopType: isAmts ? 2 : 1)));
                          BlocProvider.of<HomeScreenBloc>(context).add(
                              GetAvailableRoutesEvent(
                                  RoutesRequestModel(stopType: isAmts ? 2 : 1)));
                          // Loader.show(context);

                          Future.delayed(const Duration(milliseconds: 100), () {
                            ThemeService().switchTheme(isAmts);

                            // BlocProvider.of<HomeScreenBloc>(context).add(
                            //     GetAvailableStopsEvent(
                            //         StopRequestModel(stopType: isAmts ? 2 : 1)));
                            // BlocProvider.of<HomeScreenBloc>(context).add(
                            //     GetAvailableRoutesEvent(
                            //         RoutesRequestModel(stopType: isAmts ? 2 : 1)));
                          });
                          setQuickLinks();
                          setState(() {});
                        },
                        child: Container(
                          height: Dimensions.dp40,
                          width: Dimensions.dp140,
                          margin: const EdgeInsets.only(
                              left: Dimensions.dp20, right: Dimensions.dp30),
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  color: AppColors.gray6E8EE7,
                                  blurRadius: 5.0,
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                              ),
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(Dimensions.dp50))),
                          child: Container(
                            margin: const EdgeInsets.all(3.0),
                            child: Row(children: [
                              Container(
                                  height: Dimensions.dp40,
                                  width: Dimensions.dp65,
                                  decoration: BoxDecoration(
                                      color: !isAmts
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Dimensions.dp50))),
                                  child: Center(
                                    child: Text(
                                      "BRTS",
                                      style: satoshiRegular.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: !isAmts
                                              ? Colors.white
                                              : AppColors.darkGray),
                                    ),
                                  )),
                              Container(
                                  height: Dimensions.dp40,
                                  width: Dimensions.dp65,
                                  decoration: BoxDecoration(
                                      color: isAmts
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(Dimensions.dp50))),
                                  child: Center(
                                    child: Text(
                                      "AMTS",
                                      style: satoshiRegular.copyWith(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w700,
                                          color: isAmts
                                              ? Colors.white
                                              : AppColors.darkGray),
                                    ),
                                  )),
                            ]),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.to(NotificationScreen(from: "home"));
                        },
                        child: ImageIcon(AssetImage(ImageConstant.iNotification),
                            color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                          margin: const EdgeInsets.only(right: Dimensions.dp20),
                          child: InkWell(
                              onTap: () {
                                _scaffoldKey.currentState!.openEndDrawer();
                              },
                              child: SvgPicture.asset(ImageConstant.iMenu)))
                    ],
                  ),
                //  if (brtsRoutesResponseModel != null)
                    GestureDetector(
                      onTap: () async {
                        routeData = await Get.toNamed(
                            RouteHelper.getSearchRouteScreenRoute(
                                selectedLanguage ?? "", "",isAmts ? "AMTS" : "BRTS" ),
                            arguments: [brtsRoutesResponseModel, isAmts])
                        as RouteData;
                        setState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: Dimensions.dp24,
                            right: Dimensions.dp24,
                            top: Dimensions.dp26),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 14),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(Dimensions.dp10),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            routeData = await Get.toNamed(
                                RouteHelper.getSearchRouteScreenRoute(
                                    selectedLanguage ?? "", "",isAmts ? "AMTS" : "BRTS"),
                                arguments: [brtsRoutesResponseModel, isAmts])
                            as RouteData;
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(ImageConstant.iSearch,
                                  height: 20, width: 20),
                              const SizedBox(
                                width: 14,
                              ),
                              Text(
                                AppLocalizations.of(context)
                                        ?.translate("searchbusroutenumber") ??
                                    "",
                                style: satoshiRegular.copyWith(
                                    fontSize: Dimensions.dp13.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.lightGray),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: Dimensions.dp25,
                  ),
                  GestureDetector(
                    onTap: (){
                     // Get.to(MerchantApp());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.dp20, right: Dimensions.dp30),
                      child: Text(
                        AppLocalizations.of(context)?.translate("planyourtrip") ?? "",
                        style: satoshiRegular.copyWith(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.darkGray),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.dp15,
                  ),
                 // if (operationBrtsStopResponseModel != null)
                    Container(
                      margin: const EdgeInsets.only(
                          left: Dimensions.dp20, right: Dimensions.dp30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gray6E8EE7,
                            blurRadius: 5.0,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                          Radius.circular(Dimensions.dp16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.dp10, vertical: Dimensions.dp19),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 170,
                              child: Stack(
                                fit: StackFit.loose,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        routeData = null;
                                      });

                                      oldFromSelectedStation =
                                          newFromSelectedStation;
                                      newFromSelectedStation = await Get.toNamed(
                                          RouteHelper
                                              .getSearchStopScreenRoute(
                                              selectedLanguage ?? "", isAmts ? "AMTS" : "BRTS" ),
                                          arguments: operationBrtsStopResponseModel) as DataHive;
                                      setState(() {});
                                    },

                                    child: SourceDestinationWidget(
                                        title: "From",
                                        // content: isAmts
                                        //     ? "Ahmedabad Municipal Transport Service"
                                        //     : "Bus Rapid Transit System (BRTS)",
                                        contentTitle: SizedBox(
                                          height: 42,
                                          child: GestureDetector(

                                            child: Text(
                                                selectedLanguage == "gu" ? routeData != null
                                                    ? routeData?.routeNameGujarati
                                                    ?.split("-")[0] ??
                                                    AppLocalizations.of(context)
                                                        ?.translate(
                                                        "selectsource") ??
                                                    ""
                                                    : newFromSelectedStation
                                                    ?.stopNameGujarati ??
                                                    AppLocalizations.of(context)
                                                        ?.translate(
                                                        "selectsource") ??
                                                    "" : routeData != null
                                                    ? routeData?.routeName
                                                    ?.split("-")[0] ??
                                                    AppLocalizations.of(context)
                                                        ?.translate(
                                                        "selectsource") ??
                                                    ""
                                                    : newFromSelectedStation
                                                    ?.stopName ??
                                                    AppLocalizations.of(context)
                                                        ?.translate(
                                                        "selectsource") ??
                                                    "",
                                                style: satoshiRegular.copyWith(
                                                    fontSize: fontSize,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.darkGray)),
                                          ),
                                        ),
                                        svgImageFile: ImageConstant.iFromBus),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          routeData = null;
                                        });
                                        oldToSelectedStation =
                                            newToSelectedStation;
                                        newToSelectedStation = await Get.toNamed(
                                            RouteHelper
                                                .getSearchStopScreenRoute(
                                                selectedLanguage ?? "", isAmts ? "AMTS" : "BRTS"),
                                            arguments: operationBrtsStopResponseModel)
                                        as DataHive;
                                        setState(() {});
                                      },
                                      child: SourceDestinationWidget(
                                          title: "To",
                                          // content: isAmts
                                          //     ? "Ahmedabad Municipal Transport Service"
                                          //     : "Bus Rapid Transit System (BRTS)",
                                          contentTitle: SizedBox(
                                            height: 42,
                                            child: GestureDetector(

                                              child: Text(
                                                 selectedLanguage == "gu" ?  routeData != null
                                                     ? routeData?.routeNameGujarati
                                                     ?.split("-")[1] ??
                                                     AppLocalizations.of(context)
                                                         ?.translate(
                                                         "selectdestination") ??
                                                     ""
                                                     : newToSelectedStation
                                                     ?.stopNameGujarati ??
                                                     AppLocalizations.of(context)
                                                         ?.translate(
                                                         "selectdestination") ??
                                                     "" :  routeData != null
                                                     ? routeData?.routeName
                                                     ?.split("-")[1] ??
                                                     AppLocalizations.of(context)
                                                         ?.translate(
                                                         "selectdestination") ??
                                                     ""
                                                     : newToSelectedStation
                                                     ?.stopName ??
                                                     AppLocalizations.of(context)
                                                         ?.translate(
                                                         "selectdestination") ??
                                                     "",
                                                  style: satoshiRegular.copyWith(
                                                      fontSize: fontSize,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors.darkGray)),
                                            ),
                                          ),
                                          svgImageFile: ImageConstant.iToBus),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () {
                                          if (routeData == null) {
                                            DataHive? temp = newFromSelectedStation;
                                            newFromSelectedStation =
                                                newToSelectedStation;
                                            newToSelectedStation = temp;
                                            FocusScope.of(context).unfocus();
                                            setState(() {});
                                          }
                                        },
                                        child: Container(
                                          width: 48,
                                          height: 48,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              border:
                                                  Border.fromBorderSide(BorderSide(
                                                color: AppColors.gray6E8EE7,
                                                width: 1,
                                              )),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                                ImageConstant.iArrowDownUp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  left: Dimensions.dp10,
                                  right: Dimensions.dp10,
                                  top: Dimensions.dp15),
                              child: CustomButton(
                                color: Theme.of(context).primaryColor,
                                text: AppLocalizations.of(context)
                                        ?.translate("showroutefare") ??
                                    "",
                                width: MediaQuery.of(context).size.width,
                                onPressed: () async{
                                  if(newFromSelectedStation != null && newFromSelectedStation?.stationCode == newToSelectedStation?.stationCode){
                                    showCustomSnackBar(
                                        "Please Select Different Source & Destination Station",
                                        context,
                                        isError: true);
                                  }
                                  else{
                                    if (routeData != null) {
                                      Get.toNamed(
                                        RouteHelper.getRouteDetailsRoute(
                                            routeData?.routeName
                                                ?.split("-")[0]
                                                .trim() ??
                                                "",
                                            routeData?.customerRouteCode ?? "",
                                            routeData?.routeName
                                                ?.split("-")[1]
                                                .trim() ??
                                                "",
                                            routeData?.customerRouteCode ?? "",
                                            routeData?.routeCode ?? "",
                                            "",
                                            "0",
                                            "Yes",
                                            "",
                                            "",
                                            isAmts ? "AMTS" : "BRTS",
                                            "",
                                            "",
                                            "",
                                            "","00:00:00","","","",""),
                                      );
                                    } else if (newFromSelectedStation != null &&
                                        newToSelectedStation != null) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SearchResultScreen(
                                            startRoute:  newFromSelectedStation?.stationCode
                                                  .toString() ??
                                                  "",
                                            endRoute:  newToSelectedStation?.stationCode
                                                  .toString() ??
                                                  "",
                                            startRouteName:  newFromSelectedStation?.stopName ?? "",
                                          endRouteName:    newToSelectedStation?.stopName ?? "",
                                          serviceType:    isAmts ? "AMTS" : "BRTS")),
                                      ).then((context) => _initScreenA());
                                      // Handle the result returned from ScreenB.
                                      // if (result == "initScreenA") {
                                      //   // Call the init method or perform the desired action in ScreenA.
                                      //   _initScreenA();
                                      // }

                                      // Get.toNamed(RouteHelper.getSearchResultRoute(
                                      //     newFromSelectedStation?.stationCode
                                      //         .toString() ??
                                      //         "",
                                      //     newToSelectedStation?.stationCode
                                      //         .toString() ??
                                      //         "",
                                      //     newFromSelectedStation?.stopName ?? "",
                                      //     newToSelectedStation?.stopName ?? "",
                                      //     isAmts ? "AMTS" : "BRTS"));
                                    } else {
                                      showCustomSnackBar(
                                          "Please Select Source & Destination Station",
                                          context,
                                          isError: true);
                                    }
                                  }


                                },
                                style: satoshiRegular.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                height: Dimensions.dp53,
                              ),
                            ),
                           if(isAmts)
                             Container(
                              margin: const EdgeInsets.only(
                                  left: Dimensions.dp10,
                                  right: Dimensions.dp10,
                                  top: Dimensions.dp14),
                              child: CustomButton(
                                color: Theme.of(context).primaryColor,
                                text: AppLocalizations.of(context)
                                    ?.translate("onedaypass") ??
                                    "",
                                width: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  AppConstant.nameData.isEmpty ?
                                  Get.toNamed(RouteHelper.getSplashRoute())  :
                                  Get.toNamed(RouteHelper.getoneDayPassRoute("PASS" ?? "",isAmts ? "AMTS" : "BRTS")) ;

                                },
                                style: satoshiRegular.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                height: Dimensions.dp53,
                              ),
                            ),
                            isAmts ?
                              Container() :
                            Container(
                              margin: const EdgeInsets.only(
                                  left: Dimensions.dp10,
                                  right: Dimensions.dp10,
                                  top: Dimensions.dp14),
                              child: CustomButton(
                                color: Theme.of(context).primaryColor,
                                text: AppLocalizations.of(context)
                                    ?.translate("quick_book_ticket") ??
                                    "",
                                width: MediaQuery.of(context).size.width,
                                onPressed: () {
                                  if(newFromSelectedStation == null || newToSelectedStation == null){
                                    showCustomSnackBar(
                                        "Please Select Source & Destination Station",
                                        context,
                                        isError: true);
                                  }
                                  else if(newFromSelectedStation != null && newFromSelectedStation?.stationCode == newToSelectedStation?.stationCode){
                                    showCustomSnackBar(
                                        "Please Select Different Source & Destination Station",
                                        context,
                                        isError: true);
                                  }
                                  else{
                                    openDialogBox();

                                  }
                                },
                                style: satoshiRegular.copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                                height: Dimensions.dp53,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: Dimensions.dp18,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: Dimensions.dp20, right: Dimensions.dp30),
                    child: Text(
                      AppLocalizations.of(context)?.translate("quicklinks") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkGray),
                    ),
                  ),
                  Container(
                    height: 230.sp,
                    margin:  EdgeInsets.only(
                        left: Dimensions.dp20.sp,
                        right: Dimensions.dp30.sp,
                        top: Dimensions.dp16.sp),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.gray6E8EE7,
                            blurRadius: Dimensions.dp5,
                          ),
                        ],
                        borderRadius:
                            BorderRadius.all(Radius.circular(Dimensions.dp16))),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding:  EdgeInsets.all(Dimensions.dp20.sp),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: quickLinkList.length,
                        gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: Dimensions.dp10.sp,
                                childAspectRatio: 1 / 0.9,
                                mainAxisSpacing: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return getGridItemWidget(quickLinkList[index]);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.dp40,
                  )
                ],
              ),
          );
        }),
            ));
  }

  @override
  void dispose() {
    super.dispose();
    Loader.hide();
  }

  BrtsStopResponseModel? getSortedData(DataHive? dataAdd, DataHive? dataRemove) {
    if (dataRemove != null) {
      operationBrtsStopResponseModel?.data?.remove(dataRemove);
    }
    if (dataAdd != null) {
      if (!operationBrtsStopResponseModel!.data!.contains(dataAdd)) {
        operationBrtsStopResponseModel?.data?.add(dataAdd);
      }
    }
    return operationBrtsStopResponseModel;
  }

  Widget getGridItemWidget(QuickLinkInternalModel model) {
    return GestureDetector(
      onTap: () {
        if (model.title == "feedback") {
          Get.toNamed(RouteHelper.getFeedbackRoute());
        } else if (model.title == "myroutes") {
          Get.toNamed(
              RouteHelper.getMyRoutesTabScreenRoute(!isAmts ? "BRTS" : "AMTS", "home"));
        } else if (model.title == "mticket") {
          Get.toNamed(RouteHelper.getBookingRoute("menu"));
        } else if (model.title == "near_me") {
          // Get.toNamed(RouteHelper.getNearByRoute());
          Get.to( NearByMapsScreen(from: "home", stopType: isAmts ? "2" : "1",));
        } else if (model.title == "smartrecharge") {
          Get.toNamed(RouteHelper.getCardDetailsRoute());
        } else if (model.title == "complaint") {
          Get.to(ComplaintScreen(stopType: isAmts ? "AMTS" : "BRTS",));

        } else if (model.title == "transitmap") {
          Get.toNamed(RouteHelper.getTransitMapScreenRoute());
        }
      },
      child: Column(
        children: [
          SvgPicture.asset(
            model.imagePath,
            height: Dimensions.dp35.sp,
            width: Dimensions.dp35.sp,
            color: Theme.of(context).primaryColor,
          ),
           SizedBox(
            height: Dimensions.dp4.sp,
          ),
          Text(
            AppLocalizations.of(context)?.translate(model.title) ?? "",
            textAlign: TextAlign.center,
            style: satoshiRegular.copyWith(
                fontSize: Dimensions.dp12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray),
          )
        ],
      ),
    );
  }
  void _initScreenA() {
    // Initialize ScreenA here.
    setState(() {
      // operationBrtsStopResponseModel?.data?.add(newFromSelectedStation!);
      // operationBrtsStopResponseModel?.data?.add(newToSelectedStation!);
      newFromSelectedStation = null;
      newToSelectedStation = null;

    });
    print('ScreenA initialized');
  }

}
