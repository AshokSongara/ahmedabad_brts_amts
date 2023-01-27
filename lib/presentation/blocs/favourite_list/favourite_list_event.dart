import 'package:equatable/equatable.dart';

abstract class FavouriteRouteListEvent extends Equatable {
  const FavouriteRouteListEvent();

  @override
  List<Object> get props => [];
}

class GetFavouriteRouteListEvent extends FavouriteRouteListEvent {
  const GetFavouriteRouteListEvent();

  @override
  List<Object> get props => [];
}

class DeleteFavouriteRouteEvent extends FavouriteRouteListEvent {
  final String routeId;

  const DeleteFavouriteRouteEvent({required this.routeId});

  @override
  List<Object> get props => [];
}
