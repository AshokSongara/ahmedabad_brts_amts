import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: const Color(0xffD43030),
    backgroundColor: AppColors.appBackground,
   // buttonColor: const Color(0xffDB5558),
    bottomAppBarColor: const Color(0xffD43030),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xffDB5558),
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
  );

  static final dark = ThemeData.dark().copyWith(
    primaryColor: const Color(0xff0162B4),
    backgroundColor: AppColors.appBackground,
   // buttonColor: const Color(0xff0074B7),
    bottomAppBarColor: const Color(0xff0162B4),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xff0162B4),
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
  );
}