import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/nearme_route_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/near_by_map/near_by_map_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/near_by_map/near_by_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NearByMapBloc extends Bloc<NearByMapEvent,NearByMapState> {
  NearByMapBloc({required this.nearmeRouteUseCase}) : super(NearByMapInitialState());

  final NearmeRouteUseCase nearmeRouteUseCase;

  @override
  Stream<NearByMapState> mapEventToState(NearByMapEvent event) async* {
    if (event is NearByMapRouteEvent) {
      yield NearByMapLoadingState();
      NearMeResponse nearMeResponse =
      await nearmeRouteUseCase(Params(data: event.nearMeRequest));
      if (nearMeResponse.succeeded == true) {
        yield NearByMapSuccessState(nearMeResponse: nearMeResponse);
      } else {
        yield NearByMapFailState();
      }
    }
  }
}
