import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/add_route_stoplist_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_stoplist_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/on_tap_search_bus_route/on_tap_search_bus_route_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/on_tap_search_bus_route/on_tap_search_bus_route_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTapSearchBusRouteDetailsBloc
    extends Bloc<OnTapSearchBusRouteDetailsEvent, OnTapSearchBusRouteDetailsState> {
  OnTapSearchBusRouteDetailsBloc(
      {required this.routeStopListUseCase,
        required this.addRouteStopListUseCase})
      : super(OnTapSearchBusRouteDetailsInitialState());

  final RouteStopListUseCase routeStopListUseCase;
  final AddRouteStopListUseCase addRouteStopListUseCase;

  @override
  Stream<OnTapSearchBusRouteDetailsState> mapEventToState(
      OnTapSearchBusRouteDetailsEvent event) async* {
    if (event is GetOnTapSearchBusRouteDetailsEvent) {
      yield OnTapSearchBusRouteDetailsLoadingState();

      RouteStopListResponse routeStopListResponse =
      await routeStopListUseCase(Params(data: event.request));

      if (routeStopListResponse.succeeded == true) {
        yield OnTapSearchBusRouteSuccessState(
            routeStopListResponse: routeStopListResponse,
            error: false,
            value: false);
      } else {
        yield const OnTapSearchBusRouteFailedState(errorMessage: "Something Went Wrong");
      }
    } else if (event is AddFavouriteRouteEvent) {
      yield AddFavouriteRouteLoadingState();

      AddFavouriteResponse addFavouriteResponse =
      await addRouteStopListUseCase(Params(data: event.request));

      if (addFavouriteResponse.succeeded == true) {
        yield OnTapSearchBusRouteSuccessState(
            routeStopListResponse: event.routeStopListResponse,
            value: true,
            error: false);
      } else {
        yield OnTapSearchBusRouteSuccessState(
            value: true,
            error: true,
            routeStopListResponse: event.routeStopListResponse);
      }
    }
  }
}