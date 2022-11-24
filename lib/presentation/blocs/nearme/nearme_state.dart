import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:equatable/equatable.dart';

abstract class NearmeState extends Equatable {
  const NearmeState();

  @override
  List<Object> get props => [];
}

class NearMeInitialState extends NearmeState {}

class NearMeLoadingState extends NearmeState {}

class NearMeSuccessState extends NearmeState {
  final NearMeResponse nearMeResponse;

  NearMeSuccessState({required this.nearMeResponse});

  @override
  List<Object> get props => [nearMeResponse];
}

class NearMeFailedState extends NearmeState {}
