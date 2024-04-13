import 'package:equatable/equatable.dart';

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
