import 'dart:convert';
import 'package:ahmedabad_brts_amts/api/api_checker.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../data/responseModels/error_response.dart';

class ApiClient extends GetxService {
  final String? appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 60;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstant.accessToken);
    updateHeader(token ?? "");
  }

  void updateHeader(String token) {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    };
    _mainHeaders = header;
  }

  Future<Response> postData(String endPoint, String body) async {
    try {
      http.Response response = await http.post(
        Uri.parse(appBaseUrl! + endPoint),
        body: body,
        headers: {"Content-Type": "application/json"},
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, endPoint);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postDataWithHeader(String endPoint, String body) async {
    try {
      print(appBaseUrl! + endPoint);
      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl! + endPoint),
            body: body,
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, endPoint);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      if (foundation.kDebugMode) {}
      http.Response httpResponse = await http.get(
        Uri.parse(appBaseUrl! + uri),
        headers: {
          'Content-Type': 'application/json',
        },
      ).timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(httpResponse, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> getDataWihHeader(String uri,
      {Map<String, String>? headers}) async {
    try {
      http.Response httpResponse = await http
          .get(
            Uri.parse(appBaseUrl! + uri),
            headers: _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(httpResponse, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> handleResponse(http.Response response, String uri) async {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    print('====> API Body:$body _response $_response');
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: errorResponse.errors![0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    } else if (_response.statusCode == 401) {
      ApiChecker.checkApi(_response);
    }
    return _response;
  }
}
