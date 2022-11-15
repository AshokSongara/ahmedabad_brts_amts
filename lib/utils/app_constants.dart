import '../presentation/widgets/base/order_tracker.dart';

class AppConstant {

  static String tarakKey = "fgnmnbvcfghjuy2345678ikjhgfd";
  static String apiUrl = "http://api.sowindia.in/api/";
  static String mapKey = "AIzaSyB-f76UEQUmRrsajG14qz2cobJCiVLTz3A";

  static String loginWithEmail = "Login with Email";
  static String loginWithMobile = "Login with Mobile Number";
  static String loginWithGuest = "Login as Guest";

  //Login Register End Points
  static String registerInterface = "RegistrationCustomer";
  static String loginInterface = "LoginWithOTPCustomer";
  static String checkAppVersionInterface = "Check_App_Version";
  static String resendOtpInterface = "ReSendOTPCustomer";
  static String updateFirebaseInterface = "UpdateCustomer_Firebaseid";


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
