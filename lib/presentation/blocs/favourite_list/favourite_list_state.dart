import 'package:ahmedabad_brts_amts/data/responsemodels/delete_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_route_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:equatable/equatable.dart';

abstract class FavouriteRouteListState extends Equatable {
  const FavouriteRouteListState();

  @override
  List<Object> get props => [];
}

class FavouriteRouteInitialState extends FavouriteRouteListState {}

class FavouriteRouteLoadingState extends FavouriteRouteListState {}

class FavouriteRouteSuccessState extends FavouriteRouteListState {
  final FavouriteRouteResponse favouriteRouteResponse;

  FavouriteRouteSuccessState({required this.favouriteRouteResponse});

  @override
  List<Object> get props => [favouriteRouteResponse];
}

class FavouriteDeleteRouteSuccessState extends FavouriteRouteListState {
  final DeleteFavouriteResponse favouriteRouteResponse;

  FavouriteDeleteRouteSuccessState({required this.favouriteRouteResponse});

  @override
  List<Object> get props => [favouriteRouteResponse];
}

class FavouriteRouteFailedState extends FavouriteRouteListState {
  final String errorMessage;

  FavouriteRouteFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
