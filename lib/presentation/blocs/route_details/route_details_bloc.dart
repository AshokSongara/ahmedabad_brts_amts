import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_details_route_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_state.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route_details_event.dart';

class RouteDetailsBloc extends Bloc<RouteDetailsEvent, RouteDetailsState> {
  RouteDetailsBloc({required this.routeDetailsUseCase})
      : super(RouteDetailsInitialState());

  final RouteDetailsUseCase routeDetailsUseCase;

  @override
  Stream<RouteDetailsState> mapEventToState(RouteDetailsEvent event) async* {
    if (event is GetRouteDetailsEvent) {
      yield RouteDetailsLoadingState();
      RouteDetailsRepsonse routeDetailsRepsonse =
          await routeDetailsUseCase(Params(data: event.request));

      if (routeDetailsRepsonse.succeeded == true) {
        yield RouteDetailsSuccessState(
            routeDetailsRepsonse: routeDetailsRepsonse);
      } else {
        yield const RouteDetailsFailedState(
            errorMessage: "Something Went Wrong");
      }
    }
  }

  saveMemberID(UserProfileResponse userProfileResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        AppConstant.name, userProfileResponse.data?.firstName ?? "");
    prefs.setString(
        AppConstant.lastName, userProfileResponse.data?.lastName ?? "");
  }

  saveToken(LoginResponse loginResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        AppConstant.accessToken, loginResponse.data?.accessToken ?? "");
  }
}
