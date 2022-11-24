import 'dart:convert';
import 'dart:math';

import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/nearme_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/nearme_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/routes/routes_repository.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    try {} on Exception catch (exception) {
    } catch (error) {}
    return nearMeResponse;
  }
}
