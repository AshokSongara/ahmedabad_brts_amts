import 'dart:async';

import 'package:ahmedabad_brts_amts/domain/usecases/route/add_transaction_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_state.dart';

import '../../../data/responsemodels/PaymentInitResponseModel.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required this.addTransactionUseCase}) : super(PaymentInitialState());

  final AddTransactionUseCase addTransactionUseCase;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is GetQRCodeEvent) {
      yield PaymentLoadingState();
      PaymentInitResponseModel qrCodeResponse =
          await addTransactionUseCase(Params(data: event.paymentRequest));

      if (qrCodeResponse.succeeded == true) {
        yield PaymentSuccessState(qrCodeResponse: qrCodeResponse);
      } else {
        yield const PaymentFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
