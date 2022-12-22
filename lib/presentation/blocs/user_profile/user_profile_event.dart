import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends UserProfileEvent {
  GetUserProfileEvent();

  @override
  List<Object> get props => [];
}
