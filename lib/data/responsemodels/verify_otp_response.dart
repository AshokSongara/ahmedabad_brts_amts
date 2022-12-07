class VerifyOtpResponse {
  Data? data;
  Error? error;
  bool? succeeded;

  VerifyOtpResponse({this.data, this.error, this.succeeded});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['succeeded'] = this.succeeded;
    return data;
  }
}

class Data {
  Jwt? jwt;
  String? refreshToken;

  Data({this.jwt, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'] != null ? new Jwt.fromJson(json['jwt']) : null;
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jwt != null) {
      data['jwt'] = this.jwt!.toJson();
    }
    data['refreshToken'] = this.refreshToken;
    return data;
  }
}

class Jwt {
  String? accessToken;
  int? expiry;
  String? email;
  int? statusCode;

  Jwt({this.accessToken, this.expiry, this.email, this.statusCode});

  Jwt.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    expiry = json['expiry'];
    email = json['email'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['expiry'] = this.expiry;
    data['email'] = this.email;
    data['statusCode'] = this.statusCode;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}