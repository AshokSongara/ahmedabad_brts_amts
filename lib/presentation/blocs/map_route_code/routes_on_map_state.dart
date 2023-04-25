import 'package:ahmedabad_brts_amts/data/responsemodels/routes_on_map_response.dart';

abstract class RoutesOnMapState {}

class RoutesOnMapInitialState extends RoutesOnMapState {}

class RoutesOnMapLoadingState extends RoutesOnMapState {}

class RoutesOnMapFailState extends RoutesOnMapState {}

class RoutesOnMapSuccessState extends RoutesOnMapState {
  RoutesOnMapResponse routesOnMapResponse;

  RoutesOnMapSuccessState({required this.routesOnMapResponse});
}
