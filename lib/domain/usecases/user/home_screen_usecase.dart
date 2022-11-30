import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/core/usecases/usecase.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/stop_response_model.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

class HomeScreenUseCase implements UseCase<StopResponseModel, Params> {
  final UserRepository userRepository;

  HomeScreenUseCase(this.userRepository);

  @override
  Future<StopResponseModel> call(Params params) {
    return userRepository.getStop(params.data);
  }
}