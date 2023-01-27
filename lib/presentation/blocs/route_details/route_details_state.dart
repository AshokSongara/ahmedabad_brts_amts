import 'package:ahmedabad_brts_amts/data/responsemodels/eta_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:equatable/equatable.dart';

abstract class RouteDetailsState extends Equatable {
  const RouteDetailsState();

  @override
  List<Object> get props => [];
}

class RouteDetailsInitialState extends RouteDetailsState {}

class RouteDetailsLoadingState extends RouteDetailsState {}

class RouteDetailsSuccessState extends RouteDetailsState {
  final RouteDetailsRepsonse routeDetailsResponse;
  final RouteDetailsRepsonse routeDetailsResponse1;
  final FareResponse fareResponse;
  final ETAResponse etaResponse;
  final RouteStopListResponse routeStopListResponse;

  const RouteDetailsSuccessState(
      {required this.routeDetailsResponse,
      required this.routeDetailsResponse1,
      required this.fareResponse,
      required this.etaResponse,
      required this.routeStopListResponse});

  @override
  List<Object> get props => [routeDetailsResponse,routeDetailsResponse1, fareResponse, etaResponse,routeStopListResponse];
}

class RouteDetailsFailedState extends RouteDetailsState {
  final String errorMessage;

  const RouteDetailsFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
