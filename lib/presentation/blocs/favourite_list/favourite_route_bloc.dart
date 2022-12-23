import 'dart:async';

import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/delete_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_route_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/delete_route_list_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/favourite_route_list_usecase.dart';
import 'package:bloc/bloc.dart';

import 'favourite_list_event.dart';
import 'favourite_list_state.dart';

class FavouriteRouteListBloc
    extends Bloc<FavouriteRouteListEvent, FavouriteRouteListState> {
  FavouriteRouteListBloc(
      {required this.favouriteRouteListUseCase,
      required this.deleteRouteListUseCase})
      : super(FavouriteRouteInitialState());

  final FavouriteRouteListUseCase favouriteRouteListUseCase;
  final DeleteRouteListUseCase deleteRouteListUseCase;

  @override
  Stream<FavouriteRouteListState> mapEventToState(
      FavouriteRouteListEvent event) async* {
    if (event is GetFavouriteRouteListEvent) {
      yield FavouriteRouteLoadingState();
      FavouriteRouteResponse favouriteRouteResponse =
          await favouriteRouteListUseCase(Params(data: ""));
      if (favouriteRouteResponse.succeeded == true) {
        yield FavouriteRouteSuccessState(
            favouriteRouteResponse: favouriteRouteResponse);
      } else {
        yield FavouriteRouteFailedState(errorMessage: "Something Went Wrong");
      }
    } else if (event is DeleteFavouriteRouteEvent) {
      yield FavouriteRouteLoadingState();
      DeleteFavouriteResponse deleteFavouriteResponse =
          await deleteRouteListUseCase(Params(data: event.routeId));

      // if (deleteFavouriteResponse.succeeded == true) {
      //   yield FavouriteRouteSuccessState(
      //       favouriteRouteResponse: favouriteRouteResponse);
      // } else {
      //   yield FavouriteRouteFailedState(errorMessage: "Something Went Wrong");
      // }
    }
  }
}
