import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/verify_otp_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/user_profile_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/verify_otp_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_state.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc(
      {required this.verifyOtpUseCase, required this.userProfileUseCase})
      : super(VerifyOtpInitialState());

  final VerifyOtpUseCase verifyOtpUseCase;
  final UserProfileUseCase userProfileUseCase;

  @override
  Stream<VerifyOtpState> mapEventToState(VerifyOtpEvent event) async* {
    if (event is PostVerifyOtpEvent) {
      yield VerifyOtpLoadingState();
      VerifyOtpResponse verifyOtpResponse =
          await verifyOtpUseCase(Params(data: event.otpRequest));

      if (verifyOtpResponse.succeeded == true) {
        UserProfileResponse userProfileResponse =
            await userProfileUseCase(const Params(data: ""));

        AppConstant.nameData = userProfileResponse.data!.firstName ?? "";
        AppConstant.emailData = userProfileResponse.data!.email ?? "";
        AppConstant.lastNameData = userProfileResponse.data!.lastName ?? "";

        saveMemberID(userProfileResponse,verifyOtpResponse);
      }

      if (verifyOtpResponse.succeeded == true) {
        yield VerifyOtpSuccessState(verifyOtpResponse: verifyOtpResponse);
      } else {
        yield VerifyOtpFailedState(
            errorMessage: verifyOtpResponse.error?.title ?? "");
      }
    }
  }

  saveMemberID(UserProfileResponse userProfileResponse,
      VerifyOtpResponse verifyOtpResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        AppConstant.name, userProfileResponse.data?.firstName ?? "");
    prefs.setString(
        AppConstant.lastName, userProfileResponse.data?.lastName ?? "");
    prefs.setString(AppConstant.accessToken,
        verifyOtpResponse.data!.jwt!.accessToken ?? "");
    prefs.setString(
        AppConstant.email, verifyOtpResponse.data!.jwt!.email ?? "");
  }
}
