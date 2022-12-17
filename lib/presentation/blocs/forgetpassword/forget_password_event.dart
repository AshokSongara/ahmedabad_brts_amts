import 'package:ahmedabad_brts_amts/data/requestmodels/forget_password_request.dart';
import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class GetForgetPasswordEvent extends ForgetPasswordEvent {
  final ForgetPasswordRequest forgetPasswordRequest;

  GetForgetPasswordEvent({required this.forgetPasswordRequest});

  @override
  List<Object> get props => [forgetPasswordRequest];
}
