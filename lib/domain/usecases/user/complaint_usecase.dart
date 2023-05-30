import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/core/usecases/usecase.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

class ComplaintGetStopUseCase implements UseCase<BrtsStopResponseModel, Params>{
  final UserRepository userRepository;

  ComplaintGetStopUseCase(this.userRepository);

  @override
  Future<BrtsStopResponseModel> call(Params params) {
    return userRepository.getStop(params.data);
  }
}