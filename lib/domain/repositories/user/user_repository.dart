import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/signup_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/stop_response_model.dart';
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
}
