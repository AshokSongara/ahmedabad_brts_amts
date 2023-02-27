import 'package:ahmedabad_brts_amts/data/requestmodels/routes_request_model.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/stop_request_model.dart';
import 'package:equatable/equatable.dart';

import '../../../data/responsemodels/brts_stop_respons_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAvailableStopsEvent extends HomeEvent {
 final StopRequestModel model;

  const GetAvailableStopsEvent(this.model);
}

class GetAvailableRoutesEvent extends HomeEvent {
  final RoutesRequestModel model;

  const GetAvailableRoutesEvent(this.model);
}
class SourceSelectionFromMapScreenEvent extends HomeEvent{
  final Data data;
  const SourceSelectionFromMapScreenEvent(this.data);
}