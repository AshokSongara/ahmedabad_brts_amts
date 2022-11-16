import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/dashboard_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/dashboard/route_details_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/splash_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/nearby/nearby_sreen.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/passenger_details/passenger_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'core/theme/dark_theme_data.dart';
import 'helper/route_helper.dart';
import 'injection_container.dart' as di;
import 'presentation/pages/card_details/card_detail_screen.dart';
import 'presentation/pages/dashboard/search_result_screen.dart';
import 'utils/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: AppColors.primaryColor, // status bar color
  ));
  await di.init();

  runApp(
    MyApp(),
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
      home: CardDetailsScreen(),
      initialRoute: RouteHelper.getInitialRoute(),
      getPages: RouteHelper.routes,
    );
  }
}
