import 'dart:async';

import 'package:ahmedabad_brts_amts/data/responsemodels/payment_URL_Response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/add_transaction_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/payment_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_state.dart';

import '../../../data/responsemodels/PaymentInitResponseModel.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(
      {required this.addTransactionUseCase, required this.paymentUseCase})
      : super(PaymentInitialState());

  final AddTransactionUseCase addTransactionUseCase;
  final PaymentUseCase paymentUseCase;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is GetPaymentUrlEvent) {
      yield PaymentUrlLoadingState();
      // PaymentInitResponseModel qrCodeResponse =
      //     await addTransactionUseCase(Params(data: event.paymentRequest));

      PaymentURLResponse paymentURLResponse =
          await paymentUseCase(Params(data: event.paymentRequest));

      if (paymentURLResponse.succeeded == true) {
        yield PaymentUrlSuccessState(qrCodeResponse: paymentURLResponse);
      } else {
        yield const PaymentUrlFailedState(errorMessage: "Something Went Wrong");
      }
    } else if (event is GetQRCodeEvent) {
      yield PaymentLoadingState();
      PaymentInitResponseModel qrCodeResponse =
          await addTransactionUseCase(Params(data: event.paymentRequest));

      if (qrCodeResponse.succeeded == true) {
        yield PaymentSuccessState(paymentInitResponseModel: qrCodeResponse);
      } else {
        yield const PaymentFailedState(errorMessage: "Something Went Wrong");
        print("failed state");
      }
    }
  }
}
