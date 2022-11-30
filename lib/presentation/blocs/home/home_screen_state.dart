import 'package:ahmedabad_brts_amts/data/responsemodels/stop_response_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}
class SplashInitialState extends HomeState{}
class RoutesResponseState extends HomeState{
  StopResponseModel model;
  RoutesResponseState(this.model);
}