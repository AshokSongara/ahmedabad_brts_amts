import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/signup_user_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_state.dart';
import 'package:bloc/bloc.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required this.signupUserUseCase})
      : super(SignupInitialState());

  final SignupUserUseCase signupUserUseCase;

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupUserEvent) {
      yield SignupLoadingState();
      SignUpResponse signUpResponse =
          await signupUserUseCase(Params(data: event.data));
      if (signUpResponse.succeeded == true) {
        yield SignupSuccessState(signUpResponse: signUpResponse);
      } else {
        yield SignupFailedState(errorMessage: signUpResponse.error?.title ?? "");
      }
    }
  }
}
