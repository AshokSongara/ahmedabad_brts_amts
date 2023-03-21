import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/profile_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/signup_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/PaymentInitResponseModel.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/booking_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/contactus_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_route_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/qr_code_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/verify_otp_response.dart';
import 'package:hive/hive.dart';

abstract class UserRepository {
  Future<SignUpResponse> signupUser(SignupRequest body);

  Future<LoginResponse> loginUser(dynamic body);

  Future<MobileNumberOtpResponseEntity> getOtp(
      MobileNumberOtpRequestParam body);

  Future<VerifyOtpResponse> verifyOtp(OtpRequest body);
  Future<FeedbackResponseModel> feedbackSubmit(dynamic body);
  Future<BrtsStopResponseModel> getStop(dynamic body);
  Future<ForgetPasswordResponse> forgetPassword(dynamic body);
  Box<BrtsStopResponseModel> getLocalBrtsStopData();
  Box<BrtsStopResponseModel> getLocalAmtsStopData();
  Future<BrtsRoutesResponseModel> getRoutes(body);
  Box<BrtsRoutesResponseModel> getLocalBrtsRoutesData();
  Box<BrtsRoutesResponseModel> getLocalAmtsRoutesData();
  Future<UserProfileResponse> getProfileData();
  Future<NotificationResponse> getNotificationsData();
  Future<ContactUsResponse> getContactDetails();
  Future<FavouriteRouteResponse> getFavouriteRouteListData();
  Future<QRCodeResponse> getQRCodeData();
  Future<UserProfileResponse> updateProfile(ProfileRequest body);
  Future<PaymentInitResponseModel> addTransaction(PaymentRequest body);
  Future<BookingListResponse> getBookingListData(String data);
}
