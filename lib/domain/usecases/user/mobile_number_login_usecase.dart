import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class MobileNumberLoginUseCase implements UseCase<MobileNumberOtpResponseEntity, MobileNumberOtpRequestParam> {
  final UserRepository repo;

  MobileNumberLoginUseCase(this.repo);

  @override
  Future<MobileNumberOtpResponseEntity> call(MobileNumberOtpRequestParam params) {
    return repo.getOtp(params);
  }
}
