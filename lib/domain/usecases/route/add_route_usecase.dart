import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_route_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class AddRouteUseCase implements UseCase<AddRouteResponse, Params> {
  final RouteRepository routeRepository;

  AddRouteUseCase(this.routeRepository);

  @override
  Future<AddRouteResponse> call(Params params) {
    return routeRepository.addRoute(params.data);
  }
}
