import 'package:ahmedabad_brts_amts/data/models/login_response.dart';
import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final LoginResponse loginResponse;

  SignupSuccessState({required this.loginResponse});

  @override
  List<Object> get props => [];
}

class SignupFailedState extends SignupState {}
