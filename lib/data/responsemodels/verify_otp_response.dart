class VerifyOtpResponse {
  Jwt? jwt;
  String? refreshToken;

  VerifyOtpResponse({this.jwt, this.refreshToken});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
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