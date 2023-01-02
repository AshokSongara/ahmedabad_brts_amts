import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:equatable/equatable.dart';

abstract class NearByMapEvent extends Equatable {
  const NearByMapEvent();

  @override
  List<Object> get props => [];
}

class NearByMapRouteEvent extends NearByMapEvent {
  final NearMeRequest nearMeRequest;

  NearByMapRouteEvent({required this.nearMeRequest});

  @override
  List<Object> get props => [nearMeRequest];
}
