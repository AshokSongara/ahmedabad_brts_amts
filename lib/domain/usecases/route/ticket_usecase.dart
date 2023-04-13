import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/ticket_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';
import '../../../data/responsemodels/PaymentInitResponseModel.dart';

class TicketUseCase implements UseCase<TicketResponse, Params> {
  final UserRepository userRepository;

  TicketUseCase(this.userRepository);

  @override
  Future<TicketResponse> call(Params params) {
    return userRepository.ticketData(params.data);
  }
}
