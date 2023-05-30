import 'package:ahmedabad_brts_amts/data/responsemodels/delete_favourite_response.dart';
import 'package:equatable/equatable.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_routes_response_list.dart';

abstract class FavouriteRouteListState extends Equatable {
  const FavouriteRouteListState();

  @override
  List<Object> get props => [];
}

class FavouriteRouteInitialState extends FavouriteRouteListState {}

class FavouriteRouteLoadingState extends FavouriteRouteListState {}

class FavouriteRouteSuccessState extends FavouriteRouteListState {
  final FavouriteRoutesResponseList favouriteRouteResponse;

  const FavouriteRouteSuccessState({required this.favouriteRouteResponse});

  @override
  List<Object> get props => [favouriteRouteResponse];
}

class FavouriteDeleteRouteListSuccessState extends FavouriteRouteListState {
  final DeleteFavouriteResponse favouriteRouteResponse;

  const FavouriteDeleteRouteListSuccessState({required this.favouriteRouteResponse});

  @override
  List<Object> get props => [favouriteRouteResponse];
}

class FavouriteRouteFailedState extends FavouriteRouteListState {
  final String errorMessage;

  const FavouriteRouteFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
