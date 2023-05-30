import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/core/usecases/usecase.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

class ComplaintGetRoutesUseCase implements UseCase<BrtsRoutesResponseModel, Params>{
  final UserRepository userRepository;
  ComplaintGetRoutesUseCase(this.userRepository);
  @override
  Future<BrtsRoutesResponseModel> call(Params params) {
    return userRepository.getRoutes(params.data);
  }

}