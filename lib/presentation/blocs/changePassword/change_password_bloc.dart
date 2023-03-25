import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/change_password_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/changePassword/change_password_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/changePassword/change_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({required this.changePasswordUseCase})
      : super(ChangePasswordInitialState());

  final ChangePasswordUseCase changePasswordUseCase;

  @override
  Stream<ChangePasswordState> mapEventToState(
      ChangePasswordEvent event) async* {
    if (event is GetChangePasswordEvent) {
      yield ChangePasswordLoadingState();
      ForgetPasswordResponse forgetPasswordResponse =
          await changePasswordUseCase(
              Params(data: event.changePasswordRequest));
      if (forgetPasswordResponse.succeeded == true) {
        yield ChangePasswordSuccessState(
            forgetPasswordResponse: forgetPasswordResponse);
      } else {
        yield ChangePasswordFailedState(
            errorMessage:
                forgetPasswordResponse.error?.title ?? "Something Went Wrong");
      }
    }
  }
}
