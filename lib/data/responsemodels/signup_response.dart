class SignUpResponse {
  int? statusCode;
  int? id;

  SignUpResponse({this.statusCode, this.id});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['id'] = this.id;
    return data;
  }
}