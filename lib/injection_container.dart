import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/respositories/customer/customer_repository_impl.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/customer/customer_repository.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/customer/login_customer_usecase.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'presentation/blocs/login/login_bloc.dart';

final injector = GetIt.instance;

Future<void> init() async {
  //  Core
  final sharedPreferences = await SharedPreferences.getInstance();

  injector.registerSingleton(sharedPreferences);

  injector.registerFactory(() => ApiClient(appBaseUrl: AppConstant.apiUrl));

  injector.registerFactory<LoginBloc>(
    () => LoginBloc(loginCustomerUseCase: injector()),
  );

  injector.registerLazySingleton(() => LoginCustomerUseCase(injector()));

  injector.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(
        apiClient: injector(), sharedPreferences: injector()),
  );
}
