import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_state.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginUserUseCase}) : super(LoginInitialState());

  final LoginUserUseCase loginUserUseCase;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUserEvent) {
      yield LoginLoadingState();
      LoginResponse loginResponse =
          await loginUserUseCase(Params(data: event.loginRequest));
      if (loginResponse.statusCode == 200) {
        yield LoginSuccessState(loginResponse: loginResponse);
      } else {
        yield LoginFailedState();
      }
    }
  }
}
