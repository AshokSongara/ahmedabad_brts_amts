import 'package:equatable/equatable.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/booking_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/delete_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_route_response.dart';

abstract class BookingListState extends Equatable {
  const BookingListState();

  @override
  List<Object> get props => [];
}

class BookingInitialState extends BookingListState {}

class BookingListLoadingState extends BookingListState {}

class BookingListSuccessState extends BookingListState {
  final BookingListResponse bookingListResponse;

  const BookingListSuccessState({required this.bookingListResponse});

  @override
  List<Object> get props => [bookingListResponse];
}

class BookingListFailedState extends BookingListState {
  final String errorMessage;

  const BookingListFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
