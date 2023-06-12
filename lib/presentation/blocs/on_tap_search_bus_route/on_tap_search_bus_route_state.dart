import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:equatable/equatable.dart';

abstract class OnTapSearchBusRouteDetailsState extends Equatable {
  const OnTapSearchBusRouteDetailsState();

  @override
  List<Object> get props => [];
}

class OnTapSearchBusRouteDetailsInitialState extends OnTapSearchBusRouteDetailsState {}

class OnTapSearchBusRouteDetailsLoadingState extends OnTapSearchBusRouteDetailsState {}

class OnTapSearchBusRouteSuccessState extends OnTapSearchBusRouteDetailsState {
  final RouteStopListResponse routeStopListResponse;
  final bool value;
  final bool error;

  const OnTapSearchBusRouteSuccessState({required this.routeStopListResponse,required this.value,required this.error});

  @override
  List<Object> get props => [routeStopListResponse,value,error];
}

class OnTapSearchBusRouteFailedState extends OnTapSearchBusRouteDetailsState {
  final String errorMessage;

  const OnTapSearchBusRouteFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AddFavouriteRouteLoadingState extends OnTapSearchBusRouteDetailsState {}

class AddFavouriteRouteSuccessState extends OnTapSearchBusRouteDetailsState {
  final AddFavouriteResponse addFavouriteResponse;

  AddFavouriteRouteSuccessState({required this.addFavouriteResponse});

  @override
  List<Object> get props => [addFavouriteResponse];
}

class AddFavouriteRouteFailedState extends OnTapSearchBusRouteDetailsState {
  final String title;

  AddFavouriteRouteFailedState({required this.title});

  @override
  List<Object> get props => [title];
}