import 'package:ahmedabad_brts_amts/presentation/pages/card_details/card_detail_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/route_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/enter_code_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/login_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/mobile_number_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/signup_screen.dart';
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

  static String getInitialRoute() => '$initial';

  static String getSplashRoute() => '$splash';

  static String getLoginRoute() => '$login';

  static String getSignUpRoute() => '$signup';

  static String getMobileNumberRoute() => '$mobileNumber';

  static String getEnterCodeRoute() => '$enterCode';

  static String getDashboardRoute() => '$dashboard';

  static String getSearchResultRoute() => '$searchResult';

  static String getRouteDetailsRoute() => '$routeDetails';

  static String getPassengerDetailsRoute() => '$passengerDetails';

  static String getCardDetailsRoute() => '$passengerDetails';

  static String getNearByRoute() => '$nearBy';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => SplashScreen()),
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: signup, page: () => SignupScreen()),
    GetPage(name: mobileNumber, page: () => MobileNumberScreen()),
    GetPage(name: enterCode, page: () => EnterCodeScreen()),
    GetPage(
        name: dashboard,
        page: () => DashboardScreen(
              pageIndex: 0,
            )),
    GetPage(name: searchResult, page: () => SearchResultScreen()),
    GetPage(name: routeDetails, page: () => RouteDetailScreen()),
    GetPage(name: passengerDetails, page: () => PassengerDetails()),
    GetPage(name: cardDetails, page: () => CardDetailsScreen()),
    GetPage(name: nearBy, page: () => NearByScreen()),
  ];
}
