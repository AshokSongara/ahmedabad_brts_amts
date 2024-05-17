import 'dart:convert';
import 'dart:io';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/language/language_cubit.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/home_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/tnc/terms_and_conditions_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/round_container_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/image_constant.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";
  bool showLocationPermissionDialog = true;
  late ThemeData themeData;
  bool isLocationPermissionDialogShown = false;
  String latestAndroidVersion = "";
  String latestIOSVersion = "";
  String currentAppVersion = "";


  @override
  void initState() {
    super.initState();
    if(Platform.isAndroid) getVersionInfo();
    //fetchLatestVersion();
   // if(currentAppVersionAndroid != latestAndroidVersion)_showUpdateDialog();
    if (Globals.isLocationPermissionDialogShown) {
      _showLocationPermissionDialog();
      Globals.isLocationPermissionDialogShown = false;
    }
    // BlocProvider.of<HomeScreenBloc>(context)
    //     .add(GetAvailableStopsEvent(StopRequestModel(stopType: 1)));
    //
    // BlocProvider.of<HomeScreenBloc>(context)
    //     .add(GetAvailableStopsEvent(StopRequestModel(stopType: 2)));
    //
    // BlocProvider.of<HomeScreenBloc>(context)
    //     .add(GetAvailableRoutesEvent(RoutesRequestModel(stopType: 1)));
    //
    // BlocProvider.of<HomeScreenBloc>(context)
    //     .add(GetAvailableRoutesEvent(RoutesRequestModel(stopType: 2)));

   // _getLocationPermission();
    getMemberID();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Theme.of(context); // Access inherited theme here
    // if (showLocationPermissionDialog) {
    //   _showLocationPermissionDialog();
    // } else {
    //   _getLocationPermission();
    // }
  }

  Future<void> fetchLatestVersion() async {
    final response = await http.get(Uri.parse('https://www.transportapp.co.in/Common/appVersions'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        latestAndroidVersion = data['data']['androidVersion'];
        latestIOSVersion = data['data']['iosVersion'];
      });
    }
    if(currentAppVersion != latestAndroidVersion && Platform.isAndroid)_showUpdateDialog();


    else {
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<LanguageCubit>().changeStartLang();
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 10),
                  height: Dimensions.dp70,
                  width: Dimensions.dp60,
                  child: SvgPicture.asset(ImageConstant.iBus)),
              const SizedBox(
                height: Dimensions.dp30,
              ),
              Center(
                child: Text(
                  "Welcome!",
                  style: globalStyle,
                ),
              ),
              const SizedBox(
                height: Dimensions.dp20,
              ),
              Container(
                margin: const EdgeInsets.only(
                    left: Dimensions.dp30, right: Dimensions.dp30),
                height: 0.3,
                color: AppColors.lightPrimary,
              ),
              const SizedBox(
                height: Dimensions.dp20,
              ),
              Center(
                child: Text(
                  "Get started by creating your account",
                  style: satoshiRegular,
                ),
              ),

              const SizedBox(
                height: Dimensions.dp25,
              ),
              GestureDetector(
                onTap: () {
                 // _initiatePayment();
                 Get.toNamed(RouteHelper.getLoginRoute());
                },
                child: const RoundContainerWidget(
                    imagePath: ImageConstant.iMail,
                    menuTitle: "Login with Email"),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getMobileNumberRoute());
                },
                child: const RoundContainerWidget(
                    imagePath: ImageConstant.iMobile,
                    menuTitle: "Login with Mobile No."),
              ),
              // const SizedBox(
              //   height: 16,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Get.offNamed(RouteHelper.getDashboardRoute());
              //   },
              //   child: const RoundContainerWidget(
              //       imagePath: ImageConstant.iUser,
              //       menuTitle: "Login as Guest"),
              // ),
              const SizedBox(
                height: Dimensions.dp25,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don’t have an account?",
                    style: satoshiRegular.copyWith(
                      fontSize: 14,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: " ",
                          style: satoshiRegular.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w700)),
                      TextSpan(
                        text: "Sign Up",
                        style: satoshiRegular.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w700),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => {Get.toNamed(RouteHelper.signup)},
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.dp40.h,
              ),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.dp50),
                        topRight: Radius.circular(Dimensions.dp50)),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                left: Dimensions.dp30, right: Dimensions.dp30),
                            child: Image.asset(ImageConstant.iCombineLogo)),
                        SizedBox(
                          height: Dimensions.dp10.h.h,
                        ),
                        Text(
                          "By creating an account, I accept App’s ",
                          style: satoshiRegular.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.to(TermsAndConditionScreen());
                          },
                          child: Text(
                            "Terms and conditions.",
                            style: satoshiRegular.copyWith(
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w300,
                                color: AppColors.lightBlue),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.dp20.h,
                        )
                      ]),
                ),
              )
            ],
          ),
        ));
  }

  void _showLocationPermissionDialog() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Location Permission",
              style: TextStyle(fontSize: 20.sp),
            ),
            contentPadding: EdgeInsets.fromLTRB(24.sp, 20.sp, 24.sp, 0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  ImageConstant.iPlace,
                  height: Dimensions.dp100,
                  width: Dimensions.dp100,
                ),
                SizedBox(height: 12.sp),
                Text(
                  "We require access of your location to get nearer bus stop from your location and enhance user experience",
                  //textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  setState(() {
                    showLocationPermissionDialog = false;
                  });

                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }

  void _showUpdateDialog(){
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false, // Prevents dialog from closing when back button is pressed
          child: AlertDialog(
            title: Text('New version available'),
            content: Text('A new version of the app is available. Please update to continue using the app.'),
            actions: <Widget>[
              TextButton(
                child: Text('Update'),
                onPressed: () {
                  _launchURL(Uri.parse("https://play.google.com/store/apps/details?id=com.ahmedabad_brts_amts.ahmedabad_brts_amts"));
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstant.accessToken) ?? "";
    AppConstant.IsLoggedIn = prefs.getString(AppConstant.accessToken) ?? "";
    AppConstant.nameData = prefs.getString(AppConstant.name) ?? "";
    AppConstant.emailData = prefs.getString(AppConstant.email) ?? "";
    AppConstant.lastNameData = prefs.getString(AppConstant.lastName) ?? "";
    if (token.isNotEmpty) {
      Get.offAll(HomeScreen());
    }
  }

   getVersionInfo(){
     PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
       String appName = packageInfo.appName;
       String packageName = packageInfo.packageName;
       String version = packageInfo.version;
       String buildNumber = packageInfo.buildNumber;
       setState(() {
         currentAppVersion = version;
       });
       print(currentAppVersion);
     });

     fetchLatestVersion();


   }
}

// void _getLocationPermission() async {
//   Location location = Location();
//
//   bool serviceEnabled;
//   PermissionStatus permissionGranted;
//   LocationData locationData;
//
//   serviceEnabled = await location.serviceEnabled();
//   if (!serviceEnabled) {
//     debugPrint("Location service is not enabled :(");
//     serviceEnabled = await location.requestService();
//     if (!serviceEnabled) {
//       return;
//     }
//   }
//
//   permissionGranted = await location.hasPermission();
//   if (permissionGranted == PermissionStatus.denied) {
//     debugPrint("Location Permission Denied :(");
//     permissionGranted = await location.requestPermission();
//     if (permissionGranted != PermissionStatus.granted) {
//       debugPrint("Location Permission Granted!!");
//       return;
//     }
//   }
//
//   locationData = await location.getLocation();
//   debugPrint("_locationData latitude:- ${locationData.latitude}");
//   debugPrint("_locationData longitude:- ${locationData.longitude}");
//   debugPrint("_locationData altitude:- ${locationData.altitude}");
//   debugPrint("_locationData provider:- ${locationData.provider}");
// }

class Globals {
  static bool isLocationPermissionDialogShown = true;
}
