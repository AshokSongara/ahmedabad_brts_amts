import 'package:ahmedabad_brts_amts/injection_container.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'core/theme/dark_theme_data.dart';
import 'helper/route_helper.dart';
import 'injection_container.dart' as di;
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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkThemeData,
      themeMode: ThemeMode.dark,
      darkTheme: darkThemeData,
      home: SplashScreen(),
      initialRoute: RouteHelper.getInitialRoute(),
      getPages: RouteHelper.routes,
    );
  }
}
