import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/search_route_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';

abstract class RouteRepository {
  Future<NearMeResponse> nearMe(NearMeRequest body);
  Future<SearchRouteResponse> searchResultRoute(SearchRouteRequest body);
}
