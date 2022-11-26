import 'package:ahmedabad_brts_amts/presentation/pages/card_details/card_detail_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/route_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/feedback/feedback_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/otp_verification_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/login_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/mobile_number_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/signup_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/my_routes/my_routes_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/nearby/nearby_sreen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/passenger_details/passenger_details.dart';
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

  static String getInitialRoute() => '$initial';

  static String getSplashRoute() => '$splash';

  static String getLoginRoute() => '$login';

  static String getSignUpRoute() => '$signup';

  static String getMobileNumberRoute() => '$mobileNumber';

  static String getEnterCodeRoute(String mobileNumber) =>
      '$enterCode?mobile=$mobileNumber';

  static String getDashboardRoute() => '$dashboard';

  static String getSearchResultRoute() => '$searchResult';

  static String getRouteDetailsRoute() => '$routeDetails';

  static String getPassengerDetailsRoute() => '$passengerDetails';

  static String getCardDetailsRoute() => '$passengerDetails';

  static String getNearByRoute() => '$nearBy';

  static String getFeedbackRoute() => '$feedback';

  static String getMyRouteScreen() => '$myRoute';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: signup, page: () => const SignupScreen()),
    GetPage(name: mobileNumber, page: () => const MobileNumberScreen()),
    GetPage(
        name: enterCode,
        page: () => OtpVerificationScreen(
              mobileNumber: Get.parameters['mobileNumber'],
            )),
    GetPage(
        name: dashboard,
        page: () => DashboardScreen(
              pageIndex: 0,
            )),
    GetPage(name: searchResult, page: () => const SearchResultScreen()),
    GetPage(name: routeDetails, page: () => const RouteDetailScreen()),
    GetPage(name: passengerDetails, page: () => const PassengerDetails()),
    GetPage(name: cardDetails, page: () => const CardDetailsScreen()),
    GetPage(name: nearBy, page: () => const NearByScreen()),
    GetPage(name: feedback, page: () => const FeedBackScreen()),
    GetPage(name: myRoute, page: () => const MyRoutesScreen()),
  ];
}
