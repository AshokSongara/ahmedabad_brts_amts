import 'package:equatable/equatable.dart';

abstract class BookingListEvent extends Equatable {
  const BookingListEvent();

  @override
  List<Object> get props => [];
}

class GetBookingListEvent extends BookingListEvent {
  const GetBookingListEvent();

  @override
  List<Object> get props => [];
}

