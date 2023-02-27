import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/models/params.dart';
import '../../../data/responsemodels/Nearby_stops_response_model.dart';
import '../../../domain/usecases/nearby_stops_usecase.dart';
import 'nearby_stops_event.dart';
import 'nearby_stops_state.dart';


class NearByStopsBloc extends Bloc<NearByStopsEvent,NearByStopsState>{
  NearByStopsUseCase useCase;
  NearByStopsBloc(this.useCase) : super(NearByStopsInitialState());
  @override
  Stream<NearByStopsState> mapEventToState(NearByStopsEvent event) async* {
    if(event is GetNearByStopsEvent){
      yield GetNearByStopsLoadingState();
      NearbyStopsResponseModel model = await useCase.call(Params(data:event.routeId));
      yield NearByStopsResponseState(model);
    }
  }
}