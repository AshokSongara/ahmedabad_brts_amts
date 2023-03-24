import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/discount_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class DiscountUseCase implements UseCase<DiscountResponse, Params> {
  final RouteRepository routeRepository;

  DiscountUseCase(this.routeRepository);

  @override
  Future<DiscountResponse> call(Params params) {
    return routeRepository.discount();
  }
}
