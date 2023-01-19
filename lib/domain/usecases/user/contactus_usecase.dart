import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/contactus_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class ContactUsUseCase implements UseCase<ContactUsResponse, Params> {
  final UserRepository userRepository;

  ContactUsUseCase(this.userRepository);

  @override
  Future<ContactUsResponse> call(Params params) {
    return userRepository.getContactDetails();
  }
}
