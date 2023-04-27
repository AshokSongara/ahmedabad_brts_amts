class AppConstant {
  static String apiUrl = "http://103.69.196.78:8082/";
  static String mapKey = "AIzaSyB-f76UEQUmRrsajG14qz2cobJCiVLTz3A";

  static String loginWithEmail = "Login with Email";
  static String loginWithMobile = "Login with Mobile Number";
  static String loginWithGuest = "Login as Guest";
  static String BrtsStopListBox = "BrtsStopListBox";
  static String AmtsStopListBox = "AmtsStopListBox";
  static String amtsRoutesListBox = "amtsRoutesListBox";
  static String brtsRoutesListBox = "brtsRoutesListBox";

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
  static String getRoutes = "Route/list/";
  static String searchRouteList = "Route/";
  static String forgetPassword = "User/GenerateOtpForforgot-password";
  static String changePassword = "User/ChangePassword";
  static String userProfile = "User/user-profile";
  static String updateProfile = "User/userprofile/update";
  static String notifications = "Notification/List";
  static String favouriteRouteList = "Favourite/GetByStop/";
  static String deleteFavouriteRoute = "Favourite/Delete/";
  static String addFavouriteRoute = "Favourite/";
  static String refreshToken = "User/refresh-token";
  static String transitMap = "http://103.69.196.78:8082/images/map.jpg";
 // static String routeDetails = "Route/201/stops/from/1/to/10";
  static String stopLists = "Route/stoplist/";
  //static String fareDetails = "fare/BRTS/201/startStop/57/endStop/62";
  //static String etaDetails = "eta/201/281";
  static String contactUs = "ContactUs";
  static String qrCodeData = "GenerateQRCode/9902000136200001";
  static String addTransaction = "AddTransaction";
  static String transactionList = "AddTransaction/list";
  static String transactionBookingList = "AddTransaction/booking";
  static String fareDiscount = "FareDiscount/Fixrate";
  static String discountRate = "FareDiscount/DiscountRate";
  static String fiservPG = "FiservPG";
  static String transactionTicket = "AddTransaction/Ticket";
  static String favouriteRoute = "Favourite/routeCode/";
  static String favouriteRouteListData = "Favourite/GetAllFavouritebyRoute";

  //SharedPreferences Keys
  static String accessToken = "accessToken";
  static String email = "email";
  static String name = "name";
  static String lastName = "lastname";

  static String IsLoggedIn = "";
  static String emailData = "";
  static String nameData = "";
  static String lastNameData = "";

  static LanguageList getLocaleType(String locale) {
    if (locale == "hi") {
      return LanguageList.hindi;
    } else if (locale == "en") {
      return LanguageList.english;
    } else if (locale == "gu") {
      return LanguageList.gujarati;
    } else {
      return LanguageList.gujarati;
    }
  }

}

enum LanguageList { gujarati, hindi, english }
