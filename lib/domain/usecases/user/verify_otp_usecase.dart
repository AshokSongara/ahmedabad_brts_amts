import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/verify_otp_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class VerifyOtpUseCase implements UseCase<VerifyOtpResponse, Params> {
  final UserRepository userRepository;

  VerifyOtpUseCase(this.userRepository);

  @override
  Future<VerifyOtpResponse> call(Params params) {
    return userRepository.verifyOtp(params.data);
  }
}
