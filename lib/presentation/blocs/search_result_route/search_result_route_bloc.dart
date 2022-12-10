import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/search_route_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_result_route/search_result_route_event.dart';
import 'package:bloc/bloc.dart';

import 'search_result_route_state.dart';

class SearchResultRouteBloc extends Bloc<SearchResultRouteEvent, SearchResultRouteState> {
  SearchResultRouteBloc({required this.searchResultRouteUseCase}) : super(SearchResultRouteInitialState());

  final SearchResultRouteUseCase searchResultRouteUseCase;

  @override
  Stream<SearchResultRouteState> mapEventToState(SearchResultRouteEvent event) async* {
    if (event is GetSearchResultRouteEvent) {
      yield SearchResultRouteLoadingState();
      SearchRouteResponse searchRouteResponse =
          await searchResultRouteUseCase(Params(data: event.searchRouteRequest));
      if (searchRouteResponse.succeeded == true) {
        yield SearchResultRouteSuccessState(searchRouteResponse: searchRouteResponse);
      } else {
        yield SearchResultRouteFailedState();
      }
    }
  }
}
