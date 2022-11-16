import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/models/login_response.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
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
  Future<LoginResponse> registerUser(body) async {
      Response response =
          await apiClient.postData(AppConstant.registerInterface, body);
      LoginResponse loginResponse = LoginResponse.fromJson(response.body);

      try {
      } on Exception catch (exception) {
      } catch (error) {}
      return loginResponse;
  }

}
