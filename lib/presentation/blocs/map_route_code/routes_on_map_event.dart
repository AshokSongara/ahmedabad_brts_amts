import 'package:equatable/equatable.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';

abstract class RoutesOnMapEvent extends Equatable {
  const RoutesOnMapEvent();

  @override
  List<Object> get props => [];
}

class RoutesOnMapRouteEvent extends RoutesOnMapEvent {
  final String routeCode;

  RoutesOnMapRouteEvent({required this.routeCode});

  @override
  List<Object> get props => [routeCode];
}
