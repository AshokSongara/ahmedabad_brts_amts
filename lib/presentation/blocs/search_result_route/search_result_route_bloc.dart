import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/add_favourite_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/fare_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/search_route_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_event.dart';
import 'package:bloc/bloc.dart';

import 'search_result_route_state.dart';

class SearchResultRouteBloc
    extends Bloc<SearchResultRouteEvent, SearchResultRouteState> {
  SearchResultRouteBloc(
      {required this.searchResultRouteUseCase,
      required this.fareUseCase,
      required this.addFavouriteUseCase})
      : super(SearchResultRouteInitialState());

  final SearchResultRouteUseCase searchResultRouteUseCase;
  final FareUseCase fareUseCase;
  final AddFavouriteUseCase addFavouriteUseCase;

  @override
  Stream<SearchResultRouteState> mapEventToState(
      SearchResultRouteEvent event) async* {
    if (event is GetSearchResultRouteEvent) {
      yield SearchResultRouteLoadingState();
      SearchRouteResponse searchRouteResponse = await searchResultRouteUseCase(
          Params(data: event.searchRouteRequest));

      // for (int i = 0; i < searchRouteResponse.data!.length; i++) {
      RouteDetailsRequest routeDetailsRequest = RouteDetailsRequest();

      routeDetailsRequest.routeCode =
          searchRouteResponse.data![0].routeDetails![0].routeCode ?? "";

      if (searchRouteResponse.data![0].interChanges!.isNotEmpty) {
        routeDetailsRequest.startCode =
            searchRouteResponse.data![0].routeDetails![0].startStopCode;
        routeDetailsRequest.endCode = searchRouteResponse
            .data![0]
            .routeDetails![
                searchRouteResponse.data![0].routeDetails!.length - 1]
            .endStopCode;
      } else {
        routeDetailsRequest.startCode = searchRouteResponse
            .data![0].routeDetails![0].startStopCode
            .toString();
        routeDetailsRequest.endCode = searchRouteResponse
            .data![0].routeDetails![0].endStopCode
            .toString();
      }

      routeDetailsRequest.originStart = event.searchRouteRequest.startCode;

      routeDetailsRequest.originEnd = event.searchRouteRequest.endCode;

      routeDetailsRequest.serviceType = event.searchRouteRequest.serviceType;

      FareResponse fareResponse =
          await fareUseCase(Params(data: routeDetailsRequest));

      //searchRouteResponse.data![i].fare = fareResponse.data!.adult;

      searchRouteResponse.data?.forEach((element) {
        if (fareResponse.data != null) {
          element.fare = fareResponse.data!.adult;
        } else {
          element.fare = 0;
        }
      });
      //   }

      if (searchRouteResponse.succeeded == true) {
        yield SearchResultRouteSuccessState(
            searchRouteResponse: searchRouteResponse,
            value: false,
            error: false);
      } else {
        yield SearchResultRouteFailedState();
      }
    } else if (event is AddFavouriteRouteEvent) {
      yield AddFavouriteRouteLoadingState();

      AddFavouriteResponse addFavouriteResponse =
          await addFavouriteUseCase(Params(data: event.addFavouriteRequest));

      if (addFavouriteResponse.succeeded == true) {
        yield SearchResultRouteSuccessState(
            searchRouteResponse: event.searchRouteResponse,
            value: true,
            error: false);
      } else {
        yield SearchResultRouteSuccessState(
            searchRouteResponse: event.searchRouteResponse,
            value: true,
            error: true);
      }
    }
  }
}
