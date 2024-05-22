import 'package:ahmedabad_brts_amts/presentation/pages/booking/booking_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/card_details/card_detail_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/contact_us/contact_us_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/home_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/failed_transaction/failes_transaction_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/maps/polyline_page.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/my_routes/my_routes_tab_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/payment_webview/payment_webview_screen.dart';
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
import 'package:ahmedabad_brts_amts/presentation/pages/ticket_details/ticket_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/transitmap/transitmap_screen.dart';
import 'package:get/get.dart';
import '../presentation/pages/dashboard/profile_screen.dart';
import '../presentation/pages/dashboard/search_result_screen.dart';
import '../presentation/pages/lrf/splash_screen.dart';
import '../presentation/pages/nearby_stops/nearby_stops_screen.dart';
import '../presentation/pages/search_route_number/route_tab_screen.dart';

class RouteHelper {
  static const String initial = '/';
  static const String splash = '/splash';
  static const String login = '/login';
  static const String profile = '/profile';
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
  static const String paymentWebview = '/paymentWebview';
  static const String ticket = '/ticket';
  static const String myRoutesTabScreen = '/myRoutesTabScreen';
  static const String polyLinePage = '/polyLinePage';
  static const String transactionStatus = '/transactionStatus';

  static String getInitialRoute() => initial;

  static String getSplashRoute() => splash;

  static String getLoginRoute() => login;

  static String getProfileRoute() => profile;

  static String getSignUpRoute(String type) => '$signup?type=$type';

  static String getMobileNumberRoute() => mobileNumber;

  static String getEnterCodeRoute(String mobileNumber) =>
      '$enterCode?mobile=$mobileNumber';

  static String getDashboardRoute() => dashboard;

  static String getpaymentWebviewRoute(String url) =>
      '$paymentWebview?url=$url';

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
      '$routeDetails?startRouteName=$startRouteName&startRouteCode=$startRouteCode&endRouteName=$endRouteName&endRouteCode=$endRouteCode&routeCode=$routeCode&startTime=$startTime&interChange=$interChange&fromHome=$fromHome&originStart=$originStart&originEnd=$originEnd&serviceType=$serviceType&interChangeName=$interChangeName&routeTwo=$routeTwo&startRouteTwo=$startRouteTwo&endRouteTwo=$endRouteTwo&endTime=$endTime&startStopSequenceNumber=$startStopSequenceNumber&endStopSequenceNumber=$endStopSequenceNumber&startID=$startID&endID=$endID';

  static String getPassengerDetailsRoute(String sourceStopId,
          String destinationStopId, String routeCode, String serviceType, String fare, String from) =>
      '$passengerDetails?sourceStopId=$sourceStopId&destinationStopId=$destinationStopId&routeCode=$routeCode&serviceType=$serviceType&fare=$fare&from=$from';

  static String getCardDetailsRoute() => cardDetails;

  static String getNearByRoute() => nearBy;

  static String getFeedbackRoute() => feedback;

  static String getMyRouteScreen(String serviceType) => '$myRoute?serviceType=$serviceType';

  static String getSearchRoute() => searchRoute;

  static String getoneDayPassRoute(String sourceStationID,String serviceType) =>
      "$oneDayPassRoute?sourceStationID=$sourceStationID&serviceType=$serviceType";

  static String getContactUsRoute() => contactUs;

  static String getPaymentDetailsRoute(
          String sourceStopId,
          String destinationStopId,
          String discountype,
          String txnStatus,
          String merchantId,
          String sourcecompanycode,
          String destinationcompanycode,
          String routeCode,
          String serviceType,
      String type) =>
      '$payment?sourceStopId=$sourceStopId&destinationStopId=$destinationStopId&discountype=$discountype&txnStatus=$txnStatus&merchantId=$merchantId&sourcecompanycode=$sourcecompanycode&destinationcompanycode=$destinationcompanycode&routeCode=$routeCode&serviceType=$serviceType&type=$type';

  static String getBookingRoute(String from) => '$booking?from=$from';

  static String getForgetPasswordRoute() => forgetPassword;

  static String getResetPasswordRoute(String number) =>
      '$resetPassword?number=$number';

  static String getSearchStopScreenRoute(String selectedLanguage, String stopType) =>
      '$searchStopScreen?selectedLanguage=$selectedLanguage&stopType=$stopType';

  static String getSearchRouteScreenRoute(String selectedLanguage, String from,String stopType) =>
      '$searchRouteScreen?selectedLanguage=$selectedLanguage&from=$from&stopType=$stopType';

  static String getNearBySearchStopScreenRoute() => nearBySearchStopScreen;

  static String getChangeLangaugeScreenRoute() => changeLanguage;

  static String getNearByMapScreenRoute(String stopType) =>
      '$nearbyMap?stopType=$stopType';

  static String getTransitMapScreenRoute() => transitMap;

  static String getNearByStops(String title, String routeCode,String serviceType, String from) =>
      '$nearByStops?title=$title&routeCode=$routeCode&serviceType=$serviceType&from=$from';

  static String getRouteSearchTab(String title, String routeCode,String serviceType, String from) =>
      '$routeSearchTab?title=$title&routeCode=$routeCode&serviceType=$serviceType&from=$from';

  static String getRouteTicket(String ticketNumber) =>
      '$ticket?ticketNumber=$ticketNumber';

  static String getTransactionStatusRoute() => transactionStatus;

  static String getPolyLinePageRoute(String routeCode) =>
      '$polyLinePage?routeCode=$routeCode';

  static String getMyRoutesTabScreenRoute(String serviceType, String from) => '$myRoutesTabScreen?serviceType=$serviceType&from=$from';

  static List<GetPage> routes = [
    GetPage(
        name: paymentWebview,
        page: () => WebViewScreen(
              url: Get.parameters['url'],
            )),
    GetPage(
        name: ticket,
        page: () => TicketDetailsScreen(
              ticketNumber: Get.parameters['ticketNumber'],
            )),
    GetPage(name: initial, page: () => const SplashScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
    ),
    GetPage(
        name: polyLinePage,
        page: () => PolylinePage(
              routeCode: Get.parameters['routeCode'],
            )),
    GetPage(name: myRoutesTabScreen, page: () => MyRoutesTabScreen(serviceType: Get.parameters['serviceType'] ?? "", from: Get.parameters['from'] ?? "",)),
    GetPage(
        name: transactionStatus, page: () => const FailedTransactionScreen()),
    GetPage(
        name: signup,
        page: () => SignupScreen(
              type: Get.parameters['type'],
            )),
    GetPage(name: mobileNumber, page: () => const MobileNumberScreen()),
    GetPage(
        name: oneDayPassRoute,
        page: () => OneDayPassScreen(
              sourceStationID: Get.parameters['sourceStationID'],
              serviceType: Get.parameters['serviceType'],
            )),
    GetPage(name: contactUs, page: () => const ContactUsScreen()),
    GetPage(
        name: searchStopScreen,
        page: () => SearchStopScreen(
            selectedLanguage: Get.parameters['selectedLanguage'] ?? "",
            stopType: Get.parameters['stopType'] ?? "")),
    GetPage(
        name: nearBySearchStopScreen,
        page: () => const NearBySearchStopScreen()),
    GetPage(
        name: searchRouteScreen,
        page: () => SearchRouteScreen(
              selectedLanguage: Get.parameters['selectedLanguage'],
              from: Get.parameters['from'],
              stopType: Get.parameters['stopType'],
            )),
    GetPage(
        name: enterCode,
        page: () => OtpVerificationScreen(
              mobileNumber: Get.parameters['mobile'],
            )),
    GetPage(
        name: dashboard,
        page: () => HomeScreen(
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
              fare: Get.parameters['fare'],
              from: Get.parameters['from'],
            )),
    GetPage(name: cardDetails, page: () => const CardDetailsScreen()),
    GetPage(
        name: nearBy,
        page: () => NearByScreen(
              stopType: Get.parameters['stopType'],
            )),
    GetPage(name: feedback, page: () => const FeedBackScreen()),
    GetPage(name: myRoute, page: () => MyRoutesScreen(serviceType: Get.parameters['serviceType'] ?? "",)),
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
              type: Get.parameters['type'],
            )),
    GetPage(
        name: booking,
        page: () => BookingScreen(
              from: Get.parameters['from'],
            )),
    GetPage(name: forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(
        name: resetPassword,
        page: () => ResetPasswordScreen(
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
          serviceType: Get.parameters['serviceType'] ?? "",
          from: Get.parameters['from'] ?? "",
            )),
    GetPage(
        name: nearByStops,
        page: () => NearbyStopsScreen(
              title: Get.parameters['title'] ?? "",
              routeCode: Get.parameters['routeCode'] ?? "",
          serviceType: Get.parameters['serviceType'] ?? "",
          from: Get.parameters['from'] ?? "",
            )),
  ];
}
