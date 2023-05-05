import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/booking_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/booking_list_usecase.dart';

import 'booking_list_event.dart';
import 'booking_list_state.dart';

class BookingListBloc extends Bloc<BookingListEvent, BookingListState> {
  BookingListBloc({required this.bookingListUseCase})
      : super(BookingInitialState());

  final BookingListUseCase bookingListUseCase;

  @override
  Stream<BookingListState> mapEventToState(BookingListEvent event) async* {
    if (event is GetBookingListEvent) {
      yield BookingListLoadingState();
      BookingListResponse bookingListResponse =
          await bookingListUseCase(Params(data: event.from));
      if (bookingListResponse.succeeded == true) {
        yield BookingListSuccessState(bookingListResponse: bookingListResponse);
      } else {
        yield const BookingListFailedState(
            errorMessage: "Something Went Wrong");
      }
    }
  }
}
