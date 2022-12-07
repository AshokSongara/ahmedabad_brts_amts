class SignUpResponse {
  int? data;
  Error? error;
  bool? succeeded;

  SignUpResponse({this.data, this.error, this.succeeded});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    if (this.error != null) {
      data['error'] = this.error!.toJson();
    }
    data['succeeded'] = this.succeeded;
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