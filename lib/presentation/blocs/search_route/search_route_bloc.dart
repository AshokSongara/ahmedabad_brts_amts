import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/add_route_stoplist_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_route/search_route_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/search_route/search_route_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchRouteBloc extends Bloc<SearchRouteEvent, SearchRouteState> {
  AddRouteStopListUseCase useCase;

  SearchRouteBloc(this.useCase) : super(SearchRouteInitialState());

  @override
  Stream<SearchRouteState> mapEventToState(SearchRouteEvent event) async* {
    if (event is SearchRouteFavoriteEvent) {
      if (event.status) {
        AddFavouriteResponse response =
            await useCase.call(Params(data: event.request));
        if(response.succeeded!=true){
          yield(SearchRouteAddFavFailureState(message: "Favourite Not Added..!"));
        }else{
          yield(SearchRouteAddFavState(response: response));
        }
      } else {
        yield(SearchRouteRemoveFavState());
      }
    }
  }
}
