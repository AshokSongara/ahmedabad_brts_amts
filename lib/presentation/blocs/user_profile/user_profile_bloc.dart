import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/user_update_profile_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_state.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({required this.userUpdateProfileUseCase})
      : super(UserProfileInitialState());

  final UserUpdateProfileUseCase userUpdateProfileUseCase;

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event) async* {
    if (event is GetUserProfileEvent) {
      yield UserProfileLoadingState();
      UserProfileResponse userProfileResponse =
          await userUpdateProfileUseCase(Params(data: event.profileRequest));
      if (userProfileResponse.succeeded == true) {
        saveMemberID(event.profileRequest.firstName ?? "",
            event.profileRequest.lastName ?? "");
        yield UserProfileSuccessState(userProfileResponse: userProfileResponse);
      } else {
        yield const UserProfileFailedState(
            errorMessage: "Something Went Wrong");
      }
    }
  }

  saveMemberID(String fName, String lName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstant.name, fName);
    prefs.setString(AppConstant.lastName, lName);
    AppConstant.nameData = fName;
    AppConstant.lastNameData = lName;
  }
}
