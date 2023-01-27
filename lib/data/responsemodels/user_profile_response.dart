class UserProfileResponse {
  Data? data;
  bool? succeeded;

  UserProfileResponse({this.data, this.succeeded});

  UserProfileResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['succeeded'] = succeeded;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    return data;
  }
}