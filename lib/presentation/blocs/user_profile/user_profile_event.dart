import 'package:ahmedabad_brts_amts/data/requestmodels/profile_request.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserProfileEvent extends UserProfileEvent {
  final ProfileRequest profileRequest;

  GetUserProfileEvent({required this.profileRequest});

  @override
  List<Object> get props => [profileRequest];
}
