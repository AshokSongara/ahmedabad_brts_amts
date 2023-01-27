import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/eta_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/eta_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/fare_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_details_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_stoplist_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/route_details/route_details_state.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'route_details_event.dart';

class RouteDetailsBloc extends Bloc<RouteDetailsEvent, RouteDetailsState> {
  RouteDetailsBloc(
      {required this.routeDetailsUseCase,
      required this.fareUseCase,
      required this.etaUseCase,
      required this.routeStopListUseCase})
      : super(RouteDetailsInitialState());

  final RouteDetailsUseCase routeDetailsUseCase;
  final FareUseCase fareUseCase;
  final ETAUseCase etaUseCase;
  final RouteStopListUseCase routeStopListUseCase;

  @override
  Stream<RouteDetailsState> mapEventToState(RouteDetailsEvent event) async* {
    if (event is GetRouteDetailsEvent) {
      yield RouteDetailsLoadingState();

      if (event.request.fromHome == "Yes") {
        RouteStopListResponse routeStopListResponse =
            await routeStopListUseCase(Params(data: event.request));

        RouteDetailsRequest routeDetailsRequest = RouteDetailsRequest();

        routeDetailsRequest.routeCode = event.request.routeCode;
        routeDetailsRequest.startCode = routeStopListResponse.data![0].stopCode;
        routeDetailsRequest.originStart =
            routeStopListResponse.data![0].stopCode;
        int length = routeStopListResponse.data!.length;
        routeDetailsRequest.endCode =
            routeStopListResponse.data![length - 1].stopCode.toString();
        routeDetailsRequest.fromHome = event.request.fromHome;
        routeDetailsRequest.serviceType = event.request.serviceType;

        RouteDetailsRepsonse routeDetailsRepsonse =
            await routeDetailsUseCase(Params(data: routeDetailsRequest));

        FareResponse fareResponse =
            await fareUseCase(Params(data: routeDetailsRequest));

        ETAResponse etaResponse =
            await etaUseCase(Params(data: routeDetailsRequest));

        if (routeDetailsRepsonse.succeeded == true) {
          yield RouteDetailsSuccessState(
              routeDetailsResponse: routeDetailsRepsonse,
              fareResponse: fareResponse,
              etaResponse: etaResponse,
              routeStopListResponse: routeStopListResponse,
              routeDetailsResponse1: routeDetailsRepsonse);
        } else {
          yield const RouteDetailsFailedState(
              errorMessage: "Something Went Wrong");
        }
      } else {
        if (event.request.routeTwo!.isNotEmpty) {
          RouteDetailsRepsonse routeDetailsRepsonse =
              await routeDetailsUseCase(Params(data: event.request));

          RouteDetailsRequest req = RouteDetailsRequest();

          req.startCode = event.request.startRouteTwo;
          req.endCode = event.request.endRouteTwo;
          req.routeCode = event.request.routeTwo;

          RouteDetailsRepsonse routeDetailsRepsonse1 =
              await routeDetailsUseCase(Params(data: req));

          FareResponse fareResponse =
              await fareUseCase(Params(data: event.request));

          ETAResponse etaResponse =
              await etaUseCase(Params(data: event.request));

          if (routeDetailsRepsonse.succeeded == true) {
            RouteStopListResponse routeStopListResponse =
                RouteStopListResponse();

            yield RouteDetailsSuccessState(
                routeDetailsResponse: routeDetailsRepsonse,
                fareResponse: fareResponse,
                etaResponse: etaResponse,
                routeStopListResponse: routeStopListResponse,
                routeDetailsResponse1: routeDetailsRepsonse1);
          } else {
            yield const RouteDetailsFailedState(
                errorMessage: "Something Went Wrong");
          }
        } else {
          RouteDetailsRepsonse routeDetailsRepsonse =
              await routeDetailsUseCase(Params(data: event.request));

          FareResponse fareResponse =
              await fareUseCase(Params(data: event.request));

          ETAResponse etaResponse =
              await etaUseCase(Params(data: event.request));

          if (routeDetailsRepsonse.succeeded == true) {
            RouteStopListResponse routeStopListResponse =
                RouteStopListResponse();

            yield RouteDetailsSuccessState(
                routeDetailsResponse: routeDetailsRepsonse,
                fareResponse: fareResponse,
                etaResponse: etaResponse,
                routeStopListResponse: routeStopListResponse,
                routeDetailsResponse1: routeDetailsRepsonse);
          } else {
            yield const RouteDetailsFailedState(
                errorMessage: "Something Went Wrong");
          }
        }
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
