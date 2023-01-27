import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:equatable/equatable.dart';

abstract class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class PostVerifyOtpEvent extends VerifyOtpEvent {
  final OtpRequest otpRequest;

  const PostVerifyOtpEvent({required this.otpRequest});

  @override
  List<Object> get props => [otpRequest];
}
