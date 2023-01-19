import 'package:ahmedabad_brts_amts/data/responsemodels/contactus_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:equatable/equatable.dart';

abstract class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object> get props => [];
}

class ContactInitialState extends ContactState {}

class ContactLoadingState extends ContactState {}

class ContactSuccessState extends ContactState {
  final ContactUsResponse contactUsResponse;

  ContactSuccessState({required this.contactUsResponse});

  @override
  List<Object> get props => [contactUsResponse];
}

class ContactFailedState extends ContactState {
  final String errorMessage;

  ContactFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
