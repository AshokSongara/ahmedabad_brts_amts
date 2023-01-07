import 'package:ahmedabad_brts_amts/data/requestmodels/login_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:equatable/equatable.dart';

abstract class RouteDetailsEvent extends Equatable {
  const RouteDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetRouteDetailsEvent extends RouteDetailsEvent {
  final RouteDetailsRequest request;

  GetRouteDetailsEvent({required this.request});

  @override
  List<Object> get props => [request];
}
