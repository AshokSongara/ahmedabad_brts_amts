import 'package:ahmedabad_brts_amts/data/responsemodels/eta_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:equatable/equatable.dart';

abstract class RouteDetailsState extends Equatable {
  const RouteDetailsState();

  @override
  List<Object> get props => [];
}

class RouteDetailsInitialState extends RouteDetailsState {}

class RouteDetailsLoadingState extends RouteDetailsState {}

class RouteDetailsSuccessState extends RouteDetailsState {
  final RouteDetailsRepsonse routeDetailsRepsonse;
  final FareResponse fareResponse;
  final ETAResponse etaResponse;

  const RouteDetailsSuccessState(
      {required this.routeDetailsRepsonse,
      required this.fareResponse,
      required this.etaResponse});

  @override
  List<Object> get props => [routeDetailsRepsonse, fareResponse, etaResponse];
}

class RouteDetailsFailedState extends RouteDetailsState {
  final String errorMessage;

  const RouteDetailsFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
