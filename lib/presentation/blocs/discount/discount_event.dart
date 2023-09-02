import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:equatable/equatable.dart';

abstract class DiscountEvent extends Equatable {
  const DiscountEvent();

  @override
  List<Object> get props => [];
}

class GetDiscountEvent extends DiscountEvent {
  const GetDiscountEvent();

  @override
  List<Object> get props => [];
}

class GetPaymentUrlEvent extends DiscountEvent {
  final PaymentRequest2 paymentRequest;

  const GetPaymentUrlEvent({required this.paymentRequest});

  @override
  List<Object> get props => [paymentRequest];
}