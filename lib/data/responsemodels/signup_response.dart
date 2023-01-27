class SignUpResponse {
  int? data;
  Error? error;
  bool? succeeded;

  SignUpResponse({this.data, this.error, this.succeeded});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data;
    if (error != null) {
      data['error'] = error!.toJson();
    }
    data['succeeded'] = succeeded;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    return data;
  }
}