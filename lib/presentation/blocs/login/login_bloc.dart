import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/user_profile_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_state.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginUserUseCase, required this.userProfileUseCase})
      : super(LoginInitialState());

  final LoginUserUseCase loginUserUseCase;
  final UserProfileUseCase userProfileUseCase;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserEvent) {
      yield LoginLoadingState();
      LoginResponse loginResponse =
          await loginUserUseCase(Params(data: event.loginRequest));

      UserProfileResponse userProfileResponse =
          await userProfileUseCase(Params(data: ""));
      saveMemberID(userProfileResponse);

      if (loginResponse.succeeded == true) {
        yield LoginSuccessState(loginResponse: loginResponse);
      } else {
        yield LoginFailedState(
            errorMessage: loginResponse.error?.title ?? "Something Went Wrong");
      }
    }
  }

  saveMemberID(UserProfileResponse userProfileResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        AppConstant.name,
        userProfileResponse.data?.firstName ?? "");
    prefs.setString(
        AppConstant.lastName,
        userProfileResponse.data?.lastName ?? "");
  }

  saveToken(LoginResponse loginResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        AppConstant.accessToken, loginResponse.data?.accessToken ?? "");
  }
}
