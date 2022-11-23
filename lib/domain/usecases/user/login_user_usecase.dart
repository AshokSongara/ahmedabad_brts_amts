import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class LoginUserUseCase implements UseCase<LoginResponse, Params> {
  final UserRepository userRepository;

  LoginUserUseCase(this.userRepository);

  @override
  Future<LoginResponse> call(Params params) {
    return userRepository.loginUser(params.data);
  }
}
