import 'dart:async';

import 'package:ahmedabad_brts_amts/data/responsemodels/ticket_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/ticket_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/ticket/ticket_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/ticket/ticket_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc({required this.ticketUseCase}) : super(TicketInitialState());

  final TicketUseCase ticketUseCase;

  @override
  Stream<TicketState> mapEventToState(TicketEvent event) async* {
    if (event is GetTicketEvent) {
      yield TicketLoadingState();

      TicketResponse qrCodeResponse =
          await ticketUseCase(Params(data: event.ticketNumber));

      if (qrCodeResponse.succeeded == true) {
        yield TicketSuccessState(paymentInitResponseModel: qrCodeResponse);
      } else {
        yield const TicketFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
