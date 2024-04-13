import 'package:ahmedabad_brts_amts/data/responsemodels/ticket_response.dart';
import 'package:equatable/equatable.dart';

abstract class TicketState extends Equatable {
  const TicketState();

  @override
  List<Object> get props => [];
}

class TicketInitialState extends TicketState {}

class TicketLoadingState extends TicketState {}

class TicketSuccessState extends TicketState {
  final TicketResponse paymentInitResponseModel;

  const TicketSuccessState({required this.paymentInitResponseModel});

  @override
  List<Object> get props => [paymentInitResponseModel];
}

class TicketFailedState extends TicketState {
  final String errorMessage;

  const TicketFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
