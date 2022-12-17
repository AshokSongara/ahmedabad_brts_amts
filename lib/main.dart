import 'package:ahmedabad_brts_amts/core/theme/app_theme.dart';
import 'package:ahmedabad_brts_amts/core/theme/theme_service.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/injection_container.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/forgetpassword/forget_password_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/splash_screen.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'helper/route_helper.dart';
import 'injection_container.dart' as di;
import 'presentation/blocs/feedback/feedback_bloc.dart';
import 'presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  await di.init();
  final document = await getApplicationDocumentsDirectory();

  await Hive.initFlutter();
  Hive.registerAdapter(BrtsStopResponseModelAdapter());
  Hive.registerAdapter(DataAdapter());
  Hive.registerAdapter(BrtsRoutesResponseModelAdapter());
  Hive.registerAdapter(RouteDataAdapter());
  await Hive.openBox<BrtsStopResponseModel>(AppConstant.BrtsStopListBox);
  await Hive.openBox<BrtsStopResponseModel>(AppConstant.AmtsStopListBox);
  await Hive.openBox<BrtsRoutesResponseModel>(AppConstant.amtsRoutesListBox);
  await Hive.openBox<BrtsRoutesResponseModel>(AppConstant.brtsRoutesListBox);
  // await Hive.openBox<BrtsStopResponseModel>('AmtsStopResponseModel');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
          create: (context) => injector<SignupBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => injector<LoginBloc>(),
        ),
        BlocProvider<NearMeBloc>(
          create: (context) => injector<NearMeBloc>(),
        ),
        BlocProvider<MobileNumberLoginBloc>(
          create: (context) => injector<MobileNumberLoginBloc>(),
        ),
        BlocProvider<VerifyOtpBloc>(
          create: (context) => injector<VerifyOtpBloc>(),
        ),
        BlocProvider<FeedbackBloc>(
          create: (context) => injector<FeedbackBloc>(),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) => injector<HomeScreenBloc>(),
        ),
        BlocProvider<SearchResultRouteBloc>(
          create: (context) => injector<SearchResultRouteBloc>(),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => injector<ForgetPasswordBloc>(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeService().theme,
          theme: Themes.light,
          home: const SplashScreen(),
          initialRoute: RouteHelper.getInitialRoute(),
          getPages: RouteHelper.routes,
        );
      },
    );
  }
}
