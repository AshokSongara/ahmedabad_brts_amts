import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/home_get_routes_usecase.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/home_screen_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeEvent,HomeState>{
  HomeScreenBloc(this.homeScreenUseCase,this.homeGetRoutesUseCase):super(SplashInitialState());
  HomeScreenUseCase homeScreenUseCase;
  HomeGetRoutesUseCase homeGetRoutesUseCase;
  BrtsStopResponseModel? brtsStopResponseModel;
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is GetAvailableStopsEvent){
      yield HomeLoadingState();
      BrtsStopResponseModel data = await homeScreenUseCase.call(Params(data: event.model));
      print("GetAvailableStopsEvent data.data?.length ${data.data?.length}");
      brtsStopResponseModel=data;
      yield StopsResponseState(data);
    }
    else if(event is SourceSelectionFromMapScreenEvent){
      yield SourceSelectionFromMapScreenState(event.data);
    }
    if(event is GetAvailableRoutesEvent){
      // yield HomeLoadingState();
      var data = await homeGetRoutesUseCase.call(Params(data: event.model));
      print(" GetAvailableRoutesEvent data.data?.length ${data.data?.length}");
      yield RoutesResponseState(data);
      yield StopsResponseState(brtsStopResponseModel!);
    }
  }
}