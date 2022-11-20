import 'package:ahmedabad_brts_amts/data/requestmodels/signup_request.dart';
import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupUserEvent extends SignupEvent {
  final SignupRequest data;

  SignupUserEvent({required this.data});

  @override
  List<Object> get props => [data];
}
