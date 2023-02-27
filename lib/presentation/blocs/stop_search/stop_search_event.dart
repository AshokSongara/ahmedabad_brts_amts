import 'package:equatable/equatable.dart';

import '../../../data/requestmodels/route_details_request.dart';

abstract class StopSearchDetailsEvent extends Equatable {
  const StopSearchDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetStopSearchDetailsEvent extends StopSearchDetailsEvent {
  final RouteDetailsRequest request;

  GetStopSearchDetailsEvent({required this.request});

  @override
  List<Object> get props => [request];
}
