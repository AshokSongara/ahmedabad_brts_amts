import 'dart:convert';
import 'dart:math';

import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_route_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/stop_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/user_profile_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/verify_otp_response.dart';
import 'package:ahmedabad_brts_amts/domain/repositories/user/user_repository.dart';
import 'package:ahmedabad_brts_amts/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  UserRepositoryImpl(
      {required this.apiClient, required this.sharedPreferences});

  @override
  Future<MobileNumberOtpResponseEntity> getOtp(
      MobileNumberOtpRequestParam body) async {
    Map data = {
      'phoneNumber': body.phoneNumber ?? "",
    };

    var bodyData = json.encode(data);

    Response response = await apiClient.postData(AppConstant.userOtp, bodyData);

    MobileNumberOtpResponseEntity mobileNumberOtpResponseEntity =
        MobileNumberOtpResponseEntity.fromJson(response.body);

    return mobileNumberOtpResponseEntity;
  }

  @override
  Future<SignUpResponse> signupUser(body) async {
    Map data = {
      'firstName': body.name ?? "",
      'lastName': body.lastname ?? "",
      'email': body.email ?? "",
      'password': body.password ?? "",
      'phoneNumber': body.phoneNumber ?? ""
    };

    var bodyData = json.encode(data);

    Response response =
        await apiClient.postData(AppConstant.registerInterface, bodyData);
    SignUpResponse signUpResponse = SignUpResponse.fromJson(response.body);

    return signUpResponse;
  }

  @override
  Future<LoginResponse> loginUser(body) async {
    Map data = {
      'email': body.email ?? "",
      'password': body.password ?? "",
    };

    var bodyData = json.encode(data);

    Response response =
        await apiClient.postData(AppConstant.loginInterface, bodyData);
    LoginResponse loginResponse = LoginResponse.fromJson(response.body);

    apiClient.updateHeader(loginResponse.data?.accessToken ?? "");

    return loginResponse;
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(OtpRequest body) async {
    Map data = {
      'phoneNumber': body.phoneNumber ?? "",
      'otp': body.otp ?? "",
    };

    var bodyData = json.encode(data);

    Response response =
        await apiClient.postData(AppConstant.verifyOtp, bodyData);
    VerifyOtpResponse verifyOtpResponse =
        VerifyOtpResponse.fromJson(response.body);

    return verifyOtpResponse;
  }

  @override
  Future<FeedbackResponseModel> feedbackSubmit(body) async {
    Map data = {
      "routeId": body.routeId,
      "waiting": body.waiting,
      "comfort": body.comfort,
      "crowding": body.crowding,
      "serviceQuality": body.serviceQuality,
      "journey": body.journey,
    };

    var bodyData = json.encode(data);

    Response response = await apiClient.postDataWithHeader(
        AppConstant.submitFeedback, bodyData);
    FeedbackResponseModel feedbackResponseModel =
        FeedbackResponseModel.fromJson(response.body);

    return feedbackResponseModel;
  }

  /// NOTE: FOR BRTS & AMTS
  /// For now the logic is if there is no data in local we'll call the api but going forward
  /// we need 1 flag from server in response that if the response is updated or not
  @override
  Future<BrtsStopResponseModel> getStop(body) async {
    Box brtsBox = getLocalBrtsStopData();
    BrtsStopResponseModel brtsData = brtsBox.get("key");
    Box amtsBox = getLocalAmtsStopData();
    BrtsStopResponseModel amtsData = amtsBox.get("key");
    Response response = await apiClient.getData(
      AppConstant.getStops + "${body.stopType}",
    );
    if (body.stopType == 1) {
      if (brtsData.data==null || brtsData.data!.isEmpty) {
        print("response.body ${response.body}");
        BrtsStopResponseModel stopResponseModel =
            BrtsStopResponseModel.fromJson(response.body);
        getLocalBrtsStopData().put("key", stopResponseModel);

        return brtsBox.get("key");
      } else {
        // BrtsStopResponseModel stopResponseModel =
        //     BrtsStopResponseModel.fromJson(response.body);
        // getLocalBrtsStopData().put("key", stopResponseModel);
        // print("from Hive side");
        return brtsBox.get("key");
      }
    } else {
      if (amtsData.data==null || amtsData.data!.isEmpty) {
        print("response.body ${response.body}");
        BrtsStopResponseModel stopResponseModel =
            BrtsStopResponseModel.fromJson(response.body);
        getLocalAmtsStopData().put("key", stopResponseModel);

        return amtsBox.get("key");
      } else {
        // BrtsStopResponseModel stopResponseModel =
        //     BrtsStopResponseModel.fromJson(response.body);
        // getLocalAmtsStopData().put("key", stopResponseModel);
        // print("from Hive side");
        return amtsBox.get("key");
      }
    }
  }

  @override
  Future<BrtsRoutesResponseModel> getRoutes(body) async {
    Box brtsBox = getLocalBrtsRoutesData();
    BrtsRoutesResponseModel brtsData = brtsBox.get("key");
    Box amtsBox = getLocalAmtsRoutesData();
    BrtsRoutesResponseModel amtsData = brtsBox.get("key");

    Response response = await apiClient.getData(
      AppConstant.getRoutes + "${body.stopType}",
    );
    if (body.stopType == 1) {
      if  (brtsData.data==null || brtsData.data!.isEmpty) {
        print("getRoutes response.body ${response.body}");
        BrtsRoutesResponseModel stopResponseModel =
            BrtsRoutesResponseModel.fromJson(response.body);
        getLocalBrtsRoutesData().put("key", stopResponseModel);

        return brtsBox.get("key");
      } else {
        // BrtsRoutesResponseModel stopResponseModel =
        //     BrtsRoutesResponseModel.fromJson(response.body);
        // getLocalBrtsRoutesData().put("key", stopResponseModel);
        print("getRoutes from Hive side");
        return brtsBox.get("key");
      }
    } else {
      if(amtsData.data==null || amtsData.data!.isEmpty){
        print("getRoutes response.body ${response.body}");
        BrtsRoutesResponseModel stopResponseModel =
            BrtsRoutesResponseModel.fromJson(response.body);
        getLocalAmtsRoutesData().put("key", stopResponseModel);

        return amtsBox.get("key");
      } else {
        // BrtsRoutesResponseModel stopResponseModel =
        //     BrtsRoutesResponseModel.fromJson(response.body);
        // getLocalAmtsRoutesData().put("key", stopResponseModel);
        print("from Hive side");
        return amtsBox.get("key");
      }
    }
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
  Box<BrtsStopResponseModel> getLocalBrtsStopData() {
    return Hive.box<BrtsStopResponseModel>(AppConstant.BrtsStopListBox);
  }

  @override
  Box<BrtsStopResponseModel> getLocalAmtsStopData() {
    return Hive.box<BrtsStopResponseModel>(AppConstant.AmtsStopListBox);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(body) async {
    Map data = {
      'email': body.email ?? "",
    };

    var bodyData = json.encode(data);

    Response response =
        await apiClient.postData(AppConstant.forgetPassword, bodyData);
    ForgetPasswordResponse forgetPasswordResponse =
        ForgetPasswordResponse.fromJson(response.body);
    return forgetPasswordResponse;
  }

  @override
  Future<UserProfileResponse> getProfileData() async {
    Response response =
        await apiClient.getDataWihHeader(AppConstant.userProfile);
    UserProfileResponse userProfileResponse =
        UserProfileResponse.fromJson(response.body);
    return userProfileResponse;
  }

  @override
  Future<UserProfileResponse> updateProfile(body) async {
    Map data = {
      'firstName': body.firstName ?? "",
      'lastName': body.lastName ?? "",
    };
    var bodyData = json.encode(data);

    Response response =
    await apiClient.postDataWithHeader(AppConstant.updateProfile,bodyData);
    UserProfileResponse userProfileResponse =
    UserProfileResponse.fromJson(response.body);
    return userProfileResponse;
  }

  @override
  Future<NotificationResponse> getNotificationsData() async {
    Response response = await apiClient.getData(AppConstant.notifications);
    NotificationResponse notificationResponse =
        NotificationResponse.fromJson(response.body);
    return notificationResponse;
  }

  @override
  Future<FavouriteRouteResponse> getFavouriteRouteListData() async {
    Response response = await apiClient.getDataWihHeader(AppConstant.favouriteRouteList);
    FavouriteRouteResponse favouriteRouteResponse =
        FavouriteRouteResponse.fromJson(response.body);

    return favouriteRouteResponse;
  }
}
