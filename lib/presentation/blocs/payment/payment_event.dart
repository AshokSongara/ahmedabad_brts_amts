
import 'package:equatable/equatable.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class GetQRCodeEvent extends PaymentEvent {
  final PaymentRequest paymentRequest;

  const GetQRCodeEvent({required this.paymentRequest});

  @override
  List<Object> get props => [paymentRequest];
}
