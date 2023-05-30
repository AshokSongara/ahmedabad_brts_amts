import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/complaint_response.dart';
import 'package:equatable/equatable.dart';

abstract class ComplaintState extends Equatable {
  const ComplaintState();

  @override
  List<Object> get props => [];
}
class ComplaintInitialState extends ComplaintState{}

class ComplaintLoadingState extends ComplaintState{}
class ComplaintFailedState extends ComplaintState{}
class StopsResponseState extends ComplaintState{
  final BrtsStopResponseModel model;
  const StopsResponseState(this.model);

}
class RoutesResponseState extends ComplaintState{
  final BrtsRoutesResponseModel model;
  const RoutesResponseState(this.model);
}

class ComplaintSuccessState extends ComplaintState {
  final ComplaintResponseModel complaintResponseModel;

  const ComplaintSuccessState({required this.complaintResponseModel});

  @override
  List<Object> get props => [];
}