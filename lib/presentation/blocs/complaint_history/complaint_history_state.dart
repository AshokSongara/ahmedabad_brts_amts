
import 'package:ahmedabad_brts_amts/data/responsemodels/complaint_history_response.dart';
import 'package:equatable/equatable.dart';

abstract class ComplaintHistoryState extends Equatable {
  const ComplaintHistoryState();

  @override
  List<Object> get props => [];
}

class ComplaintHistoryInitialState extends ComplaintHistoryState {}

class ComplaintHistoryLoadingState extends ComplaintHistoryState {}

class ComplaintHistorySuccessState extends ComplaintHistoryState {
  final ComplaintHistoryResponse complaintHistoryResponse;

  const ComplaintHistorySuccessState({required this.complaintHistoryResponse});

  @override
  List<Object> get props => [complaintHistoryResponse];
}

class ComplaintHistoryFailedState extends ComplaintHistoryState {
  final String errorMessage;

  const ComplaintHistoryFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
