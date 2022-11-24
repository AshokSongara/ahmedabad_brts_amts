import 'package:equatable/equatable.dart';

abstract class MobileNumberLoginEvent extends Equatable {
  const MobileNumberLoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberSubmitEvent extends MobileNumberLoginEvent{
  final String phoneNumber;
  const PhoneNumberSubmitEvent(this.phoneNumber);
}