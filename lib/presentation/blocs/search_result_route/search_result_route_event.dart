import 'package:ahmedabad_brts_amts/data/requestmodels/add_favourite_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/search_route_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:equatable/equatable.dart';

abstract class SearchResultRouteEvent extends Equatable {
  const SearchResultRouteEvent();

  @override
  List<Object> get props => [];
}

class GetSearchResultRouteEvent extends SearchResultRouteEvent {
  final SearchRouteRequest searchRouteRequest;
  const GetSearchResultRouteEvent({required this.searchRouteRequest});

  @override
  List<Object> get props => [searchRouteRequest];
}

class AddFavouriteRouteEvent extends SearchResultRouteEvent {
  final AddFavouriteRequest addFavouriteRequest;
  final SearchRouteResponse searchRouteResponse;

  AddFavouriteRouteEvent({required this.addFavouriteRequest,required this.searchRouteResponse});

  @override
  List<Object> get props => [addFavouriteRequest,searchRouteResponse];
}