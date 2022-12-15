import 'dart:convert';
import 'dart:io';
import 'package:get/get_connect/http/src/request/request.dart';

import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;

import '../data/responseModels/error_response.dart';

class ApiClient extends GetxService {
  final String? appBaseUrl;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 60;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl}) {
    // updateHeader(
    //   token, _addressModel == null ? null : _addressModel.zoneIds,
    //   sharedPreferences.getString(AppConstants.LANGUAGE_CODE), _moduleID,
    // );
  }

  Future<Response> postData(String endPoint, String body) async {
    try {
      print(appBaseUrl! + endPoint);
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

  Future<Response> postApiFile(
      {required String endPoint,
      required Map<String, File?> fileList,
      required Map<String, String?> body}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl! + endPoint));

      body.forEach((key, value) {
        request.fields[key] = value!;
      });

      if (fileList.isNotEmpty) {
        for (var key in fileList.keys.toList()) {
          var pic = await http.MultipartFile.fromPath(key, fileList[key]!.path);
          request.files.add(pic);
        }
      }
      print("postApiFile:   $request");
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      var response = String.fromCharCodes(responseData);

      print("postApiFile: responseData   $responseData");
      print("postApiFile: response   $response");
      if (res.statusCode == 200) {
        final res = json.decode(response);
        print("postApiFile: res res res   $res");
        return handleResponse(res, endPoint);
      } else {
        return Response(statusCode: 1, statusText: noInternetMessage);
      }
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<dynamic> postApiFile2(
      {required String endPoint,
      required Map<String, File?> fileList,
      required Map<String, String?> body}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl! + endPoint));

      body.forEach((key, value) {
        request.fields[key] = value!;
      });

      if (fileList.isNotEmpty) {
        for (var key in fileList.keys.toList()) {
          var pic = await http.MultipartFile.fromPath(key, fileList[key]!.path);
          request.files.add(pic);
        }
      }
      print("postApiFile:   $request");
      var res = await request.send();
      var responseData = await res.stream.toBytes();
      var response = String.fromCharCodes(responseData);

      print("postApiFile: responseData   $responseData");
      print("postApiFile: response   $response");
      if (res.statusCode == 200) {
        final res = json.decode(response);
        print("postApiFile: res res res   $res");
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Response> postDataWithHeader(
      String uri, dynamic body, Map<String, String> headers) async {
    try {
      if (foundation.kDebugMode) {
        print('====> API Call: $uri\nHeader: $_mainHeaders');
        print('====> API Body: $body');
      }
      http.Response _response = await http
          .post(
            Uri.parse(appBaseUrl! + uri),
            body: jsonEncode(body),
            headers: headers,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      if (foundation.kDebugMode) {
        // print('====> API Call: $uri\nHeader: $_mainHeaders');
      }
      http.Response _response = await http
          .get(
            Uri.parse(appBaseUrl! + uri),
            headers: headers,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );

    print('====> API Body:$_body _response $_response');
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse _errorResponse = ErrorResponse.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.errors![0].message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    return _response;
  }
}

// Future<Response> putData(String uri, dynamic body, {Map<String, String> headers}) async {
//   try {
//     if(Foundation.kDebugMode) {
//       print('====> API Call: $uri\nHeader: $_mainHeaders');
//       print('====> API Body: $body');
//     }
//     Http.Response _response = await Http.put(
//       Uri.parse(appBaseUrl+uri),
//       body: jsonEncode(body),
//       headers: headers ?? _mainHeaders,
//     ).timeout(Duration(seconds: timeoutInSeconds));
//     return handleResponse(_response, uri);
//   } catch (e) {
//     return Response(statusCode: 1, statusText: noInternetMessage);
//   }
// }

// Future<Response> postMultipartData(String uri, Map<String, String> body, List<MultipartBody> multipartBody, {Map<String, String> headers}) async {
//   try {
//     if(Foundation.kDebugMode) {
//       print('====> API Call: $uri\nHeader: $_mainHeaders');
//       print('====> API Body: $body with ${multipartBody.length} picture');
//     }
//     Http.MultipartRequest _request = Http.MultipartRequest('POST', Uri.parse(appBaseUrl+uri));
//     _request.headers.addAll(headers ?? _mainHeaders);
//     for(MultipartBody multipart in multipartBody) {
//       if(multipart.file != null) {
//         Uint8List _list = await multipart.file.readAsBytes();
//         _request.files.add(Http.MultipartFile(
//           multipart.key, multipart.file.readAsBytes().asStream(), _list.length,
//           filename: '${DateTime.now().toString()}.png',
//         ));
//       }
//     }
//     _request.fields.addAll(body);
//     Http.Response _response = await Http.Response.fromStream(await _request.send());
//     return handleResponse(_response, uri);
//   } catch (e) {
//     return Response(statusCode: 1, statusText: noInternetMessage);
//   }
// }

// Future<Response> deleteData(String uri, {Map<String, String> headers}) async {
//   try {
//     if(Foundation.kDebugMode) {
//       print('====> API Call: $uri\nHeader: $_mainHeaders');
//     }
//     Http.Response _response = await Http.delete(
//       Uri.parse(appBaseUrl+uri),
//       headers: headers ?? _mainHeaders,
//     ).timeout(Duration(seconds: timeoutInSeconds));
//     return handleResponse(_response, uri);
//   } catch (e) {
//     return Response(statusCode: 1, statusText: noInternetMessage);
//   }
// }

// class MultipartBody {
//   String key;
//   XFile file;
//
//   MultipartBody(this.key, this.file);
// }
