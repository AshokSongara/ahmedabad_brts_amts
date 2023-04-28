import 'dart:async';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/add_route_stoplist_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/params.dart';
import '../../../data/responsemodels/route_stoplist_response.dart';
import '../../../domain/usecases/route/route_stoplist_usecase.dart';
import 'stop_search_event.dart';
import 'stop_search_state.dart';

class StopSearchDetailsBloc
    extends Bloc<StopSearchDetailsEvent, StopSearchDetailsState> {
  StopSearchDetailsBloc(
      {required this.routeStopListUseCase,
      required this.addRouteStopListUseCase})
      : super(StopSearchDetailsInitialState());

  final RouteStopListUseCase routeStopListUseCase;
  final AddRouteStopListUseCase addRouteStopListUseCase;

  @override
  Stream<StopSearchDetailsState> mapEventToState(
      StopSearchDetailsEvent event) async* {
    if (event is GetStopSearchDetailsEvent) {
      yield StopSearchDetailsLoadingState();

      RouteStopListResponse routeStopListResponse =
          await routeStopListUseCase(Params(data: event.request));

      if (routeStopListResponse.succeeded == true) {
        yield StopSearchSuccessState(
            routeStopListResponse: routeStopListResponse,
            error: false,
            value: false);
      } else {
        yield const StopSearchFailedState(errorMessage: "Something Went Wrong");
      }
    } else if (event is AddFavouriteRouteEvent) {
      yield AddFavouriteRouteLoadingState();

      AddFavouriteResponse addFavouriteResponse =
          await addRouteStopListUseCase(Params(data: event.request));

      if (addFavouriteResponse.succeeded == true) {
        yield StopSearchSuccessState(
            routeStopListResponse: event.routeStopListResponse,
            value: true,
            error: false);
      } else {
        yield StopSearchSuccessState(
            value: false,
            error: true,
            routeStopListResponse: event.routeStopListResponse);
      }
    }
  }
}
