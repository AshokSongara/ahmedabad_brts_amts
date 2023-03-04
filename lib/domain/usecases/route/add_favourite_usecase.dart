import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';

import '../../../core/usecases/usecase.dart';

class AddFavouriteUseCase implements UseCase<AddFavouriteResponse, Params> {
  final RouteRepository routeRepository;

  AddFavouriteUseCase(this.routeRepository);

  @override
  Future<AddFavouriteResponse> call(Params params) {
    return routeRepository.addFavourite(params.data);
  }
}
