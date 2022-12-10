import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class SearchResultRouteUseCase implements UseCase<SearchRouteResponse, Params> {
  final RouteRepository routeRepository;

  SearchResultRouteUseCase(this.routeRepository);

  @override
  Future<SearchRouteResponse> call(Params params) {
    return routeRepository.searchResultRoute(params.data);
  }
}
