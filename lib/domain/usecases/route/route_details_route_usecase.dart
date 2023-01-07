import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class RouteDetailsUseCase implements UseCase<RouteDetailsRepsonse, Params> {
  final RouteRepository routeRepository;

  RouteDetailsUseCase(this.routeRepository);

  @override
  Future<RouteDetailsRepsonse> call(Params params) {
    return routeRepository.getRouteDetails(params.data);
  }
}
