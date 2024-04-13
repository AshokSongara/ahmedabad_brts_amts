import 'package:equatable/equatable.dart';

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
