import 'dart:async';

import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/qr_code_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/qr_user_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({required this.qrUserUseCase}) : super(PaymentInitialState());

  final QRUserUseCase qrUserUseCase;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    if (event is GetQRCodeEvent) {
      yield PaymentLoadingState();
      QRCodeResponse qrCodeResponse =
          await qrUserUseCase(Params(data: event.paymentRequest));

      if (qrCodeResponse.succeeded == true) {
        yield PaymentSuccessState(qrCodeResponse: qrCodeResponse);
      } else {
        yield const PaymentFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
