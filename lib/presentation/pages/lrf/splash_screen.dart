import 'package:ahmedabad_brts_amts/data/requestmodels/stop_request_model.dart';
import 'package:ahmedabad_brts_amts/helper/route_helper.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/round_container_widget.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/dimensions.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart';
import '../../../utils/image_constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeScreenBloc>(context).add(GetAvailableRoutesEvent(StopRequestModel(stopType: 1)));
    BlocProvider.of<HomeScreenBloc>(context).add(GetAvailableRoutesEvent(StopRequestModel(stopType: 2)));
    _getLocationPermission();
    getMemberID();
  }

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Welcome!",
                style: globalStyle,
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
              Text(
                "Get started by creating your account",
                style: satoshiRegular,
              ),
              const SizedBox(
                height: Dimensions.dp25,
              ),
              GestureDetector(
                onTap: () {
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
                    menuTitle: "Login with Mobile Number"),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  Get.offNamed(RouteHelper.getDashboardRoute());
                },
                child: const RoundContainerWidget(
                    imagePath: ImageConstant.iUser,
                    menuTitle: "Login as Guest"),
              ),
              const SizedBox(
                height: Dimensions.dp25,
              ),
              RichText(
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
              const SizedBox(
                height: Dimensions.dp25,
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
                  child: Column(children: [
                    Container(
                        margin: const EdgeInsets.only(
                            top: Dimensions.dp60,
                            left: Dimensions.dp30,
                            right: Dimensions.dp30),
                        child: Image.asset(ImageConstant.iCombineLogo)),
                    const SizedBox(
                      height: Dimensions.dp40,
                    ),
                    Text(
                      "By creating an account, I accept App’s ",
                      style: satoshiRegular.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    ),
                    Text(
                      "Terms of Service.",
                      style: satoshiRegular.copyWith(
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w300,
                          color: AppColors.lightBlue),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ));
  }

  getMemberID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(AppConstant.accessToken) ?? "";
    if (token.isNotEmpty) {
      Get.offNamed(RouteHelper.dashboard);
    }
  }
}

void _getLocationPermission() async{
  Location location = Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    debugPrint("Location service is not enabled :(");
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    debugPrint("Location Permission Denied :(");
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      debugPrint("Location Permission Granted!!");
      return;
    }
  }

  _locationData = await location.getLocation();
  debugPrint("_locationData latitude:- ${_locationData.latitude}");
  debugPrint("_locationData longitude:- ${_locationData.longitude}");
  debugPrint("_locationData altitude:- ${_locationData.altitude}");
  debugPrint("_locationData provider:- ${_locationData.provider}");

}
