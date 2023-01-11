import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/eta_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/eta_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/fare_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_details_route_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_state.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route_details_event.dart';

class RouteDetailsBloc extends Bloc<RouteDetailsEvent, RouteDetailsState> {
  RouteDetailsBloc(
      {required this.routeDetailsUseCase,
      required this.fareUseCase,
      required this.etaUseCase})
      : super(RouteDetailsInitialState());

  final RouteDetailsUseCase routeDetailsUseCase;
  final FareUseCase fareUseCase;
  final ETAUseCase etaUseCase;

  @override
  Stream<RouteDetailsState> mapEventToState(RouteDetailsEvent event) async* {
    if (event is GetRouteDetailsEvent) {
      yield RouteDetailsLoadingState();
      RouteDetailsRepsonse routeDetailsRepsonse =
          await routeDetailsUseCase(Params(data: event.request));

      FareResponse fareResponse =
          await fareUseCase(Params(data: event.request));

      ETAResponse etaResponse = await etaUseCase(Params(data: event.request));

      if (routeDetailsRepsonse.succeeded == true) {
        yield RouteDetailsSuccessState(
            routeDetailsRepsonse: routeDetailsRepsonse,
            fareResponse: fareResponse,
            etaResponse: etaResponse);
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
