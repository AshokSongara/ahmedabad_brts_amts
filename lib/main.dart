import 'dart:io';

import 'package:ahmedabad_brts_amts/core/theme/app_theme.dart';
import 'package:ahmedabad_brts_amts/core/theme/theme_service.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/injection_container.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/changePassword/change_password_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint/complaint_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/complaint_history/complaint_history_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/contactus/contact_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list/favourite_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list_data/favourite_route_data_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/forgetpassword/forget_password_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/map_route_code/routes_on_map_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearby_stops/nearby_stops_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/near_by_map/near_by_map_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/notification/notification_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/stop_search/stop_search_details_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/ticket/ticket_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/pages/lrf/splash_screen.dart';
import 'package:ahmedabad_brts_amts/presentation/widgets/base/custom_button.dart';
import 'package:ahmedabad_brts_amts/utils/app_colors.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:ahmedabad_brts_amts/utils/image_constant.dart';
import 'package:ahmedabad_brts_amts/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'helper/route_helper.dart';
import 'injection_container.dart' as di;
import 'localization/app_localizations.dart';
import 'presentation/blocs/booking/booking_list_bloc.dart';
import 'presentation/blocs/feedback/feedback_bloc.dart';
import 'presentation/blocs/language/language_cubit.dart';
import 'presentation/blocs/onTapFav/ontap_fav_bloc.dart';
import 'presentation/blocs/payment/payment_bloc.dart';
import 'presentation/blocs/search_route/search_route_bloc.dart';
import 'presentation/blocs/verify_otp/verify_otp_bloc.dart';

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
    Builder(
      builder: (BuildContext context) {
        return MultiBlocProvider(
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
            BlocProvider<UserProfileBloc>(
              create: (context) => injector<UserProfileBloc>(),
            ),
            BlocProvider<NotificationBloc>(
              create: (context) => injector<NotificationBloc>(),
            ),
            BlocProvider<FavouriteRouteListBloc>(
              create: (context) => injector<FavouriteRouteListBloc>(),
            ),
            BlocProvider<SearchRouteBloc>(
              create: (context) => injector<SearchRouteBloc>(),
            ),
            BlocProvider<NearByMapBloc>(
              create: (context) => injector<NearByMapBloc>(),
            ),
            BlocProvider<RouteDetailsBloc>(
              create: (context) => injector<RouteDetailsBloc>(),
            ),
            BlocProvider<ContactBloc>(
              create: (context) => injector<ContactBloc>(),
            ),
            BlocProvider<PaymentBloc>(
              create: (context) => injector<PaymentBloc>(),
            ),
            BlocProvider<StopSearchDetailsBloc>(
              create: (context) => injector<StopSearchDetailsBloc>(),
            ),
            BlocProvider<NearByStopsBloc>(
              create: (context) => injector<NearByStopsBloc>(),
            ),
            BlocProvider<BookingListBloc>(
              create: (context) => injector<BookingListBloc>(),
            ),
            BlocProvider<OneDayBloc>(
              create: (context) => injector<OneDayBloc>(),
            ),
            BlocProvider<DiscountBloc>(
              create: (context) => injector<DiscountBloc>(),
            ),
            BlocProvider<ChangePasswordBloc>(
              create: (context) => injector<ChangePasswordBloc>(),
            ),
            BlocProvider<TicketBloc>(
              create: (context) => injector<TicketBloc>(),
            ),
            BlocProvider<RoutesOnMapBloc>(
              create: (context) => injector<RoutesOnMapBloc>(),
            ),
            BlocProvider<FavouriteRouteListDataBloc>(
              create: (context) => injector<FavouriteRouteListDataBloc>(),
            ),
            BlocProvider<ComplaintBloc>(
              create: (context) => injector<ComplaintBloc>(),
            ),
            BlocProvider<OnTapFavDetailsBloc>(
              create: (context) => injector<OnTapFavDetailsBloc>(),
            ),
            BlocProvider<ComplaintHistoryBloc>(
              create: (context) => injector<ComplaintHistoryBloc>(),
            ),
          ],
          child: MyApp(),
        );
      }
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isConnected = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        isConnected = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale?>(
        builder: (context, lang) {
          return ScreenUtilInit(
            designSize: const Size(428, 926),
            builder: (BuildContext context, Widget? child) {
              return GetMaterialApp(
                locale: lang,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en', ''), // English, no country code
                  Locale('gu', ''),
                ],
                debugShowCheckedModeBanner: false,
                themeMode: ThemeService().theme,
                theme: Themes.light,
                darkTheme: Themes.dark,
                home: isConnected ? const SplashScreen() : noInternetScreen(),
                initialRoute: RouteHelper.getInitialRoute(),
                getPages: RouteHelper.routes,
              );
            },
          );
        },
      ),
    );
  }

  Widget noInternetScreen() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImageConstant.iDisconnected,
                height: 150.sp,
                width: 150.sp,
              ),
              SizedBox(height: 25.sp),
              Text(
                'No Internet Connection',
                style: satoshiRegularSmallDark.copyWith(fontSize: 25.sp),
              ),
              SizedBox(height: 16.sp),
              Text(
                'Please check your internet connection and restart the app again.',
                textAlign: TextAlign.center,
                style: satoshiRegularSmallDark.copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 25.sp),

              CustomButton(color: AppColors.primaryColor, text: "Try again", onPressed: (){ checkInternetConnectivity();}, width: 150.sp, style: satoshiRegularSmallDark.copyWith(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600), height: 50.sp)
            ],
          ),
        ),
      ),
    );
  }
}