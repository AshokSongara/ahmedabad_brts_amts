class UserProfileResponse {
  Data? data;
  bool? succeeded;

  UserProfileResponse({this.data, this.succeeded});

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['succeeded'] = this.succeeded;
    return data;
  }
}

class Data {
  String? firstName;
  String? lastName;
  String? email;

  Data({this.firstName, this.lastName, this.email});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    return data;
  }
}