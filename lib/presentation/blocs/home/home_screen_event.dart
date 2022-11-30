import 'package:ahmedabad_brts_amts/data/requestmodels/stop_request_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetAvailableRoutesEvent extends HomeEvent {
 final StopRequestModel model;

  const GetAvailableRoutesEvent(this.model);
}
