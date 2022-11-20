import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class SignupUserUseCase implements UseCase<SignUpResponse, Params> {
  final UserRepository userRepository;

  SignupUserUseCase(this.userRepository);

  @override
  Future<SignUpResponse> call(Params params) {
    return userRepository.signupUser(params.data);
  }
}


