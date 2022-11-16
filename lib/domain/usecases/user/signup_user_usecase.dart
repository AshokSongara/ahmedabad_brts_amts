import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/models/login_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class SignupUserUseCase implements UseCase<LoginResponse, Params> {
  final UserRepository userRepository;

  SignupUserUseCase(this.userRepository);

  @override
  Future<LoginResponse> call(Params params) {
    return userRepository.registerUser(params.data);
  }
}

