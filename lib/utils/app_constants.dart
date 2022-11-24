import '../presentation/widgets/base/order_tracker.dart';

class AppConstant {

  static String apiUrl = "http://103.69.196.78:8082/";
  static String mapKey = "AIzaSyB-f76UEQUmRrsajG14qz2cobJCiVLTz3A";

  static String loginWithEmail = "Login with Email";
  static String loginWithMobile = "Login with Mobile Number";
  static String loginWithGuest = "Login as Guest";

  //TODO Remove
  // 1) http://localhost:5000/User/otp/generate
  // 2) http://localhost:5000/User/sign-in/otp
  // 3) http://localhost:5000/User/{userId}/activate/{activate}
  // 4) http://localhost:5000/User
  // 5) http://localhost:5000/User/{userId}
  // 6) http://localhost:5000/User/{userId}
  // 7) http://localhost:5000/User/{userId}
  // 8) http://localhost:5000/User/{userId}/confirm-email
  // 9) http://localhost:5000/User/forgot-password
  // 10) http://localhost:5000/User/reset-password
  // 11) http://localhost:5000/User/search
  // 12) http://localhost:5000/User/sign-in
  // 13) http://localhost:5000/User/sign-out
  // 14) http://localhost:5000/User/{userId}/unlock
  // 15) http://localhost:5000/User/refresh-token
  // 15) http://localhost:5000/NearMe
  //Login Register End Points

  //APIs End Points
  static String registerInterface = "User";
  static String loginInterface = "User/sign-in";
  static String checkAppVersionInterface = "Check_App_Version";
  static String resendOtpInterface = "ReSendOTPCustomer";
  static String updateFirebaseInterface = "UpdateCustomer_Firebaseid";
  static String userOtp = "User/otp/generate";


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
