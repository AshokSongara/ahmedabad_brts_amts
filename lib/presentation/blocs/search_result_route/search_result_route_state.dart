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

  const SearchResultRouteSuccessState({required this.searchRouteResponse});

  @override
  List<Object> get props => [searchRouteResponse];
}

class SearchResultRouteFailedState extends SearchResultRouteState {}
