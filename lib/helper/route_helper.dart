import 'package:ahmedabad_brts_amts/presentation/pages/booking/booking_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/card_details/card_detail_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/contact_us/contact_us_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/route_details/route_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/feedback/feedback_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/language/choose_language_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/forget_password_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/otp_verification_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/login_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/mobile_number_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/reset_password_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/signup_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/maps/nearby_maps_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/my_routes/my_routes_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/near_by_search/search_stop_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/nearby/nearby_sreen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/one_day_pass/one_day_pass_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/passenger_details/passenger_details.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_details/payment_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/search_route/search_route_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/search_route_number/search_route_number_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/search_stop/search_stop_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/transitmap/transitmap_screen.dart';
import 'package:get/get.dart';
import '../presentation/pages/dashboard/search_result_screen.dart';
import '../presentation/pages/lrf/splash_screen.dart';
import '../presentation/pages/nearby_stops/nearby_stops_screen.dart';
import '../presentation/pages/search_route_number/route_tab_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String mobileNumber = '/mobileNumber';
  static const String enterCode = '/enterCode';
  static const String dashboard = '/dashboard';
  static const String searchResult = '/searchResult';
  static const String routeDetails = '/routeDetails';
  static const String passengerDetails = '/passengerDetails';
  static const String cardDetails = '/cardDetails';
  static const String nearBy = '/nearBy';
  static const String feedback = '/feedback';
  static const String myRoute = '/myRoute';
  static const String searchRoute = '/searchRoute';
  static const String oneDayPassRoute = '/oneDayPass';
  static const String contactUs = '/contact_us';
  static const String payment = '/payment_details';
  static const String booking = '/booking';
  static const String forgetPassword = '/forgetPassword';
  static const String resetPassword = '/resetPassword';
  static const String searchStopScreen = '/searchStopScreen';
  static const String nearBySearchStopScreen = '/nearBySearchStopScreen';
  static const String searchRouteScreen = '/searchRouteScreen';
  static const String changeLanguage = '/changeLanguage';
  static const String nearbyMap = '/nearbyMap';
  static const String transitMap = '/transitMap';
  static const String routeSearchTab = '/route_search_tab';
  static const String nearByStops = '/near_by_stops';

  static String getInitialRoute() => initial;

  static String getSplashRoute() => splash;

  static String getLoginRoute() => login;

  static String getSignUpRoute(String type) => '$signup?type=$type';

  static String getMobileNumberRoute() => mobileNumber;

  static String getEnterCodeRoute(String mobileNumber) =>
      '$enterCode?mobile=$mobileNumber';

  static String getDashboardRoute() => dashboard;

  static String getSearchResultRoute(String startRoute, String endRoute,
          String startRouteName, String endRouteName, String serviceType) =>
      '$searchResult?startRoute=$startRoute&endRoute=$endRoute&startRouteName=$startRouteName&endRouteName=$endRouteName&serviceType=$serviceType';

  static String getRouteDetailsRoute(
          String startRouteName,
          String startRouteCode,
          String endRouteName,
          String endRouteCode,
          String routeCode,
          String startTime,
          String interChange,
          String fromHome,
          String originStart,
          String originEnd,
          String serviceType,
          String interChangeName,
          String routeTwo,
          String startRouteTwo,
          String endRouteTwo,
          String endTime,
          String startStopSequenceNumber,
          String endStopSequenceNumber,
          String? startID,
          String? endID) =>
      '$routeDetails?startRouteName=$startRouteName&startRouteCode=$startRouteCode&endRouteName=$endRouteName&endRouteCode=$endRouteCode&routeCode=$routeCode&startTime=$startTime&interChange=$interChange&fromHome=$fromHome&originStart=$originStart&originEnd=$originEnd&serviceType=$serviceType&interChangeName=$interChangeName&routeTwo=$routeTwo&startRouteTwo=$startRouteTwo&endRouteTwo=$endRouteTwo&endTime$endTime&startStopSequenceNumber=$startStopSequenceNumber&endStopSequenceNumber=$endStopSequenceNumber&startID=$startID&endID=$endID';

  static String getPassengerDetailsRoute(
          String sourceStopId, String destinationStopId, String routeCode,String serviceType) =>
      '$passengerDetails?sourceStopId=$sourceStopId&destinationStopId=$destinationStopId&routeCode=$routeCode&serviceType=$serviceType';

  static String getCardDetailsRoute() => cardDetails;

  static String getNearByRoute() => nearBy;

  static String getFeedbackRoute() => feedback;

  static String getMyRouteScreen() => myRoute;

  static String getSearchRoute() => searchRoute;

  static String getoneDayPassRoute() => oneDayPassRoute;

  static String getContactUsRoute() => contactUs;

  static String getPaymentDetailsRoute(
          String sourceStopId,
          String destinationStopId,
          String discountype,
          String txnStatus,
          String merchantId,
          String sourcecompanycode,
          String destinationcompanycode,
          String routeCode,String serviceType) =>
      '$payment?sourceStopId=$sourceStopId&destinationStopId=$destinationStopId&discountype=$discountype&txnStatus=$txnStatus&merchantId=$merchantId&sourcecompanycode=$sourcecompanycode&destinationcompanycode=$destinationcompanycode&routeCode=$routeCode&serviceType=$serviceType';

  static String getBookingRoute(String from) => '$booking?from=$from';

  static String getForgetPasswordRoute() => forgetPassword;

  static String getResetPasswordRoute(String number) => '$resetPassword?number=$number';

  static String getSearchStopScreenRoute(String selectedLanguage) =>
      '$searchStopScreen?selectedLanguage=$selectedLanguage';

  static String getSearchRouteScreenRoute(String selectedLanguage) =>
      '$searchRouteScreen?selectedLanguage=$selectedLanguage';

  static String getNearBySearchStopScreenRoute() => nearBySearchStopScreen;

  static String getChangeLangaugeScreenRoute() => changeLanguage;

  static String getNearByMapScreenRoute(String stopType) =>
      '$nearbyMap?stopType=$stopType';

  static String getTransitMapScreenRoute() => transitMap;

  static String getNearByStops(String title, String routeCode) =>
      '$nearByStops?title=$title&routeCode=$routeCode';

  static String getRouteSearchTab(String title, String routeCode) =>
      '$routeSearchTab?title=$title&routeCode=$routeCode';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(
        name: signup,
        page: () => SignupScreen(
          type: Get.parameters['type'],
        )),
    GetPage(name: mobileNumber, page: () => const MobileNumberScreen()),
    GetPage(name: oneDayPassRoute, page: () => const OneDayPassScreen()),
    GetPage(name: contactUs, page: () => const ContactUsScreen()),
    GetPage(
        name: searchStopScreen,
        page: () => SearchStopScreen(
            selectedLanguage: Get.parameters['selectedLanguage'] ?? "")),
    GetPage(
        name: nearBySearchStopScreen,
        page: () => const NearBySearchStopScreen()),
    GetPage(
        name: searchRouteScreen,
        page: () => SearchRouteScreen(
              selectedLanguage: Get.parameters['selectedLanguage'],
            )),
    GetPage(
        name: enterCode,
        page: () => OtpVerificationScreen(
              mobileNumber: Get.parameters['mobile'],
            )),
    GetPage(
        name: dashboard,
        page: () => DashboardScreen(
              pageIndex: 0,
            )),
    GetPage(
        name: searchResult,
        page: () => SearchResultScreen(
              startRoute: Get.parameters['startRoute'],
              endRoute: Get.parameters['endRoute'],
              startRouteName: Get.parameters['startRouteName'],
              endRouteName: Get.parameters['endRouteName'],
              serviceType: Get.parameters['serviceType'],
            )),
    GetPage(
        name: routeDetails,
        page: () => RouteDetailScreen(
              startRouteName: Get.parameters['startRouteName'],
              startRouteCode: Get.parameters['startRouteCode'],
              endRouteName: Get.parameters['endRouteName'],
              endRouteCode: Get.parameters['endRouteCode'],
              routeCode: Get.parameters['routeCode'],
              startTime: Get.parameters['startTime'],
              interChange: Get.parameters['interChange'],
              fromHome: Get.parameters['fromHome'],
              originStart: Get.parameters['originStart'],
              originEnd: Get.parameters['originEnd'],
              serviceType: Get.parameters['serviceType'],
              interChangeName: Get.parameters['interChangeName'],
              routeTwo: Get.parameters['routeTwo'],
              startRouteTwo: Get.parameters['startRouteTwo'],
              endRouteTwo: Get.parameters['endRouteTwo'],
              endTime: Get.parameters['endTime'],
              startStopSequenceNumber:
                  Get.parameters['startStopSequenceNumber'],
              endStopSequenceNumber: Get.parameters['endStopSequenceNumber'],
              startID: Get.parameters['startID'],
              endID: Get.parameters['endID'],
            )),
    GetPage(
        name: passengerDetails,
        page: () => PassengerDetails(
              sourceStopId: Get.parameters['sourceStopId'],
              destinationStopId: Get.parameters['destinationStopId'],
              routeCode: Get.parameters['routeCode'],
          serviceType: Get.parameters['serviceType'],
            )),
    GetPage(name: cardDetails, page: () => const CardDetailsScreen()),
    GetPage(
        name: nearBy,
        page: () => NearByScreen(
              stopType: Get.parameters['stopType'],
            )),
    GetPage(name: feedback, page: () => const FeedBackScreen()),
    GetPage(name: myRoute, page: () => const MyRoutesScreen()),
    GetPage(name: searchRoute, page: () => const SearchRouteNumberScreen()),
    GetPage(
        name: payment,
        page: () => PaymentDetailsScreen(
              sourceStopId: Get.parameters['sourceStopId'],
              destinationStopId: Get.parameters['destinationStopId'],
              discountype: Get.parameters['discountype'],
              txnStatus: Get.parameters['txnStatus'],
              merchantId: Get.parameters['merchantId'],
              sourcecompanycode: Get.parameters['sourcecompanycode'],
              destinationcompanycode: Get.parameters['destinationcompanycode'],
              routeCode: Get.parameters['routeCode'],
          serviceType: Get.parameters['serviceType'],
            )),
    GetPage(
        name: booking,
        page: () => BookingScreen(
              from: Get.parameters['from'],
            )),
    GetPage(name: forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: resetPassword, page: () => ResetPasswordScreen(
      number: Get.parameters['number'],
    )),
    GetPage(name: changeLanguage, page: () => const ChooseLanguage()),
    GetPage(
        name: nearbyMap,
        page: () => NearByMapsScreen(
              stopType: Get.parameters['stopType'],
            )),
    GetPage(name: transitMap, page: () => const TransitMapScreen()),
    GetPage(
        name: routeSearchTab,
        page: () => RouteTabScreen(
              title: Get.parameters['title'] ?? "",
              routeCode: Get.parameters['routeCode'] ?? "",
            )),
    GetPage(
        name: nearByStops,
        page: () => NearbyStopsScreen(
              title: Get.parameters['title'] ?? "",
              routeCode: Get.parameters['routeCode'] ?? "",
            )),
  ];
}
