import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/add_route_stoplist_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/route_stoplist_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/onTapFav/ontap_fav_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/onTapFav/ontap_fav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnTapFavDetailsBloc
    extends Bloc<OnTapDetailsEvent, OnTapFavDetailsState> {
  OnTapFavDetailsBloc(
      {required this.routeStopListUseCase,
        required this.addRouteStopListUseCase})
      : super(OnTapFavDetailsInitialState());

  final RouteStopListUseCase routeStopListUseCase;
  final AddRouteStopListUseCase addRouteStopListUseCase;

  @override
  Stream<OnTapFavDetailsState> mapEventToState(
      OnTapDetailsEvent event) async* {
    if (event is GetOnTapDetailsEvent) {
      yield OnTapFavDetailsLoadingState();

      RouteStopListResponse routeStopListResponse =
      await routeStopListUseCase(Params(data: event.request));

      if (routeStopListResponse.succeeded == true) {
        yield OnTapFavSuccessState(
            routeStopListResponse: routeStopListResponse,
            error: false,
            value: false);
      } else {
        yield const OnTapFavFailedState(errorMessage: "Something Went Wrong");
      }
    } else if (event is AddFavouriteRouteEvent) {
      yield AddFavouriteRouteLoadingState();

      AddFavouriteResponse addFavouriteResponse =
      await addRouteStopListUseCase(Params(data: event.request));

      if (addFavouriteResponse.succeeded == true) {
        yield OnTapFavSuccessState(
            routeStopListResponse: event.routeStopListResponse,
            value: true,
            error: false);
      } else {
        yield OnTapFavSuccessState(
            value: true,
            error: true,
            routeStopListResponse: event.routeStopListResponse);
      }
    }
  }
}