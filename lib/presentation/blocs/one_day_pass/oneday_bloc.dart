import 'dart:async';
import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/one_day_pass_response.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/route/oneday_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/one_day_pass/oneday_state.dart';

class OneDayBloc extends Bloc<OneDayEvent, OneDayState> {
  OneDayBloc({required this.oneDayUseCase}) : super(OneDayInitialState());

  final OneDayUseCase oneDayUseCase;

  @override
  Stream<OneDayState> mapEventToState(OneDayEvent event) async* {
    if (event is GetOneDayEvent) {
      yield OneDayLoadingState();
      OneDayPassResponse oneDayPassResponse =
          await oneDayUseCase(Params(data: ""));
      if (oneDayPassResponse.succeeded == true) {
        yield OneDaySuccessState(oneDayPassResponse: oneDayPassResponse);
      } else {
        yield OneDayFailedState();
      }
    }
  }
}
