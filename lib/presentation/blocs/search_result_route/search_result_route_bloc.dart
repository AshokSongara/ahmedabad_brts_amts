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
      {required this.searchResultRouteUseCase, required this.fareUseCase,required this.addFavouriteUseCase})
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

      for (int i = 0; i < searchRouteResponse.data!.length; i++) {
        RouteDetailsRequest routeDetailsRequest = RouteDetailsRequest();

        routeDetailsRequest.routeCode =
            searchRouteResponse.data![i].routeDetails![0].routeCode ?? "";

        if (searchRouteResponse.data![i].routes!.isNotEmpty) {
          routeDetailsRequest.startCode = event.searchRouteRequest.startCode;
          routeDetailsRequest.endCode = event.searchRouteRequest.endCode;
        } else {
          routeDetailsRequest.startCode = searchRouteResponse
              .data![i].routeDetails![0].startStopCode
              .toString();
          routeDetailsRequest.endCode = searchRouteResponse
              .data![i].routeDetails![0].endStopCode
              .toString();
        }

        routeDetailsRequest.originStart =
            searchRouteResponse.data![i].routeDetails![0].startStopCode ?? "";
        routeDetailsRequest.serviceType = event.searchRouteRequest.serviceType;

        //FareResponse fareResponse = FareResponse()

        FareResponse fareResponse =
            await fareUseCase(Params(data: routeDetailsRequest));

        searchRouteResponse.data![i].fare = fareResponse.data!.adult;
      }

      if (searchRouteResponse.succeeded == true) {
        yield SearchResultRouteSuccessState(
            searchRouteResponse: searchRouteResponse,value: false);
      } else {
        yield SearchResultRouteFailedState();
      }
    }else if (event is AddFavouriteRouteEvent) {
      yield AddFavouriteRouteLoadingState();

      AddFavouriteResponse addFavouriteResponse =
      await addFavouriteUseCase(Params(data: event.addFavouriteRequest));

      if (addFavouriteResponse.succeeded == true) {

        yield SearchResultRouteSuccessState(
            searchRouteResponse: event.searchRouteResponse,value: true);
      } else {
        yield AddFavouriteRouteFailedState();
      }
    }
  }
}
