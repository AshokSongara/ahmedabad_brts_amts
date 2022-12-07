import 'dart:convert';
import 'dart:math';

import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/stop_response_model.dart';
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

    try {} on Exception catch (exception) {
    } catch (error) {}
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

    try {} on Exception catch (exception) {
    } catch (error) {}
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

    try {} on Exception catch (exception) {
    } catch (error) {}
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

    try {} on Exception catch (exception) {
    } catch (error) {}
    return verifyOtpResponse;
  }

  @override
  Future<FeedbackResponseModel> feedbackSubmit(body) async{
    Map data = {
      "routeId": body.routeId,
      "waiting":body.waiting,
      "comfort":body.comfort,
      "crowding":body.crowding,
      "serviceQuality":body.serviceQuality,
      "journey":body.journey,
      "userId":body.userId
    };

    var bodyData = json.encode(data);

    Response response =
        await apiClient.postData(AppConstant.submitFeedback, bodyData);
    FeedbackResponseModel feedbackResponseModel =
    FeedbackResponseModel.fromJson(response.body);

    try {} on Exception catch (exception) {
    } catch (error) {}
    return feedbackResponseModel;
  }

  /// NOTE: FOR BRTS & AMTS
  /// For now the logic is if there is no data in local we'll call the api but going forward
  /// we need 1 flag from server in response that if the response is updated or not
  @override
  Future<BrtsStopResponseModel> getStop(body) async{
    Box brtsBox = getLocalBrtsRouteData();
    Box amtsBox = getLocalAmtsRouteData();
    Response response =
    await apiClient.getData(AppConstant.getStops+"${body.stopType}",);
    if(body.stopType==1){
      if(brtsBox.isEmpty){
        print("response.body ${response.body}");
        BrtsStopResponseModel stopResponseModel =
        BrtsStopResponseModel.fromJson(response.body);
        getLocalBrtsRouteData().put("key",stopResponseModel);
        try {} on Exception catch (exception) {
        } catch (error) {}
        return brtsBox.get("key");
      }else{
        BrtsStopResponseModel stopResponseModel =
        BrtsStopResponseModel.fromJson(response.body);
        getLocalBrtsRouteData().put("key",stopResponseModel);
        print("from Hive side");
        return amtsBox.get("key");
      }
    }else{
      if(amtsBox.isEmpty){
        print("response.body ${response.body}");
        BrtsStopResponseModel stopResponseModel =
        BrtsStopResponseModel.fromJson(response.body);
        getLocalAmtsRouteData().put("key",stopResponseModel);
        try {} on Exception catch (exception) {
        } catch (error) {}
        return brtsBox.get("key");
      }else{
        BrtsStopResponseModel stopResponseModel =
        BrtsStopResponseModel.fromJson(response.body);
        getLocalAmtsRouteData().put("key",stopResponseModel);
        print("from Hive side");
        return amtsBox.get("key");
      }
    }


  }

  @override
  Box<BrtsStopResponseModel> getLocalBrtsRouteData() {
    return Hive.box<BrtsStopResponseModel>(AppConstant.BrtsStopListBox);
  }
  @override
  Box<BrtsStopResponseModel> getLocalAmtsRouteData() {
    return Hive.box<BrtsStopResponseModel>(AppConstant.AmtsStopListBox);
  }
}
