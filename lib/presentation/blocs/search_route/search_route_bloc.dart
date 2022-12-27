import 'package:ahmedabad_brts_amts/data/responsemodels/add_route_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/add_route_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_route/search_route_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_route/search_route_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchRouteBloc extends Bloc<SearchRouteEvent, SearchRouteState> {
  AddRouteUseCase useCase;

  SearchRouteBloc(this.useCase) : super(SearchRouteInitialState());

  @override
  Stream<SearchRouteState> mapEventToState(SearchRouteEvent event) async* {
    if (event is SearchRouteFavoriteEvent) {
      if (event.status) {
        AddRouteResponse response =
            await useCase.routeRepository.addRoute(event.request);
        if(response.succeeded!=true){
          yield(SearchRouteAddFavFailureState(message: "Please try again later!"));
        }else{
          yield(SearchRouteAddFavState(response: response));
        }
      } else {
        yield(SearchRouteRemoveFavState());
      }
    }
  }
}
