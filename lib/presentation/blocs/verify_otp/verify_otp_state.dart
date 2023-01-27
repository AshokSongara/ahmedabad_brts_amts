import 'package:ahmedabad_brts_amts/data/responsemodels/verify_otp_response.dart';
import 'package:equatable/equatable.dart';

abstract class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

class VerifyOtpInitialState extends VerifyOtpState {}

class VerifyOtpLoadingState extends VerifyOtpState {}

class VerifyOtpSuccessState extends VerifyOtpState {
  final VerifyOtpResponse verifyOtpResponse;

  const VerifyOtpSuccessState({required this.verifyOtpResponse});

  @override
  List<Object> get props => [verifyOtpResponse];
}

class VerifyOtpFailedState extends VerifyOtpState {
  final String errorMessage;

  const VerifyOtpFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
