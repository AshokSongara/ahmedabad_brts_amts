import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/respositories/user/user_repository_impl.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/signup_user_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/logic_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final injector = GetIt.instance;

Future<void> init() async {
  //  Core
  final sharedPreferences = await SharedPreferences.getInstance();

  injector.registerSingleton(sharedPreferences);

  injector.registerFactory(() => ApiClient(appBaseUrl: AppConstant.apiUrl));

  injector.registerFactory<SignupBloc>(
    () => SignupBloc(signupUserUseCase: injector()),
  );

  injector.registerFactory<LoginBloc>(
    () => LoginBloc(loginUserUseCase: injector()),
  );

  injector.registerLazySingleton(() => SignupUserUseCase(injector()));

  injector.registerLazySingleton(() => LoginUserUseCase(injector()));

  injector.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        apiClient: injector(), sharedPreferences: injector()),
  );
}
