import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class FareUseCase implements UseCase<FareResponse, Params> {
  final RouteRepository routeRepository;

  FareUseCase(this.routeRepository);

  @override
  Future<FareResponse> call(Params params) {
    return routeRepository.getFareDetails(params.data);
  }
}
