import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitialState extends ChangePasswordState {}

class ChangePasswordLoadingState extends ChangePasswordState {}

class ChangePasswordSuccessState extends ChangePasswordState {
  final ForgetPasswordResponse forgetPasswordResponse;

  const ChangePasswordSuccessState({required this.forgetPasswordResponse});

  @override
  List<Object> get props => [forgetPasswordResponse];
}

class ChangePasswordFailedState extends ChangePasswordState {
  final String errorMessage;

  const ChangePasswordFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
