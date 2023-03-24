import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/one_day_pass_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class OneDayUseCase implements UseCase<OneDayPassResponse, Params> {
  final RouteRepository routeRepository;

  OneDayUseCase(this.routeRepository);

  @override
  Future<OneDayPassResponse> call(Params params) {
    return routeRepository.oneDayPass();
  }
}
