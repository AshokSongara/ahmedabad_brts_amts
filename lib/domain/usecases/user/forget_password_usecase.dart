import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class ForgetPasswordUseCase implements UseCase<ForgetPasswordResponse, Params> {
  final UserRepository userRepository;

  ForgetPasswordUseCase(this.userRepository);

  @override
  Future<ForgetPasswordResponse> call(Params params) {
    return userRepository.forgetPassword(params.data);
  }
}
