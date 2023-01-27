import 'package:ahmedabad_brts_amts/data/requestmodels/login_request.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginUserEvent extends LoginEvent {
  final LoginRequest loginRequest;

  const LoginUserEvent({required this.loginRequest});

  @override
  List<Object> get props => [loginRequest];
}
