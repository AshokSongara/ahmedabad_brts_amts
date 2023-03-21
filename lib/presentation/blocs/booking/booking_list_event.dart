import 'package:equatable/equatable.dart';

abstract class BookingListEvent extends Equatable {
  const BookingListEvent();

  @override
  List<Object> get props => [];
}

class GetBookingListEvent extends BookingListEvent {
  final String from;
  const GetBookingListEvent({required this.from});

  @override
  List<Object> get props => [from];
}

