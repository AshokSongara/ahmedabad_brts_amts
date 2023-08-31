import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}
class SplashInitialState extends HomeState{}
class HomeLoadingState extends HomeState{}
class StopsResponseState extends HomeState{
  final BrtsStopResponseModel model;
  const StopsResponseState(this.model);
}
class RoutesResponseState extends HomeState{
  final BrtsRoutesResponseModel model;
  const RoutesResponseState(this.model);
}
class SourceSelectionFromMapScreenState extends HomeState{
  final DataHive data;
  const SourceSelectionFromMapScreenState(this.data);

  @override
  List<Object> get props => [data];
}

class SourceSelectionFromFavScreenState extends HomeState{
  final DataHive data;
  const SourceSelectionFromFavScreenState(this.data);

  @override
  List<Object> get props => [data];
}

class SourceSelectionFromSearchBusRouteScreenState extends HomeState{
  final DataHive data;
  const SourceSelectionFromSearchBusRouteScreenState(this.data);

  @override
  List<Object> get props => [data];
}

class TicketBookState extends HomeState{
  final BrtsStopResponseModel model;

  const TicketBookState(this.model);
}

class ReturnHomeState extends HomeState{
  final BrtsStopResponseModel model;

  const ReturnHomeState(this.model);
}
