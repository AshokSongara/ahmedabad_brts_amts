import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
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
  final bool value;
  final bool error;

  const StopSearchSuccessState({required this.routeStopListResponse,required this.value,required this.error});

  @override
  List<Object> get props => [routeStopListResponse,value,error];
}

class StopSearchFailedState extends StopSearchDetailsState {
  final String errorMessage;

  const StopSearchFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AddFavouriteRouteLoadingState extends StopSearchDetailsState {}

class AddFavouriteRouteSuccessState extends StopSearchDetailsState {
  final AddFavouriteResponse addFavouriteResponse;

  AddFavouriteRouteSuccessState({required this.addFavouriteResponse});

  @override
  List<Object> get props => [addFavouriteResponse];
}

class AddFavouriteRouteFailedState extends StopSearchDetailsState {
  final String title;

  AddFavouriteRouteFailedState({required this.title});

  @override
  List<Object> get props => [title];
}
