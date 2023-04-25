import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/routes_on_map_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class RouteOnMapUseCase implements UseCase<RoutesOnMapResponse, Params> {
  final RouteRepository routeRepository;

  RouteOnMapUseCase(this.routeRepository);

  @override
  Future<RoutesOnMapResponse> call(Params params) {
    return routeRepository.routesOnMap(params.data);
  }
}
