import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:equatable/equatable.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitialState extends UserProfileState {}

class UserProfileLoadingState extends UserProfileState {}

class UserProfileSuccessState extends UserProfileState {
  final UserProfileResponse userProfileResponse;

  UserProfileSuccessState({required this.userProfileResponse});

  @override
  List<Object> get props => [userProfileResponse];
}

class UserProfileFailedState extends UserProfileState {
  final String errorMessage;

  UserProfileFailedState({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
