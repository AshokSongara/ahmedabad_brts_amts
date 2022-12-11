import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/stop_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}
class SplashInitialState extends HomeState{}
class HomeLoadingState extends HomeState{}
class RoutesResponseState extends HomeState{
  BrtsStopResponseModel model;
  RoutesResponseState(this.model);
}