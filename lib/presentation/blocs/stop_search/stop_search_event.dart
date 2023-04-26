import 'package:ahmedabad_brts_amts/data/requestmodels/add_route_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:equatable/equatable.dart';

import '../../../data/requestmodels/route_details_request.dart';

abstract class StopSearchDetailsEvent extends Equatable {
  const StopSearchDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetStopSearchDetailsEvent extends StopSearchDetailsEvent {
  final RouteDetailsRequest request;

  GetStopSearchDetailsEvent({required this.request});

  @override
  List<Object> get props => [request];
}

class AddFavouriteRouteEvent extends StopSearchDetailsEvent {
  final AddRouteRequest request;
  final RouteStopListResponse routeStopListResponse;

  AddFavouriteRouteEvent({required this.request,required this.routeStopListResponse});

  @override
  List<Object> get props => [request,routeStopListResponse];
}
