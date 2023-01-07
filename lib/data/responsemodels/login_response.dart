class LoginResponse {
  Data? data;
  Error? error;
  bool? succeeded;

  LoginResponse({this.data, this.error, this.succeeded});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}