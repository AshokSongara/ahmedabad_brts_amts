import 'package:ahmedabad_brts_amts/data/requestmodels/search_route_request.dart';
import 'package:equatable/equatable.dart';

abstract class SearchResultRouteEvent extends Equatable {
  const SearchResultRouteEvent();

  @override
  List<Object> get props => [];
}

class GetSearchResultRouteEvent extends SearchResultRouteEvent {
  final SearchRouteRequest searchRouteRequest;
  GetSearchResultRouteEvent({required this.searchRouteRequest});

  @override
  List<Object> get props => [searchRouteRequest];
}
