import 'package:equatable/equatable.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class GetContactEvent extends ContactEvent {
  const GetContactEvent();

  @override
  List<Object> get props => [];
}
