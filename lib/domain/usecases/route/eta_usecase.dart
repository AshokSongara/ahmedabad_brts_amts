import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/eta_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class ETAUseCase implements UseCase<ETAResponse, Params> {
  final RouteRepository routeRepository;

  ETAUseCase(this.routeRepository);

  @override
  Future<ETAResponse> call(Params params) {
    return routeRepository.getETADetails(params.data);
  }
}
