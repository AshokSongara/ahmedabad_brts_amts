import 'dart:convert';

import 'package:ahmedabad_brts_amts/api/api_client.dart';
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
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../responsemodels/Nearby_stops_response_model.dart';

class RouteRepositoryImpl implements RouteRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  RouteRepositoryImpl(
      {required this.apiClient, required this.sharedPreferences});

  @override
  Future<NearMeResponse> nearMe(NearMeRequest body) async {
    Map data = {
      'stopType': body.stopType ?? "",
      'latitude': body.latitude ?? "",
      'longitude': body.longitude ?? "",
    };

    var bodyData = json.encode(data);

    Response response =
        await apiClient.postData(AppConstant.nearMeInterface, bodyData);
    NearMeResponse nearMeResponse = NearMeResponse.fromJson(response.body);

    return nearMeResponse;
  }

  @override
  Future<SearchRouteResponse> searchResultRoute(SearchRouteRequest body) async {
    Response response = await apiClient.getData(
        "${AppConstant.searchRouteList}${body.serviceType}${"/plan/start/"}${body.startCode}/end/${body.endCode}");
    SearchRouteResponse searchRouteResponse =
        SearchRouteResponse.fromJson(response.body);
    return searchRouteResponse;
  }

  @override
  Future<DeleteFavouriteResponse> deleteRoute(DeleteRouteRequest body) async {
    Map data = {};

    var bodyData = json.encode(data);

    Response response = await apiClient.postDataWithHeader(
        "${AppConstant.deleteFavouriteRoute}${body.routeId}", bodyData);
    DeleteFavouriteResponse deleteFavouriteResponse =
        DeleteFavouriteResponse.fromJson(response.body);
    return deleteFavouriteResponse;
  }

  @override
  Future<AddRouteResponse> addRoute(AddRouteRequest body) async {
    Map data = {};
    // BrtsRoutesResponseModel? model = isAmts
    //     ? getLocalAmtsRoutesData().get("key")
    //     : getLocalBrtsRoutesData().get("key");
    var bodyData = json.encode(data);

    Response response = await apiClient.postDataWithHeader(
        "${AppConstant.addFavouriteRoute}${body.routeID}", bodyData);
    AddRouteResponse addRouteResponse =
        AddRouteResponse.fromJson(response.body);
    if (!response.hasError) {
      body.isAmts
          ? getLocalAmtsRoutesData().putAt(0, body.model)
          : getLocalBrtsRoutesData().putAt(0, body.model);
    }
    return addRouteResponse;
  }

  @override
  Box<BrtsRoutesResponseModel> getLocalBrtsRoutesData() {
    return Hive.box<BrtsRoutesResponseModel>(AppConstant.brtsRoutesListBox);
  }

  @override
  Box<BrtsRoutesResponseModel> getLocalAmtsRoutesData() {
    return Hive.box<BrtsRoutesResponseModel>(AppConstant.amtsRoutesListBox);
  }

  @override
  Future<RouteDetailsRepsonse> getRouteDetails(
      RouteDetailsRequest routeDetailsRequest) async {
    print("###### Route/${routeDetailsRequest.routeCode}/stops/from/${routeDetailsRequest.fromHome == "Yes" ? routeDetailsRequest.startCode : routeDetailsRequest.startStopSequenceNumber}/to/${routeDetailsRequest.fromHome == "Yes" ? routeDetailsRequest.endCode : routeDetailsRequest.endStopSequenceNumber}");
    Response response = await apiClient.getData(
        "Route/${routeDetailsRequest.routeCode}/stops/from/${routeDetailsRequest.fromHome == "Yes" ? routeDetailsRequest.startCode : routeDetailsRequest.startStopSequenceNumber}/to/${routeDetailsRequest.fromHome == "Yes" ? routeDetailsRequest.endCode : routeDetailsRequest.endStopSequenceNumber}");
    RouteDetailsRepsonse routeDetailsRepsonse =
        RouteDetailsRepsonse.fromJson(response.body);
    return routeDetailsRepsonse;
  }

  @override
  Future<FareResponse> getFareDetails(
      RouteDetailsRequest routeDetailsRequest) async {
    FareResponse fareResponse;
    if (routeDetailsRequest.serviceType == "BRTS") {
      Response response = await apiClient.getDataWihHeader(
          "fare/BRTS/startStop/${routeDetailsRequest.startCode}/endStop/${routeDetailsRequest.endCode}");
      fareResponse = FareResponse.fromJson(response.body);
      return fareResponse;
    } else {
      Response response = await apiClient.getDataWihHeader(
          "Fare/AMTS/${routeDetailsRequest.routeCode?.replaceAll("/", "%2F")}/startStop/${routeDetailsRequest.startCode}/endStop/${routeDetailsRequest.endCode}");
      fareResponse = FareResponse.fromJson(response.body);
      return fareResponse;
    }
  }

  @override
  Future<ETAResponse> getETADetails(
      RouteDetailsRequest routeDetailsRequest) async {

    print("##### eta/${routeDetailsRequest.routeCode}/${routeDetailsRequest.originStart}");

    Response response = await apiClient.getDataWihHeader(
        "eta/${routeDetailsRequest.routeCode}/${routeDetailsRequest.originStart}");
    ETAResponse etaResponse = ETAResponse.fromJson(response.body);
    return etaResponse;
  }

  @override
  Future<RouteStopListResponse> getRouteStopList(
      RouteDetailsRequest routeDetailsRequest) async {
    Response response = await apiClient
        .getData("${AppConstant.stopLists}${routeDetailsRequest.routeCode}");
    RouteStopListResponse routeStopListResponse =
        RouteStopListResponse.fromJson(response.body);
    return routeStopListResponse;
  }
  @override
  Future<NearbyStopsResponseModel> nearbyStops(String routeCode) async{
    Response response = await apiClient.getData("Stop/$routeCode/upcoming-route-schedules");
    NearbyStopsResponseModel deleteFavouriteResponse =
    NearbyStopsResponseModel.fromJson(response.body);
    return deleteFavouriteResponse;
  }

  @override
  Future<AddFavouriteResponse> addFavourite(AddFavouriteRequest body) async {
    Map data = {};
    var bodyData = json.encode(data);

    Response response = await apiClient.postDataWithHeader(
        "Favourite/start/${body.startStop}/end/${body.endStop}", bodyData);
    AddFavouriteResponse addFavouriteResponse =
    AddFavouriteResponse.fromJson(response.body);
    return addFavouriteResponse;
  }

}
