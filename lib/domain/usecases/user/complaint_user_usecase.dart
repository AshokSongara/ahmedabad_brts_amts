import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/core/usecases/usecase.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../data/responsemodels/complaint_response.dart';


class ComplaintUserUseCase implements UseCase<ComplaintResponseModel, Params> {
  final UserRepository userRepository;

  ComplaintUserUseCase(this.userRepository);

  @override
  Future<ComplaintResponseModel> call(Params params) {
    return userRepository.complaintUser(params.data);
  }
}