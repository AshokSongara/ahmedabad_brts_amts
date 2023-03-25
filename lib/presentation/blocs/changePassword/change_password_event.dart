import 'package:ahmedabad_brts_amts/data/requestmodels/change_password_request.dart';
import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class GetChangePasswordEvent extends ChangePasswordEvent {
  final ChangePasswordRequest changePasswordRequest;

  const GetChangePasswordEvent({required this.changePasswordRequest});

  @override
  List<Object> get props => [changePasswordRequest];
}
