import 'package:equatable/equatable.dart';

abstract class FavouriteRouteListDataEvent extends Equatable {
  const FavouriteRouteListDataEvent();

  @override
  List<Object> get props => [];
}

class GetFavouriteRouteListEvent extends FavouriteRouteListDataEvent {
  const GetFavouriteRouteListEvent({required this.serviceType});
  final String serviceType;

  @override
  List<Object> get props => [serviceType];

}
