import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:equatable/equatable.dart';

abstract class SignupState extends Equatable {
  const SignupState();

  @override
  List<Object> get props => [];
}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState extends SignupState {
  final SignUpResponse signUpResponse;

  const SignupSuccessState({required this.signUpResponse});

  @override
  List<Object> get props => [];
}

class SignupFailedState extends SignupState {
  final String errorMessage;

  const SignupFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
