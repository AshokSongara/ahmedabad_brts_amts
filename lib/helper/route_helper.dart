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

  static String getInitialRoute() => '$initial';

  static String getSplashRoute() => '$splash';

  static String getLoginRoute() => '$login';

  static String getSignUpRoute() => '$signup';

  static String getMobileNumberRoute() => '$mobileNumber';

  static String getEnterCodeRoute(String mobileNumber) =>
      '$enterCode?mobile=$mobileNumber';

  static String getDashboardRoute() => '$dashboard';

  static String getSearchResultRoute(String startRoute, String endRoute,
          String startRouteName, String endRouteName) =>
      '$searchResult?startRoute=$startRoute&endRoute=$endRoute&startRouteName=$startRouteName&endRouteName=$endRouteName';

  static String getRouteDetailsRoute(
          String startRouteName,
          String startRouteCode,
          String endRouteName,
          String endRouteCode,
          String routeCode) =>
      '$routeDetails?startRouteName=$startRouteName&startRouteCode=$startRouteCode&endRouteName=$endRouteName&endRouteCode=$endRouteCode&routeCode=$routeCode';

  static String getPassengerDetailsRoute() => '$passengerDetails';

  static String getCardDetailsRoute() => '$cardDetails';

  static String getNearByRoute() => '$nearBy';

  static String getFeedbackRoute() => '$feedback';

  static String getMyRouteScreen() => '$myRoute';

  static String getSearchRoute() => '$searchRoute';

  static String getoneDayPassRoute() => '$oneDayPassRoute';

  static String getContactUsRoute() => '$contactUs';

  static String getPaymentDetailsRoute() => '$payment';

  static String getBookingRoute(String from) => '$booking?from=$from';

  static String getForgetPasswordRoute() => '$forgetPassword';

  static String getResetPasswordRoute() => '$resetPassword';

  static String getSearchStopScreenRoute(String selectedLanguage) =>
      '$searchStopScreen?selectedLanguage=$selectedLanguage';

  static String getSearchRouteScreenRoute(String selectedLanguage) =>
      '$searchRouteScreen?selectedLanguage=$selectedLanguage';

  static String getNearBySearchStopScreenRoute() => '$nearBySearchStopScreen';

  static String getChangeLangaugeScreenRoute() => '$changeLanguage';

  static String getNearByMapScreenRoute() => '$nearbyMap';

  static String getTransitMapScreenRoute() => '$transitMap';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
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
            )),
    GetPage(
        name: routeDetails,
        page: () => RouteDetailScreen(
              startRouteName: Get.parameters['startRouteName'],
              startRouteCode: Get.parameters['startRouteCode'],
              endRouteName: Get.parameters['endRouteName'],
              endRouteCode: Get.parameters['endRouteCode'],
              routeCode: Get.parameters['routeCode'],
            )),
    GetPage(name: passengerDetails, page: () => const PassengerDetails()),
    GetPage(name: cardDetails, page: () => const CardDetailsScreen()),
    GetPage(name: nearBy, page: () => const NearByScreen()),
    GetPage(name: feedback, page: () => const FeedBackScreen()),
    GetPage(name: myRoute, page: () => const MyRoutesScreen()),
    GetPage(name: searchRoute, page: () => const SearchRouteNumberScreen()),
    GetPage(name: payment, page: () => const PaymentDetailsScreen()),
    GetPage(
        name: booking,
        page: () => BookingScreen(
              from: Get.parameters['from'],
            )),
    GetPage(name: forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(name: resetPassword, page: () => const ResetPasswordScreen()),
    GetPage(name: changeLanguage, page: () => const ChooseLanguage()),
    GetPage(name: nearbyMap, page: () => const NearByMapsScreen()),
    GetPage(name: transitMap, page: () => const TransitMapScreen())
  ];
}
