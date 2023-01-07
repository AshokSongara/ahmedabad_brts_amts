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

  const RouteDetailsSuccessState({required this.routeDetailsRepsonse});

  @override
  List<Object> get props => [routeDetailsRepsonse];
}

class RouteDetailsFailedState extends RouteDetailsState {
  final String errorMessage;

  const RouteDetailsFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
