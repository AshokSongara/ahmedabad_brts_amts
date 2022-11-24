import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';

abstract class MobileNumberLoginRepository {
  Future<MobileNumberOtpResponseEntity> getOtp(MobileNumberOtpRequestParam body);
}
