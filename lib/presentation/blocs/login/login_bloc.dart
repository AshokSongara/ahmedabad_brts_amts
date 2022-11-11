import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/models/login_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/customer/login_customer_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_state.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required this.loginCustomerUseCase})
      : super(LoginInitialState());

  final LoginCustomerUseCase loginCustomerUseCase;

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AddLoginEvent) {
      print("GetTodoListEvent : called");
      yield LoginLoadingState();
      LoginResponse loginResponse =
          await loginCustomerUseCase(Params(data: event.data));
      if (loginResponse.data != null) {
        yield LoginSuccessState(loginResponse: loginResponse);
      } else {
        yield LoginFailedState();
      }
    }
  }
}
