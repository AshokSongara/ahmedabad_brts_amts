import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_route_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';

import '../../../core/usecases/usecase.dart';

class FavouriteRouteListUseCase implements UseCase<FavouriteRouteResponse, Params> {
  final UserRepository userRepository;

  FavouriteRouteListUseCase(this.userRepository);

  @override
  Future<FavouriteRouteResponse> call(Params params) {
    return userRepository.getFavouriteRouteListData(params.data);
  }
}
