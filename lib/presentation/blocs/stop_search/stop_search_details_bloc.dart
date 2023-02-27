import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/params.dart';
import '../../../data/responsemodels/route_stoplist_response.dart';
import '../../../domain/usecases/route/route_stoplist_usecase.dart';
import 'stop_search_event.dart';
import 'stop_search_state.dart';

class StopSearchDetailsBloc
    extends Bloc<StopSearchDetailsEvent, StopSearchDetailsState> {
  StopSearchDetailsBloc({required this.routeStopListUseCase})
      : super(StopSearchDetailsInitialState());

  final RouteStopListUseCase routeStopListUseCase;

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
        );
      } else {
        yield const StopSearchFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
