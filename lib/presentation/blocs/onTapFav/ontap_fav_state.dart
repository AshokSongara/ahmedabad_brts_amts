import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:equatable/equatable.dart';

abstract class OnTapFavDetailsState extends Equatable {
  const OnTapFavDetailsState();

  @override
  List<Object> get props => [];
}

class OnTapFavDetailsInitialState extends OnTapFavDetailsState {}

class OnTapFavDetailsLoadingState extends OnTapFavDetailsState {}

class OnTapFavSuccessState extends OnTapFavDetailsState {
  final RouteStopListResponse routeStopListResponse;
  final bool value;
  final bool error;

  const OnTapFavSuccessState({required this.routeStopListResponse,required this.value,required this.error});

  @override
  List<Object> get props => [routeStopListResponse,value,error];
}

class OnTapFavFailedState extends OnTapFavDetailsState {
  final String errorMessage;

  const OnTapFavFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class AddFavouriteRouteLoadingState extends OnTapFavDetailsState {}

class AddFavouriteRouteSuccessState extends OnTapFavDetailsState {
  final AddFavouriteResponse addFavouriteResponse;

  AddFavouriteRouteSuccessState({required this.addFavouriteResponse});

  @override
  List<Object> get props => [addFavouriteResponse];
}

class AddFavouriteRouteFailedState extends OnTapFavDetailsState {
  final String title;

  AddFavouriteRouteFailedState({required this.title});

  @override
  List<Object> get props => [title];
}