import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/mobile_number_login_repository.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileNumberLoginRepositoryImpl implements MobileNumberLoginRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  MobileNumberLoginRepositoryImpl(
      {required this.apiClient, required this.sharedPreferences});

  @override
  Future<MobileNumberOtpResponseEntity> getOtp(
      MobileNumberOtpRequestParam body) async {
    Response response = await apiClient.postData(
        AppConstant.userOtp, body.toJson().toString());
    MobileNumberOtpResponseEntity mobileNumberOtpResponseEntity =
        MobileNumberOtpResponseEntity.fromJson(response.body);

    try {} on Exception catch (exception) {
    } catch (error) {}
    return mobileNumberOtpResponseEntity;
  }
}
