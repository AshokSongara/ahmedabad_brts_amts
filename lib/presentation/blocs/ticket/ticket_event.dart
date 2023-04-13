import 'package:equatable/equatable.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';

abstract class TicketEvent extends Equatable {
  const TicketEvent();

  @override
  List<Object> get props => [];
}

class GetTicketEvent extends TicketEvent {
  final String ticketNumber;

  const GetTicketEvent({required this.ticketNumber});

  @override
  List<Object> get props => [ticketNumber];
}
