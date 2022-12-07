import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/verify_otp_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/verify_otp_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_state.dart';
import 'package:bloc/bloc.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  VerifyOtpBloc({required this.verifyOtpUseCase}) : super(VerifyOtpInitialState());

  final VerifyOtpUseCase verifyOtpUseCase;

  @override
  Stream<VerifyOtpState> mapEventToState(VerifyOtpEvent event) async* {
    if (event is PostVerifyOtpEvent) {
      yield VerifyOtpLoadingState();
      VerifyOtpResponse verifyOtpResponse =
          await verifyOtpUseCase(Params(data: event.otpRequest));
      if (verifyOtpResponse.succeeded == true) {
        yield VerifyOtpSuccessState(verifyOtpResponse: verifyOtpResponse);
      } else {
        yield VerifyOtpFailedState(errorMessage: verifyOtpResponse.error?.title ?? "");
      }
    }
  }
}
