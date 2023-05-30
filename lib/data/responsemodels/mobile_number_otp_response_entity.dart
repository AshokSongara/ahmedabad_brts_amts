// class MobileNumberOtpResponseEntity {
//   MobileNumberOtpResponseEntity({bool? statusCode}) {
//     _statusCode = statusCode;
//   }
//
//   MobileNumberOtpResponseEntity.fromJson(dynamic json) {
//     _statusCode = json['succeeded'];
//   }
//
//   bool? _statusCode;
//
//   MobileNumberOtpResponseEntity copyWith({
//     bool? statusCode,
//   }) =>
//       MobileNumberOtpResponseEntity(
//         statusCode: statusCode ?? _statusCode,
//       );
//
//   bool? get statusCode => _statusCode;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['succeeded'] = _statusCode;
//     return map;
//   }
// }

class MobileNumberOtpResponseEntity {
  Data? data;
  Error? error;
  bool? succeeded;

  MobileNumberOtpResponseEntity({this.data, this.error, this.succeeded});

  MobileNumberOtpResponseEntity.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (error != null) {
      data['error'] = error!.toJson();
    }
    data['succeeded'] = succeeded;
    return data;
  }
}

class Data {
  String? accessToken;
  int? expiry;
  String? email;
  int? statusCode;

  Data({this.accessToken, this.expiry, this.email, this.statusCode});

  Data.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiry = json['expiry'];
    email = json['email'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['accessToken'] = accessToken;
    data['expiry'] = expiry;
    data['email'] = email;
    data['statusCode'] = statusCode;
    return data;
  }
}

class Error {
  String? title;

  Error({this.title});

  Error.fromJson(Map<String, dynamic> json) {
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    return data;
  }
}
