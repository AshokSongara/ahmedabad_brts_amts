import 'package:ahmedabad_brts_amts/data/responsemodels/add_route_response.dart';

abstract class SearchRouteState {}

class SearchRouteInitialState extends SearchRouteState {}
class SearchRouteRemoveFavState extends SearchRouteState {}

class SearchRouteAddFavState extends SearchRouteState {
  AddRouteResponse response;

  SearchRouteAddFavState({required this.response});
}
class SearchRouteAddFavFailureState extends SearchRouteState {
  String message;

  SearchRouteAddFavFailureState({required this.message});
}
