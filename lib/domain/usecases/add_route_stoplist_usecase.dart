import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';

import '../../../core/usecases/usecase.dart';

class AddRouteStopListUseCase implements UseCase<AddFavouriteResponse, Params> {
  final RouteRepository routeRepository;

  AddRouteStopListUseCase(this.routeRepository);

  @override
  Future<AddFavouriteResponse> call(Params params) {
    return routeRepository.addFavouriteRouteCode(params.data);
  }
}
