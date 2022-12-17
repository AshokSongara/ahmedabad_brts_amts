import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/forget_password_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/forgetpassword/forget_password_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/forgetpassword/forget_password_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_state.dart';
import 'package:bloc/bloc.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc({required this.forgetPasswordUseCase})
      : super(ForgetPasswordInitialState());

  final ForgetPasswordUseCase forgetPasswordUseCase;

  @override
  Stream<ForgetPasswordState> mapEventToState(
      ForgetPasswordEvent event) async* {
    if (event is GetForgetPasswordEvent) {
      yield ForgetPasswordLoadingState();
      ForgetPasswordResponse forgetPasswordResponse =
          await forgetPasswordUseCase(
              Params(data: event.forgetPasswordRequest));
      if (forgetPasswordResponse.succeeded == true) {
        yield ForgetPasswordSuccessState(
            forgetPasswordResponse: forgetPasswordResponse);
      } else {
        yield ForgetPasswordFailedState(
            errorMessage:
                forgetPasswordResponse.error?.title ?? "Something Went Wrong");
      }
    }
  }
}
