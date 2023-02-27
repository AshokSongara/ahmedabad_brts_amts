
import '../../core/models/params.dart';
import '../../core/usecases/usecase.dart';
import '../../data/responsemodels/Nearby_stops_response_model.dart';
import '../repositories/routes/routes_repository.dart';

class NearByStopsUseCase implements UseCase<NearbyStopsResponseModel, Params> {
  final RouteRepository routeRepository;

  NearByStopsUseCase(this.routeRepository);

  @override
  Future<NearbyStopsResponseModel> call(Params params) {
    return routeRepository.nearbyStops(params.data);
  }
}