class VerifyOtpResponse {
  Data? data;
  Error? error;
  bool? succeeded;

  VerifyOtpResponse({this.data, this.error, this.succeeded});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
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
  Jwt? jwt;
  String? refreshToken;

  Data({this.jwt, this.refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'] != null ? Jwt.fromJson(json['jwt']) : null;
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (jwt != null) {
      data['jwt'] = jwt!.toJson();
    }
    data['refreshToken'] = refreshToken;
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