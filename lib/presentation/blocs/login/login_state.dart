import 'package:ahmedabad_brts_amts/data/models/login_response.dart';
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

  LoginSuccessState({required this.loginResponse});

  @override
  List<Object> get props => [];
}

class LoginFailedState extends LoginState {}
