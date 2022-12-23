import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class NotificationUseCase implements UseCase<NotificationResponse, Params> {
  final UserRepository userRepository;

  NotificationUseCase(this.userRepository);

  @override
  Future<NotificationResponse> call(Params params) {
    return userRepository.getNotificationsData();
  }
}
