import 'package:equatable/equatable.dart';

import '../../../data/responsemodels/Nearby_stops_response_model.dart';

abstract class NearByStopsState extends Equatable {
  const NearByStopsState();

  @override
  List<Object> get props => [];
}
class NearByStopsInitialState extends NearByStopsState{}
class NearByStopsResponseState extends NearByStopsState{
  NearbyStopsResponseModel model;
  NearByStopsResponseState(this.model);
}
class GetNearByStopsLoadingState extends NearByStopsState{
  GetNearByStopsLoadingState();
}