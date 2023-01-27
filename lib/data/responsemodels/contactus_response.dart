class ContactUsResponse {
  Data? data;
  bool? succeeded;

  ContactUsResponse({this.data, this.succeeded});

  ContactUsResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['succeeded'] = succeeded;
    return data;
  }
}

class Data {
  String? email;
  String? mobile;

  Data({this.email, this.mobile});

  Data.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}