import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/signup_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/verify_otp_response.dart';

abstract class UserRepository {
  Future<SignUpResponse> signupUser(SignupRequest body);

  Future<LoginResponse> loginUser(dynamic body);

  Future<MobileNumberOtpResponseEntity> getOtp(
      MobileNumberOtpRequestParam body);

  Future<VerifyOtpResponse> verifyOtp(OtpRequest body);
}
