class LoginResponse {
  String? accessToken;
  int? expiry;
  String? email;
  int? statusCode;

  LoginResponse({this.accessToken, this.expiry, this.email, this.statusCode});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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