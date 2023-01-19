import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/eta_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class RouteStopListUseCase implements UseCase<RouteStopListResponse, Params> {
  final RouteRepository routeRepository;

  RouteStopListUseCase(this.routeRepository);

  @override
  Future<RouteStopListResponse> call(Params params) {
    return routeRepository.getRouteStopList(params.data);
  }
}
