import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupUserEvent extends SignupEvent {
  final Map<String,String> data;

  SignupUserEvent({required this.data});

  @override
  List<Object> get props => [data];
}
