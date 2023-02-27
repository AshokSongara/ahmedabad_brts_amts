import 'package:ahmedabad_brts_amts/core/loader/overylay_loader.dart';
import 'package:ahmedabad_brts_amts/core/theme/theme_service.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/routes_request_model.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/stop_request_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/localization/app_localizations.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/language/language_cubit.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_snackbar.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/source_destination_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  double fontSize = Dimensions.dp18.sp;
  BrtsRoutesResponseModel? brtsRoutesResponseModel;
  BrtsStopResponseModel? operationBrtsStopResponseModel;
  RouteData? routeData;
  Data? newFromSelectedStation, oldFromSelectedStation;
  Data? newToSelectedStation, oldToSelectedStation;
  String? selectedLanguage;
  String userName = "Guest User";
  static const platform = MethodChannel('nativeChannel');

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      ThemeService().switchTheme(isAmts);
    });
    context.read<LanguageCubit>().getCurrentSelectedLanguage().then((value) {
      selectedLanguage = value;
    });

    getMemberID();

    BlocProvider.of<HomeScreenBloc>(context).add(
        GetAvailableStopsEvent(StopRequestModel(stopType: isAmts ? 2 : 1)));
    BlocProvider.of<HomeScreenBloc>(context).add(
        GetAvailableRoutesEvent(RoutesRequestModel(stopType: isAmts ? 2 : 1)));
    Loader.show(context);
    setQuickLinks();
  }

  setQuickLinks(){
    quickLinkList.clear();
    quickLinkList.add(QuickLinkInternalModel("mticket", ImageConstant.iTicket));
    quickLinkList
        .add(QuickLinkInternalModel("smartrecharge", ImageConstant.iMobileRed));
    quickLinkList.add(QuickLinkInternalModel("near_me", ImageConstant.iRoute));
    quickLinkList.add(QuickLinkInternalModel("myroutes", ImageConstant.iRate));
    if (!isAmts) {
      quickLinkList
          .add(QuickLinkInternalModel("transitmap", ImageConstant.iMap));
    }
    quickLinkList.add(QuickLinkInternalModel("feedback", ImageConstant.iChat));
  }
  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    AppConstant.IsLoggedIn = prefs.getString(AppConstant.accessToken) ?? "";
    AppConstant.nameData = prefs.getString(AppConstant.name) ?? "";
    AppConstant.emailData = prefs.getString(AppConstant.email) ?? "";
    AppConstant.lastNameData = prefs.getString(AppConstant.lastName) ?? "";

    if (AppConstant.IsLoggedIn.isNotEmpty) {
      userName = prefs.getString(AppConstant.name) ?? "Guest User";
    } else {
      userName = "Guest User";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBackground,
        endDrawer: Drawer(
          backgroundColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.only(
                top: Dimensions.dp24,
                left: Dimensions.dp43,
                right: Dimensions.dp43),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(ImageConstant.iClose)),
                  Padding(
                    padding: const EdgeInsets.only(top: Dimensions.dp35),
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
                              AppConstant.nameData,
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            Text(
                              "View Profile",
                              style: satoshiRegular.copyWith(
                                  fontSize: Dimensions.dp12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
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
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                              ?.translate("transaction_history") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getBookingRoute("homes"));
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iRoute,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                              ?.translate("smart_card_recharge") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getCardDetailsRoute());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iRoute,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("near_me") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: Dimensions.dp19,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getNearByMapScreenRoute());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iRate,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("myroutes") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getMyRouteScreen());
                    },
                  ),
                  if (!isAmts)
                    ListTile(
                      leading: SvgPicture.asset(
                        ImageConstant.iMap,
                        color: Colors.white,
                        height: Dimensions.dp28,
                        width: Dimensions.dp28,
                      ),
                      title: Text(
                        AppLocalizations.of(context)?.translate("transitmap") ??
                            "",
                        style: satoshiRegular.copyWith(
                            fontSize: 19.sp,
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
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("feedback") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getFeedbackRoute());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iSpeaker,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                              ?.translate("invite_friends") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iCall,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("contact_us") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () {
                      Get.toNamed(RouteHelper.getContactUsRoute());
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iLangauge,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)
                              ?.translate("change_langauge") ??
                          "",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      selectedLanguage = await Get.toNamed(
                          RouteHelper.getChangeLangaugeScreenRoute()) as String;
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      ImageConstant.iSignOut,
                      color: Colors.white,
                      height: Dimensions.dp28,
                      width: Dimensions.dp28,
                    ),
                    title: Text(
                      AppLocalizations.of(context)?.translate("signout") ?? "",
                      style: satoshiRegular.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                      Get.offAllNamed(RouteHelper.login);
                    },
                  ),
                  const SizedBox(
                    height: Dimensions.dp50,
                  ),
                ],
              ),
            ),
          ),
        ),
        body:
            BlocConsumer<HomeScreenBloc, HomeState>(listener: (context, state) {
          if (state is StopsResponseState) {
            operationBrtsStopResponseModel = state.model;
          }
          if (state is SourceSelectionFromMapScreenState) {
            newFromSelectedStation = state.data;
          }
          if (state is RoutesResponseState) {
            brtsRoutesResponseModel = state.model;
            Loader.hide();
          }
          if (state is HomeLoadingState) {
          } else {
            FocusScope.of(context).unfocus();
          }
        }, builder: (context, state) {
          return ListView(
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
                      Loader.show(context);
                      Future.delayed(const Duration(milliseconds: 100), () {
                        ThemeService().switchTheme(isAmts);
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
                  Container(
                      margin: const EdgeInsets.only(right: Dimensions.dp20),
                      child: InkWell(
                          onTap: () {
                            _scaffoldKey.currentState!.openEndDrawer();
                          },
                          child: SvgPicture.asset(ImageConstant.iMenu)))
                ],
              ),
              if (brtsRoutesResponseModel != null)
                Container(
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
                                  selectedLanguage ?? ""),
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
              const SizedBox(
                height: Dimensions.dp25,
              ),
              Container(
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
              const SizedBox(
                height: Dimensions.dp15,
              ),
              if (operationBrtsStopResponseModel != null)
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
                              SourceDestinationWidget(
                                  title: "From",
                                  content: isAmts
                                      ? "Ahmedabad Municipal Transport Service"
                                      : "Bus Rapid Transit System (BRTS)",
                                  contentTitle: SizedBox(
                                    height: 28,
                                    child: GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          routeData = null;
                                        });

                                        oldFromSelectedStation =
                                            newFromSelectedStation;
                                        newFromSelectedStation = await Get.toNamed(
                                            RouteHelper
                                                .getSearchStopScreenRoute(
                                                    selectedLanguage ?? ""),
                                            arguments: getSortedData(
                                                oldToSelectedStation,
                                                newToSelectedStation)) as Data;
                                        setState(() {});
                                      },
                                      child: Text(
                                          routeData != null
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
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: SourceDestinationWidget(
                                    title: "To",
                                    content: isAmts
                                        ? "Ahmedabad Municipal Transport Service"
                                        : "Bus Rapid Transit System (BRTS)",
                                    contentTitle: SizedBox(
                                      height: 28,
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
                                                          selectedLanguage ?? ""),
                                                  arguments: getSortedData(
                                                      oldFromSelectedStation,
                                                      newFromSelectedStation))
                                              as Data;
                                          setState(() {});
                                        },
                                        child: Text(
                                            routeData != null
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
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: InkWell(
                                    onTap: () {
                                      if (routeData == null) {
                                        Data? temp = newFromSelectedStation;
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
                                      ""),
                                );
                              } else if (newFromSelectedStation != null &&
                                  newToSelectedStation != null) {
                                Get.toNamed(RouteHelper.getSearchResultRoute(
                                    newFromSelectedStation?.stationCode
                                            .toString() ??
                                        "",
                                    newToSelectedStation?.stationCode
                                            .toString() ??
                                        "",
                                    newFromSelectedStation?.stopName ?? "",
                                    newToSelectedStation?.stopName ?? "",
                                    isAmts ? "AMTS" : "BRTS"));
                              } else {
                                showCustomSnackBar(
                                    "Please Select Source & Destination Station",
                                    context,
                                    isError: true);
                              }
                            },
                            style: satoshiRegular.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                            height: Dimensions.dp53,
                          ),
                        ),
                        if (isAmts)
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
                                Get.toNamed(RouteHelper.getoneDayPassRoute());
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
                height: 200,
                margin: const EdgeInsets.only(
                    left: Dimensions.dp20,
                    right: Dimensions.dp30,
                    top: Dimensions.dp16),
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
                  padding: const EdgeInsets.all(Dimensions.dp20),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: quickLinkList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: Dimensions.dp10,
                            childAspectRatio: 1 / 0.8,
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
          );
        }));
  }

  BrtsStopResponseModel? getSortedData(Data? dataAdd, Data? dataRemove) {
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
          Get.toNamed(RouteHelper.getMyRouteScreen());
        } else if (model.title == "near_me") {
          // Get.toNamed(RouteHelper.getNearByRoute());
          Get.toNamed(RouteHelper.getNearByMapScreenRoute());
        } else if (model.title == "smartrecharge") {
          Get.toNamed(RouteHelper.getCardDetailsRoute());
        } else if (model.title == "transitmap") {
          Get.toNamed(RouteHelper.getTransitMapScreenRoute());
        }
      },
      child: Column(
        children: [
          SvgPicture.asset(
            model.imagePath,
            height: Dimensions.dp35,
            width: Dimensions.dp35,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: Dimensions.dp4,
          ),
          Text(
            AppLocalizations.of(context)?.translate(model.title) ?? "",
            textAlign: TextAlign.center,
            style: satoshiRegular.copyWith(
                fontSize: Dimensions.dp14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.darkGray),
          )
        ],
      ),
    );
  }
}
