import 'package:ahmedabad_brts_amts/data/requestmodels/add_route_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:equatable/equatable.dart';

abstract class OnTapDetailsEvent extends Equatable {
  const OnTapDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetOnTapDetailsEvent extends OnTapDetailsEvent {
  final RouteDetailsRequest request;

  GetOnTapDetailsEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class AddFavouriteRouteEvent extends OnTapDetailsEvent {
  final AddRouteRequest request;
  final RouteStopListResponse routeStopListResponse;

  AddFavouriteRouteEvent({required this.request,required this.routeStopListResponse});

  @override
  List<Object> get props => [request,routeStopListResponse];
}