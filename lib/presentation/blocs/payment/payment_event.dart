import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class GetQRCodeEvent extends PaymentEvent {
  final PaymentInternalRequest paymentRequest;

  const GetQRCodeEvent({required this.paymentRequest});

  @override
  List<Object> get props => [paymentRequest];
}
