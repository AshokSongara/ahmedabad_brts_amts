import 'package:ahmedabad_brts_amts/data/requestmodels/add_route_request.dart';

abstract class SearchRouteEvent {}
class SearchRouteFavoriteEvent extends SearchRouteEvent{
  AddRouteRequest request;
  bool status;
  SearchRouteFavoriteEvent({required this.request,required this.status});
}
