
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_routes_response_list.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class FavouriteRouteListDataUseCase implements UseCase<FavouriteRoutesResponseList, Params> {
  final UserRepository userRepository;

  FavouriteRouteListDataUseCase(this.userRepository);

  @override
  Future<FavouriteRoutesResponseList> call(Params params) {
    return userRepository.getFavouriteRouteData(params.data);
  }
}
