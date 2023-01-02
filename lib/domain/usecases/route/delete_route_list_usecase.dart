import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/delete_favourite_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class DeleteRouteListUseCase implements UseCase<DeleteFavouriteResponse, Params> {
  final RouteRepository routeRepository;

  DeleteRouteListUseCase(this.routeRepository);

  @override
  Future<DeleteFavouriteResponse> call(Params params) {
    return routeRepository.deleteRoute(params.data);
  }
}
