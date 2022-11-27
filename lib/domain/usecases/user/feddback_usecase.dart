import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class FeedbackUseCase implements UseCase<FeedbackResponseModel, Params> {
  final UserRepository userRepository;

  FeedbackUseCase(this.userRepository);

  @override
  Future<FeedbackResponseModel> call(Params params) {
    return userRepository.feedbackSubmit(params.data);
  }
}