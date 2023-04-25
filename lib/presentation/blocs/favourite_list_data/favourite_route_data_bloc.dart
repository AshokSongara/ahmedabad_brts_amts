import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_routes_response_list.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/favourite_route_list_data_usecase.dart';

import 'favourite_list_data_event.dart';
import 'favourite_list_data_state.dart';

class FavouriteRouteListDataBloc
    extends Bloc<FavouriteRouteListDataEvent, FavouriteRouteListState> {
  FavouriteRouteListDataBloc(
      {required this.favouriteRouteListUseCase})
      : super(FavouriteRouteInitialState());

  final FavouriteRouteListDataUseCase favouriteRouteListUseCase;
  FavouriteRoutesResponseList? favouriteRouteResponse;

  @override
  Stream<FavouriteRouteListState> mapEventToState(
      FavouriteRouteListDataEvent event) async* {
    if (event is GetFavouriteRouteListEvent) {
      yield FavouriteRouteLoadingState();
      favouriteRouteResponse =
          await favouriteRouteListUseCase( Params(data: ""));
      if (favouriteRouteResponse?.succeeded == true) {
        yield FavouriteRouteSuccessState(
            favouriteRouteResponse: favouriteRouteResponse!);
      } else {
        yield const FavouriteRouteFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
