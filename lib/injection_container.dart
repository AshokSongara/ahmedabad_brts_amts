import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_routes_response_list.dart';
import 'package:ahmedabad_brts_amts/data/respositories/routes/route_repository_impl.dart';
import 'package:ahmedabad_brts_amts/data/respositories/user/user_repository_impl.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/add_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/add_transaction_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/booking_list_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/delete_route_list_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/discount_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/eta_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/fare_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/favourite_route_list_data_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/nearme_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/oneday_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/payment_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_details_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_stoplist_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/routes_on_map_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/search_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/favourite_route_list_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/ticket_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/change_password_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/contactus_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/forget_password_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/home_get_routes_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/mobile_number_login_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/notification_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/qr_user_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/signup_user_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/home_screen_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/user_profile_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/user_update_profile_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/verify_otp_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/booking/booking_list_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/changePassword/change_password_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/contactus/contact_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/discount/discount_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list/favourite_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/favourite_list_data/favourite_route_data_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/feedback/feedback_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearby_stops/nearby_stops_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/payment/payment_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/near_by_map/near_by_map_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/mobile_number_login/mobile_number_login_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/signup/signup_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/stop_search/stop_search_details_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/ticket/ticket_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/user_profile/user_profile_bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/verify_otp/verify_otp_bloc.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/usecases/nearby_stops_usecase.dart';
import 'domain/usecases/route/add_favourite_usecase.dart';
import 'domain/usecases/user/feddback_usecase.dart';
import 'presentation/blocs/forgetpassword/forget_password_bloc.dart';
import 'presentation/blocs/map_route_code/routes_on_map_bloc.dart';
import 'presentation/blocs/notification/notification_bloc.dart';
import 'presentation/blocs/search_route/search_route_bloc.dart';

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
    () =>
        LoginBloc(userProfileUseCase: injector(), loginUserUseCase: injector()),
  );

  injector.registerFactory<MobileNumberLoginBloc>(
    () => MobileNumberLoginBloc(injector()),
  );

  injector.registerFactory<NearMeBloc>(
    () => NearMeBloc(nearmeRouteUseCase: injector()),
  );

  injector.registerFactory<VerifyOtpBloc>(
    () => VerifyOtpBloc(
        verifyOtpUseCase: injector(), userProfileUseCase: injector()),
  );

  injector.registerFactory<FeedbackBloc>(
    () => FeedbackBloc(injector()),
  );

  injector.registerFactory<HomeScreenBloc>(
    () => HomeScreenBloc(injector(), injector()),
  );

  injector.registerFactory<SearchResultRouteBloc>(
    () => SearchResultRouteBloc(
        searchResultRouteUseCase: injector(),
        fareUseCase: injector(),
        addFavouriteUseCase: injector()),
  );

  injector.registerFactory<ForgetPasswordBloc>(
    () => ForgetPasswordBloc(forgetPasswordUseCase: injector()),
  );

  injector.registerFactory<UserProfileBloc>(
    () => UserProfileBloc(userUpdateProfileUseCase: injector()),
  );

  injector.registerFactory<NotificationBloc>(
    () => NotificationBloc(notificationUseCase: injector()),
  );
  injector.registerFactory<SearchRouteBloc>(
    () => SearchRouteBloc(injector()),
  );
  injector.registerFactory<NearByMapBloc>(
    () => NearByMapBloc(nearmeRouteUseCase: injector()),
  );
  injector.registerFactory<RouteDetailsBloc>(
    () => RouteDetailsBloc(
        routeDetailsUseCase: injector(),
        fareUseCase: injector(),
        etaUseCase: injector(),
        routeStopListUseCase: injector()),
  );
  injector.registerFactory<FavouriteRouteListBloc>(
    () => FavouriteRouteListBloc(
        favouriteRouteListUseCase: injector(),
        deleteRouteListUseCase: injector()),
  );

  injector.registerFactory<ContactBloc>(
    () => ContactBloc(
      contactUsUseCase: injector(),
    ),
  );
  injector.registerFactory<PaymentBloc>(
    () => PaymentBloc(
        addTransactionUseCase: injector(), paymentUseCase: injector()),
  );
  injector.registerFactory<BookingListBloc>(
    () => BookingListBloc(
      bookingListUseCase: injector(),
    ),
  );
  injector.registerFactory<OneDayBloc>(
    () => OneDayBloc(
      oneDayUseCase: injector(),
    ),
  );
  injector.registerFactory<DiscountBloc>(
    () => DiscountBloc(
      discountUseCase: injector(),
    ),
  );
  injector.registerFactory<ChangePasswordBloc>(
    () => ChangePasswordBloc(
      changePasswordUseCase: injector(),
    ),
  );
  injector.registerFactory<TicketBloc>(
    () => TicketBloc(
      ticketUseCase: injector(),
    ),
  );

  injector.registerFactory<FavouriteRouteListDataBloc>(
        () => FavouriteRouteListDataBloc(
      favouriteRouteListUseCase: injector(),
    ),
  );

  injector.registerFactory<RoutesOnMapBloc>(
        () => RoutesOnMapBloc(
      routeOnMapUseCase: injector(),
    ),
  );

  injector.registerLazySingleton(() => SignupUserUseCase(injector()));
  injector.registerLazySingleton(() => QRUserUseCase(injector()));
  injector.registerLazySingleton(() => FareUseCase(injector()));
  injector.registerLazySingleton(() => ETAUseCase(injector()));
  injector.registerLazySingleton(() => ContactUsUseCase(injector()));
  injector.registerLazySingleton(() => RouteStopListUseCase(injector()));
  injector.registerLazySingleton(() => AddTransactionUseCase(injector()));
  injector.registerLazySingleton(() => AddFavouriteUseCase(injector()));

  injector.registerLazySingleton(() => LoginUserUseCase(injector()));

  injector.registerLazySingleton(() => MobileNumberLoginUseCase(injector()));

  injector.registerLazySingleton(() => NearmeRouteUseCase(injector()));

  injector.registerLazySingleton(() => VerifyOtpUseCase(injector()));

  injector.registerLazySingleton(() => FeedbackUseCase(injector()));

  injector.registerLazySingleton(() => HomeScreenUseCase(injector()));

  injector.registerLazySingleton(() => HomeGetRoutesUseCase(injector()));

  injector.registerLazySingleton(() => SearchResultRouteUseCase(injector()));

  injector.registerLazySingleton(() => ForgetPasswordUseCase(injector()));

  injector.registerLazySingleton(() => UserProfileUseCase(injector()));
  injector.registerLazySingleton(() => UserUpdateProfileUseCase(injector()));

  injector.registerLazySingleton(() => NotificationUseCase(injector()));

  injector.registerLazySingleton(() => FavouriteRouteListUseCase(injector()));

  injector.registerLazySingleton(() => DeleteRouteListUseCase(injector()));
  injector.registerLazySingleton(() => AddRouteUseCase(injector()));
  injector.registerLazySingleton(() => RouteDetailsUseCase(injector()));
  injector.registerLazySingleton(() => BookingListUseCase(injector()));
  injector.registerLazySingleton(() => OneDayUseCase(injector()));
  injector.registerLazySingleton(() => DiscountUseCase(injector()));
  injector.registerLazySingleton(() => ChangePasswordUseCase(injector()));
  injector.registerLazySingleton(() => PaymentUseCase(injector()));
  injector.registerLazySingleton(() => TicketUseCase(injector()));

  //injector.registerLazySingleton(() => FavouriteRouteListUseCase(injector()));
  injector.registerLazySingleton(() => RouteOnMapUseCase(injector()));
  injector.registerLazySingleton(() => FavouriteRouteListDataUseCase(injector()));

  injector.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
        apiClient: injector(), sharedPreferences: injector()),
  );

  injector.registerLazySingleton<RouteRepository>(
    () => RouteRepositoryImpl(
        apiClient: injector(), sharedPreferences: injector()),
  );
  injector.registerFactory<NearByStopsBloc>(
    () => NearByStopsBloc(injector()),
  );
  injector.registerLazySingleton(() => NearByStopsUseCase(injector()));
  injector.registerFactory<StopSearchDetailsBloc>(
    () => StopSearchDetailsBloc(routeStopListUseCase: injector()),
  );
}
