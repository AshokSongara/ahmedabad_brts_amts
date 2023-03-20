import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:equatable/equatable.dart';

abstract class SearchResultRouteState extends Equatable {
  const SearchResultRouteState();

  @override
  List<Object> get props => [];
}

class SearchResultRouteInitialState extends SearchResultRouteState {}

class SearchResultRouteLoadingState extends SearchResultRouteState {}

class SearchResultRouteSuccessState extends SearchResultRouteState {
  final SearchRouteResponse searchRouteResponse;
  final bool value;
  final bool error;

  const SearchResultRouteSuccessState({required this.searchRouteResponse,required this.value,required this.error});

  @override
  List<Object> get props => [searchRouteResponse,value,error];
}

class SearchResultRouteFailedState extends SearchResultRouteState {}
class SearchResultRouteFairLoadingState extends SearchResultRouteState {}

class AddFavouriteRouteLoadingState extends SearchResultRouteState {}

class AddFavouriteRouteSuccessState extends SearchResultRouteState {
  final AddFavouriteResponse addFavouriteResponse;

  AddFavouriteRouteSuccessState({required this.addFavouriteResponse});

  @override
  List<Object> get props => [addFavouriteResponse];
}

class AddFavouriteRouteFailedState extends SearchResultRouteState {}
