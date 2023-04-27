import 'package:equatable/equatable.dart';

abstract class FavouriteRouteListEvent extends Equatable {
  const FavouriteRouteListEvent();

  @override
  List<Object> get props => [];
}

class GetFavouriteRouteListEvent extends FavouriteRouteListEvent {
  final String serviceType;
  const GetFavouriteRouteListEvent({required this.serviceType});

  @override
  List<Object> get props => [serviceType];
}

class DeleteFavouriteRouteEvent extends FavouriteRouteListEvent {
  final String routeId;

  const DeleteFavouriteRouteEvent({required this.routeId});

  @override
  List<Object> get props => [];
}
