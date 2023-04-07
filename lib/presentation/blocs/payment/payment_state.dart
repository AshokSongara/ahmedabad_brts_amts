import 'package:ahmedabad_brts_amts/data/responsemodels/PaymentInitResponseModel.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/payment_URL_Response.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitialState extends PaymentState {}

class PaymentUrlLoadingState extends PaymentState {}

class PaymentUrlSuccessState extends PaymentState {
  final PaymentURLResponse qrCodeResponse;

  const PaymentUrlSuccessState({required this.qrCodeResponse});

  @override
  List<Object> get props => [qrCodeResponse];
}

class PaymentUrlFailedState extends PaymentState {
  final String errorMessage;

  const PaymentUrlFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}


class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {
  final PaymentInitResponseModel paymentInitResponseModel;

  const PaymentSuccessState({required this.paymentInitResponseModel});

  @override
  List<Object> get props => [paymentInitResponseModel];
}

class PaymentFailedState extends PaymentState {
  final String errorMessage;

  const PaymentFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
