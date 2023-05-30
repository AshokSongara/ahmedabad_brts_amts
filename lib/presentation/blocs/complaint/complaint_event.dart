import 'package:ahmedabad_brts_amts/data/requestmodels/complaint_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/routes_request_model.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/stop_request_model.dart';
import 'package:equatable/equatable.dart';

abstract class ComplaintEvent extends Equatable {
  const ComplaintEvent();

  @override
  List<Object> get props => [];
}

class GetAvailableStopsEvent extends ComplaintEvent {
  final StopRequestModel model;

  const GetAvailableStopsEvent(this.model);
}

class GetAvailableRoutesEvent extends ComplaintEvent {
  final RoutesRequestModel model;

  const GetAvailableRoutesEvent(this.model);
}

class ComplaintUserEvent extends ComplaintEvent {
  final ComplaintRequest data;

  const ComplaintUserEvent({required this.data});

  @override
  List<Object> get props => [data];
}