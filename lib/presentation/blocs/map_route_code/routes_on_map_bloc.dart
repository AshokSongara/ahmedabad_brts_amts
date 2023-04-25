import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/routes_on_map_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/routes_on_map_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/map_route_code/routes_on_map_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/map_route_code/routes_on_map_state.dart';

class RoutesOnMapBloc extends Bloc<RoutesOnMapEvent, RoutesOnMapState> {
  RoutesOnMapBloc({required this.routeOnMapUseCase})
      : super(RoutesOnMapInitialState());

  final RouteOnMapUseCase routeOnMapUseCase;

  @override
  Stream<RoutesOnMapState> mapEventToState(RoutesOnMapEvent event) async* {
    if (event is RoutesOnMapRouteEvent) {
      yield RoutesOnMapLoadingState();
      RoutesOnMapResponse nearMeResponse =
          await routeOnMapUseCase(Params(data: event.routeCode));
      if (nearMeResponse.succeeded == true) {
        yield RoutesOnMapSuccessState(routesOnMapResponse: nearMeResponse);
      } else {
        yield RoutesOnMapFailState();
      }
    }
  }
}
