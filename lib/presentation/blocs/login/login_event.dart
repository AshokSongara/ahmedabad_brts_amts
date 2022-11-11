import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AddLoginEvent extends LoginEvent {
  final Map<String,String> data;

  AddLoginEvent({required this.data});

  @override
  List<Object> get props => [data];
}
