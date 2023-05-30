import 'package:equatable/equatable.dart';

abstract class ComplaintHistoryEvent extends Equatable {
  const ComplaintHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetComplaintHistoryEvent extends ComplaintHistoryEvent {
  const GetComplaintHistoryEvent();

  @override
  List<Object> get props => [];
}

