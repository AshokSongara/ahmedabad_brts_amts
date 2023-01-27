import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponse loginResponse;

  const LoginSuccessState({required this.loginResponse});

  @override
  List<Object> get props => [loginResponse];
}

class LoginFailedState extends LoginState {
  final String errorMessage;

  const LoginFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
