import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:equatable/equatable.dart';

abstract class NearMeEvent extends Equatable {
  const NearMeEvent();

  @override
  List<Object> get props => [];
}

class GetNearMeRouteEvent extends NearMeEvent {
  final NearMeRequest nearMeRequest;

  const GetNearMeRouteEvent({required this.nearMeRequest});

  @override
  List<Object> get props => [nearMeRequest];
}
