import 'package:ahmedabad_brts_amts/injection_container.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/theme/dark_theme_data.dart';
import 'helper/route_helper.dart';
import 'injection_container.dart' as di;
import 'presentation/blocs/feedback/feedback_bloc.dart';
import 'presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: AppColors.primaryColor, // status bar color
  ));
  await di.init();

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
          theme: darkThemeData,
          themeMode: ThemeMode.dark,
          darkTheme: darkThemeData,
          home: const SplashScreen(),
          initialRoute: RouteHelper.getInitialRoute(),
          getPages: RouteHelper.routes,
        );
      },
    );
  }
}
