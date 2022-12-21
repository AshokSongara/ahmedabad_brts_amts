import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/respositories/routes/route_repository_impl.dart';
import 'package:ahmedabad_brts_amts/data/respositories/user/user_repository_impl.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/nearme_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/search_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/forget_password_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/home_get_routes_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/mobile_number_login_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/signup_user_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/home_screen_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/verify_otp_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/usecases/user/feddback_usecase.dart';
import 'presentation/blocs/forgetpassword/forget_password_bloc.dart';

final injector = GetIt.instance;

Future<void> init() async {
  //  Core
  final sharedPreferences = await SharedPreferences.getInstance();

  injector.registerSingleton(sharedPreferences);

  injector.registerLazySingleton(() =>
      ApiClient(appBaseUrl: AppConstant.apiUrl, sharedPreferences: injector()));

  injector.registerFactory<SignupBloc>(
    () => SignupBloc(signupUserUseCase: injector()),
  );

  injector.registerFactory<LoginBloc>(
    () => LoginBloc(loginUserUseCase: injector()),
  );
  injector.registerFactory<MobileNumberLoginBloc>(
    () => MobileNumberLoginBloc(injector()),
  );

  injector.registerFactory<NearMeBloc>(
    () => NearMeBloc(nearmeRouteUseCase: injector()),
  );
  injector.registerFactory<VerifyOtpBloc>(
    () => VerifyOtpBloc(verifyOtpUseCase: injector()),
  );
  injector.registerFactory<FeedbackBloc>(
    () => FeedbackBloc(injector()),
  );
  injector.registerFactory<HomeScreenBloc>(
    () => HomeScreenBloc(injector(), injector()),
  );
  injector.registerFactory<SearchResultRouteBloc>(
    () => SearchResultRouteBloc(searchResultRouteUseCase: injector()),
  );
  injector.registerFactory<ForgetPasswordBloc>(
    () => ForgetPasswordBloc(forgetPasswordUseCase: injector()),
  );

  injector.registerLazySingleton(() => SignupUserUseCase(injector()));

  injector.registerLazySingleton(() => LoginUserUseCase(injector()));

  injector.registerLazySingleton(() => MobileNumberLoginUseCase(injector()));

  injector.registerLazySingleton(() => NearmeRouteUseCase(injector()));

  injector.registerLazySingleton(() => VerifyOtpUseCase(injector()));
  injector.registerLazySingleton(() => FeedbackUseCase(injector()));
  injector.registerLazySingleton(() => HomeScreenUseCase(injector()));
  injector.registerLazySingleton(() => HomeGetRoutesUseCase(injector()));
  injector.registerLazySingleton(() => SearchResultRouteUseCase(injector()));
  injector.registerLazySingleton(() => ForgetPasswordUseCase(injector()));

  injector.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        apiClient: injector(), sharedPreferences: injector()),
  );
  injector.registerLazySingleton<RouteRepository>(
    () => RouteRepositoryImpl(
        apiClient: injector(), sharedPreferences: injector()),
  );
}
