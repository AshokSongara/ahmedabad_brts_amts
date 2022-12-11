import 'package:ahmedabad_brts_amts/core/models/params.dart';
import 'package:ahmedabad_brts_amts/domain/usecases/user/home_screen_usecase.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_event.dart';
import 'package:ahmedabad_brts_amts/presentation/blocs/home/home_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenBloc extends Bloc<HomeEvent,HomeState>{
  HomeScreenBloc(this.homeScreenUseCase):super(SplashInitialState());
  HomeScreenUseCase homeScreenUseCase;
  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if(event is GetAvailableRoutesEvent){
      yield HomeLoadingState();
      var data = await homeScreenUseCase.call(Params(data: event.model));
      print("data.data?.length ${data.data?.length}");
      yield RoutesResponseState(data);
    }
  }
}