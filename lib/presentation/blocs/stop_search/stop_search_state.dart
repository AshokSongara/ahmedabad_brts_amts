import 'package:equatable/equatable.dart';

import '../../../data/responsemodels/route_stoplist_response.dart';

abstract class StopSearchDetailsState extends Equatable {
  const StopSearchDetailsState();

  @override
  List<Object> get props => [];
}

class StopSearchDetailsInitialState extends StopSearchDetailsState {}

class StopSearchDetailsLoadingState extends StopSearchDetailsState {}

class StopSearchSuccessState extends StopSearchDetailsState {
  final RouteStopListResponse routeStopListResponse;

  const StopSearchSuccessState({required this.routeStopListResponse});

  @override
  List<Object> get props => [routeStopListResponse];
}

class StopSearchFailedState extends StopSearchDetailsState {
  final String errorMessage;

  const StopSearchFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
