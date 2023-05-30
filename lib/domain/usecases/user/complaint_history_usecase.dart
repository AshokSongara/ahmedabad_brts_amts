import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/core/usecases/usecase.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/complaint_history_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

class ComplaintHistoryUseCase implements UseCase<ComplaintHistoryResponse, Params> {
  final UserRepository userRepository;

  ComplaintHistoryUseCase(this.userRepository);

  @override
  Future<ComplaintHistoryResponse> call(Params params) {
    return userRepository.getComplaintHistoryData(params.data);
  }
}
