import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/nearme_route_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/login_user_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/login/login_state.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/nearme/nearme_state.dart';
import 'package:bloc/bloc.dart';

class NearMeBloc extends Bloc<NearMeEvent, NearmeState> {
  NearMeBloc({required this.nearmeRouteUseCase}) : super(NearMeInitialState());

  final NearmeRouteUseCase nearmeRouteUseCase;

  @override
  Stream<NearmeState> mapEventToState(NearMeEvent event) async* {
    if (event is GetNearMeRouteEvent) {
      yield NearMeLoadingState();
      NearMeResponse nearMeResponse =
          await nearmeRouteUseCase(Params(data: event.nearMeRequest));
      if (nearMeResponse.succeeded == true) {
        yield NearMeSuccessState(nearMeResponse: nearMeResponse);
      } else {
        yield NearMeFailedState();
      }
    }
  }
}
