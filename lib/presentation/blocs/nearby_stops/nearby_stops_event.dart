import 'package:equatable/equatable.dart';

abstract class NearByStopsEvent extends Equatable {
  const NearByStopsEvent();

  @override
  List<Object> get props => [];
}
class GetNearByStopsEvent extends NearByStopsEvent{
  String routeId;
  GetNearByStopsEvent(this.routeId);
}
