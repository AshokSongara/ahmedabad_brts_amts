import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitialState extends ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordSuccessState extends ForgetPasswordState {
  final ForgetPasswordResponse forgetPasswordResponse;

  ForgetPasswordSuccessState({required this.forgetPasswordResponse});

  @override
  List<Object> get props => [forgetPasswordResponse];
}

class ForgetPasswordFailedState extends ForgetPasswordState {
  final String errorMessage;

  ForgetPasswordFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
