// import 'dart:async';
// import 'package:ahmedabad_brts_amts/core/models/params.dart';
// import 'package:ahmedabad_brts_amts/data/models/login_response.dart';
// import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
// import 'package:ahmedabad_brts_amts/domain/usecases/user/signup_user_usecase.dart';
// import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_event.dart';
// import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_state.dart';
// import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_event.dart';
// import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_state.dart';
// import 'package:bloc/bloc.dart';
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   LoginBloc({required this.loginUserUseCase})
//       : super(LoginInitialState());
//
//   final LoginUserUseCase loginUserUseCase;
//
//   @override
//   Stream<LoginState> mapEventToState(LoginEvent event) async* {
//     if (event is LoginUserEvent) {
//       print("GetTodoListEvent : called");
//       yield LoginLoadingState();
//       LoginResponse loginResponse =
//           await loginUserUseCase(Params(data: event.data));
//       if (loginResponse.data != null) {
//         yield LoginSuccessState(loginResponse: loginResponse);
//       } else {
//         yield LoginFailedState();
//       }
//     }
//   }
// }
