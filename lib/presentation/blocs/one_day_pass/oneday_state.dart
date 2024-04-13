import 'package:equatable/equatable.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/one_day_pass_response.dart';

abstract class OneDayState extends Equatable {
  const OneDayState();

  @override
  List<Object> get props => [];
}

class OneDayInitialState extends OneDayState {}

class OneDayLoadingState extends OneDayState {}

class OneDaySuccessState extends OneDayState {
  final OneDayPassResponse oneDayPassResponse;

  OneDaySuccessState({required this.oneDayPassResponse});

  @override
  List<Object> get props => [oneDayPassResponse];
}

class OneDayFailedState extends OneDayState {}
