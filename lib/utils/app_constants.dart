import '../presentation/widgets/base/order_tracker.dart';

class AppConstant {

  static String apiUrl = "http://103.69.196.78:8082/";
  static String mapKey = "AIzaSyB-f76UEQUmRrsajG14qz2cobJCiVLTz3A";

  static String loginWithEmail = "Login with Email";
  static String loginWithMobile = "Login with Mobile Number";
  static String loginWithGuest = "Login as Guest";
  static String BrtsStopListBox = "BrtsStopListBox";
  static String AmtsStopListBox = "AmtsStopListBox";

  //APIs End Points
  static String registerInterface = "User";
  static String loginInterface = "User/sign-in";
  static String checkAppVersionInterface = "Check_App_Version";
  static String resendOtpInterface = "ReSendOTPCustomer";
  static String updateFirebaseInterface = "UpdateCustomer_Firebaseid";
  static String userOtp = "User/otp/generate";
  static String verifyOtp = "User/sign-in/otp";
  static String nearMeInterface = "NearMe";
  static String submitFeedback = "Feedback";
  static String getStops = "Stop/list/";


  //SharedPreferences Keys
  static String accessToken = "accessToken";
  static String email = "email";

  static List<TextDto> orderList = [
    TextDto("Your order has been placed", "+ 11 Stops"),
  ];

  static List<TextDto> shippedList = [
    TextDto("Your order has been shipped", "+ 11 Stops"),
    TextDto("Your item has been received in the nearest hub to you.", null),
  ];

  static List<TextDto> outOfDeliveryList = [
    TextDto("Your order is out for delivery", "+ 11 Stops"),
  ];

  static List<TextDto> deliveredList = [
    TextDto("Your order has been delivered", "+ 11 Stops"),
  ];

}
