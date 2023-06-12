import 'package:ahmedabad_brts_amts/data/requestmodels/add_route_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:equatable/equatable.dart';

abstract class OnTapSearchBusRouteDetailsEvent extends Equatable {
  const OnTapSearchBusRouteDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetOnTapSearchBusRouteDetailsEvent extends OnTapSearchBusRouteDetailsEvent {
  final RouteDetailsRequest request;

  GetOnTapSearchBusRouteDetailsEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class AddFavouriteRouteEvent extends OnTapSearchBusRouteDetailsEvent {
  final AddRouteRequest request;
  final RouteStopListResponse routeStopListResponse;

  AddFavouriteRouteEvent({required this.request,required this.routeStopListResponse});

  @override
  List<Object> get props => [request,routeStopListResponse];
}