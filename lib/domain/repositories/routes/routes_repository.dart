import 'package:ahmedabad_brts_amts/data/requestmodels/add_favourite_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/add_route_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/delete_route_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/route_details_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/search_route_request.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/add_route_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/delete_favourite_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/eta_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/fare_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_details_repsonse.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/route_stoplist_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/search_route_response.dart';
import 'package:hive/hive.dart';

import '../../../data/responsemodels/Nearby_stops_response_model.dart';

abstract class RouteRepository {
  Future<NearMeResponse> nearMe(NearMeRequest body);
  Future<SearchRouteResponse> searchResultRoute(SearchRouteRequest body);
  Future<DeleteFavouriteResponse> deleteRoute(DeleteRouteRequest body);
  Future<AddRouteResponse> addRoute(AddRouteRequest body);
  Box<BrtsRoutesResponseModel> getLocalBrtsRoutesData();
  Box<BrtsRoutesResponseModel> getLocalAmtsRoutesData();
  Future<RouteDetailsRepsonse> getRouteDetails(RouteDetailsRequest routeDetailsRequest);
  Future<FareResponse> getFareDetails(RouteDetailsRequest routeDetailsRequest);
  Future<ETAResponse> getETADetails(RouteDetailsRequest routeDetailsRequest);
  Future<RouteStopListResponse> getRouteStopList(RouteDetailsRequest routeDetailsRequest);
  Future<NearbyStopsResponseModel> nearbyStops(String routeCode);
  Future<AddFavouriteResponse> addFavourite(AddFavouriteRequest body);
}
