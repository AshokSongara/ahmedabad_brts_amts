import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/user_profile_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_state.dart';
import 'package:bloc/bloc.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({required this.userProfileUseCase})
      : super(UserProfileInitialState());

  final UserProfileUseCase userProfileUseCase;

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is GetUserProfileEvent) {
      yield UserProfileLoadingState();
      UserProfileResponse userProfileResponse =
          await userProfileUseCase(Params(data: ""));
      if (userProfileResponse.succeeded == true) {
        yield UserProfileSuccessState(userProfileResponse: userProfileResponse);
      } else {
        yield UserProfileFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
