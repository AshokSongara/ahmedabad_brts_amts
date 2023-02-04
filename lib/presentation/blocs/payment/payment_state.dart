import 'package:ahmedabad_brts_amts/data/responsemodels/qr_code_response.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitialState extends PaymentState {}

class PaymentLoadingState extends PaymentState {}

class PaymentSuccessState extends PaymentState {
  final QRCodeResponse qrCodeResponse;

  const PaymentSuccessState({required this.qrCodeResponse});

  @override
  List<Object> get props => [qrCodeResponse];
}

class PaymentFailedState extends PaymentState {
  final String errorMessage;

  const PaymentFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
