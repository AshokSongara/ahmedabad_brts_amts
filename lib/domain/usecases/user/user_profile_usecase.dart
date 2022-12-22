import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class UserProfileUseCase implements UseCase<UserProfileResponse, Params> {
  final UserRepository userRepository;

  UserProfileUseCase(this.userRepository);

  @override
  Future<UserProfileResponse> call(Params params) {
    return userRepository.getProfileData();
  }
}
