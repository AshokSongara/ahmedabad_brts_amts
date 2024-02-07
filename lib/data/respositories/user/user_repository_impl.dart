import 'dart:convert';

import 'package:ahmedabad_brts_amts/api/api_client.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/mobile_number_otp_request_param.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/otp_request.dart';
import 'package:ahmedabad_brts_amts/data/requestmodels/payment_request.dart';
import 'package:ahmedabad_brts_amts/data/responseModels/signup_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/PaymentInitResponseModel.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/booking_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_routes_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/brts_stop_respons_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/complaint_history_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/complaint_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/contactus_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_route_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/favourite_routes_response_list.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/feedback_response_model.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/forget_password_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/login_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/mobile_number_otp_response_entity.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/notification_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/payment_URL_Response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/qr_code_response.dart';
import 'package:ahmedabad_brts_amts/data/responsemodels/ticket_response.dart';
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

    apiClient.updateHeader(verifyOtpResponse.data?.jwt?.accessToken ?? "");

    return verifyOtpResponse;
  }

  @override
  Future<FeedbackResponseModel> feedbackSubmit(body) async {
    Map data = {
      "routeNumber": body.routeId,
      "waiting": body.waiting,
      "comfort": body.comfort,
      "crowding": body.crowding,
      "serviceQuality": body.serviceQuality,
      "journey": body.journey,
      "assistance": body.journey,
      "paymentMode": body.journey,
      "suggestion": body.journey,
    };

    var bodyData = json.encode(data);

    Response response = await apiClient.postDataWithHeader(
        AppConstant.submitFeedback, bodyData);
    FeedbackResponseModel feedbackResponseModel =
        FeedbackResponseModel.fromJson(response.body);

    return feedbackResponseModel;
  }

  @override
  Future<ComplaintResponseModel> complaintUser(body) async {
    Map data = {
      "title": body.title,
      "date": body.date,
      "time": body.time,
      "category": body.category,
      "subCategory": body.subCategory,
      "busNo": body.busNo,
      "stationId": body.stationId,
      "route": body.route,
      "landmark": body.landmark,
      "description": body.description,
      "mobile": body.mobile,
    };

    var bodyData = json.encode(data);

    Response response = await apiClient.postDataWithHeader(
        AppConstant.complaint, bodyData);
    ComplaintResponseModel complaintResponseModel =
    ComplaintResponseModel.fromJson(response.body);

    return complaintResponseModel;
  }

  /// NOTE: FOR BRTS & AMTS
  /// For now the logic is if there is no data in local we'll call the api but going forward
  /// we need 1 flag from server in response that if the response is updated or not
  @override
  Future<BrtsStopResponseModel> getStop(body) async {
    Box brtsBox = getLocalBrtsStopData();
    BrtsStopResponseModel? brtsData = brtsBox.get("key");
    Box amtsBox = getLocalAmtsStopData();
    BrtsStopResponseModel? amtsData = amtsBox.get("key");
    Response response = await apiClient.getData(
      AppConstant.getStops + "${body.stopType}",
    );
    if (body.stopType == 1) {
      if (brtsData == null || brtsData.data == null || brtsData.data!.isEmpty) {
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
      if (amtsData == null || amtsData.data == null || amtsData.data!.isEmpty) {
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
    BrtsRoutesResponseModel? brtsData = brtsBox.get("key");
    Box amtsBox = getLocalAmtsRoutesData();
    BrtsRoutesResponseModel? amtsData = amtsBox.get("key");

    Response response = await apiClient.getData(
      AppConstant.getRoutes + "${body.stopType}",
    );
    if (body.stopType == 1) {
      if (brtsData == null || brtsData.data == null || brtsData.data!.isEmpty) {
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
      if (amtsData == null || amtsData.data == null || amtsData.data!.isEmpty) {
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
      'phoneNumber': body.email ?? "",
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
        await apiClient.postDataWithHeader(AppConstant.updateProfile, bodyData);
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
  Future<FavouriteRouteResponse> getFavouriteRouteListData(String serviceType) async {
    Response response =
        await apiClient.getDataWihHeader(AppConstant.favouriteRouteList+serviceType);
    FavouriteRouteResponse favouriteRouteResponse =
        FavouriteRouteResponse.fromJson(response.body);

    return favouriteRouteResponse;
  }

  @override
  Future<ContactUsResponse> getContactDetails() async {
    Response response = await apiClient.getData(AppConstant.contactUs);
    ContactUsResponse contactUsResponse =
        ContactUsResponse.fromJson(response.body);

    return contactUsResponse;
  }

  @override
  Future<QRCodeResponse> getQRCodeData() async {
    Response response =
        await apiClient.getDataWihHeader(AppConstant.qrCodeData);
    QRCodeResponse qrCodeResponse = QRCodeResponse.fromJson(response.body);

    return qrCodeResponse;
  }

  @override
  Future<PaymentInitResponseModel> addTransaction(PaymentRequest2 body) async {
    Map data = {
      "sourceStopId": body.sourceStopId,
      "destinationStopId": body.destinationStopId,
      "discountype": body.discountype,
      "txnStatus": body.txnStatus,
      "merchantId": body.merchantId,
      "sourcecompanycode": body.serviceType == "BRTS" ? "0102" : "0103",
      //"destinationcompanycode": body.serviceType == "BRTS" ? "0102" : "0103",
      "fpTransactionId": body.fpTransactionId,
      "merchantTxnId": body.merchantTxnId,
      "externalTxnId": body.externalTxnId,
      "transactionDateTime": body.transactionDateTime,
      "routeCode": body.routeCode!.isEmpty ? "NA" : body.routeCode,
      "paymentType": body.paymentType,
      "paymentState": body.paymentState,
      "pgServiceTransactionId": body.pgServiceTransactionId,
      "pgTransactionId": body.pgTransactionId,
      "paymentMethod": body.paymentMethod ?? "",

    };

    Map data2 = {
      "sourceStopId": body.sourceStopId,
      "destinationStopId": body.destinationStopId,
      "discountype": body.discountype,
      "txnStatus": body.txnStatus,
      "sourcecompanycode": body.serviceType == "BRTS" ? "0102" : "0103",
      "merchantTxnId": body.merchantTxnId,
    };

    var bodyData = json.encode(body.fpTransactionId == "" ? data2 : data);

    Response response = await apiClient.postDataWithHeader(
        body.fpTransactionId == "" ? "PhonepePG/AddTransaction":AppConstant.addTransaction, bodyData);
    PaymentInitResponseModel loginResponse =
        PaymentInitResponseModel.fromJson(response.body);
    return loginResponse;
  }

  @override
  Future<BookingListResponse> getBookingListData(String data) async {
    Response response = await apiClient.getDataWihHeader(data == "home"
        ? AppConstant.transactionList
        : AppConstant.transactionBookingList);
    BookingListResponse bookingListResponse =
        BookingListResponse.fromJson(response.body);

    return bookingListResponse;
  }

  @override
  Future<ComplaintHistoryResponse> getComplaintHistoryData(String data) async {
    Response response = await apiClient.getDataWihHeader("${AppConstant.complaint}/list");
    ComplaintHistoryResponse complaintHistoryResponse =
    ComplaintHistoryResponse.fromJson(response.body);

    return complaintHistoryResponse;
  }

  @override
  Future<ForgetPasswordResponse> changePassword(body) async {
    Map data = {
      'otp': body.otp ?? "",
      'phoneNumber': body.number ?? "",
      'password': body.password ?? "",
    };

    var bodyData = json.encode(data);

    Response response =
        await apiClient.postData(AppConstant.changePassword, bodyData);
    ForgetPasswordResponse forgetPasswordResponse =
        ForgetPasswordResponse.fromJson(response.body);
    return forgetPasswordResponse;
  }

  @override
  Future<PaymentURLResponse> getPaymentUrl(PaymentRequest2 body) async {
    Map payload = {
      "startStopCode": body.sourceStopId,
      "endStopCode": body.destinationStopId,
      "discountype": body.discountype,
      "routeType": body.serviceType == "BRTS" ? 1 : 2,
      "routeCode": body.routeCode,
    };

    var bodyData = json.encode(payload);

    Response response =
        await apiClient.postDataWithHeader(AppConstant.fiservPG, bodyData);
    PaymentURLResponse paymentURLResponse =
        PaymentURLResponse.fromJson(response.body);
    return paymentURLResponse;
  }

  @override
  Future<TicketResponse> ticketData(String data) async {
    Map payload = {"ticketNumber": data};

    var bodyData = json.encode(payload);

    Response response = await apiClient.postDataWithHeader(
        AppConstant.transactionTicket, bodyData);
    TicketResponse loginResponse = TicketResponse.fromJson(response.body);
    return loginResponse;
  }

  @override
  Future<FavouriteRoutesResponseList> getFavouriteRouteData(String serviceType) async {
    Response response =
    await apiClient.getDataWihHeader(AppConstant.favouriteRouteListData+serviceType);
    FavouriteRoutesResponseList favouriteRouteResponse =
    FavouriteRoutesResponseList.fromJson(response.body);

    return favouriteRouteResponse;
  }
}
