import 'dart:async';

import 'package:ahmedabad_brts_amts/data/requestmodels/delete_route_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/delete_favourite_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/delete_route_list_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_routes_response_list.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/favourite_route_list_data_usecase.dart';

import 'favourite_list_data_event.dart';
import 'favourite_list_data_state.dart';

class FavouriteRouteListDataBloc
    extends Bloc<FavouriteRouteListDataEvent, FavouriteRouteListState> {
  FavouriteRouteListDataBloc(
      {required this.favouriteRouteListUseCase, required this.deleteRouteListUseCase})
      : super(FavouriteRouteInitialState());

  final FavouriteRouteListDataUseCase favouriteRouteListUseCase;
  FavouriteRoutesResponseList? favouriteRouteResponse;
  final DeleteRouteListUseCase deleteRouteListUseCase;


  @override
  Stream<FavouriteRouteListState> mapEventToState(
      FavouriteRouteListDataEvent event) async* {
    if (event is GetFavouriteRouteListEvent) {
      yield FavouriteRouteLoadingState();
      favouriteRouteResponse =
          await favouriteRouteListUseCase( Params(data: event.serviceType));
      if (favouriteRouteResponse?.succeeded == true) {
        yield FavouriteRouteSuccessState(
            favouriteRouteResponse: favouriteRouteResponse!);
      } else {
        yield const FavouriteRouteFailedState(errorMessage: "Something Went Wrong");
      }
    } else if (event is DeleteFavouriteRouteListEvent) {
      yield FavouriteRouteLoadingState();
      DeleteFavouriteResponse deleteFavouriteResponse =
      await deleteRouteListUseCase(Params(data: DeleteRouteRequest(routeId: event.routeId)));
      if (deleteFavouriteResponse.succeeded == true) {
        yield FavouriteDeleteRouteListSuccessState(
            favouriteRouteResponse: deleteFavouriteResponse);
      } else {
        yield const FavouriteRouteFailedState(errorMessage: "Something Went Wrong");
      }
    }
  }
}
