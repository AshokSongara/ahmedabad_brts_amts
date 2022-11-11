import 'dart:convert';
import 'dart:io';

import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/models/login_response.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/repositories/customer/customer_repository.dart';

enum AuthEnum { gmail, facebook, normal }

class CustomerRepositoryImpl implements CustomerRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  CustomerRepositoryImpl(
      {required this.apiClient, required this.sharedPreferences});


  @override
  Future<LoginResponse> loginUser(Map<String, String> body) async {
    Response response =
        await apiClient.postData(AppConstant.loginInterface, body);
    LoginResponse loginResponse = LoginResponse.fromJson(response.body);

    try {
      String? _deviceToken = await FirebaseMessaging.instance.getToken();
      var map = new Map<String, String>();
      map['tarakKey'] = AppConstant.tarakKey;
      map['id'] = loginResponse.data![0].id ?? "";
      map['memberfirebaseid'] = _deviceToken ?? "";
      Response response =
          await apiClient.postData(AppConstant.updateFirebaseInterface, map);
      print("###Firebase Response$_deviceToken");
      print("###Firebase Response$response");
      // sharedPreferences.setString(
      //     AppConstant.keyMemberID, loginResponse.data![0].id ?? "");
    } on Exception catch (exception) {
    } catch (error) {}
    return loginResponse;
  }
}
