import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class NearmeRouteUseCase implements UseCase<NearMeResponse, Params> {
  final RouteRepository routeRepository;

  NearmeRouteUseCase(this.routeRepository);

  @override
  Future<NearMeResponse> call(Params params) {
    return routeRepository.nearMe(params.data);
  }
}
