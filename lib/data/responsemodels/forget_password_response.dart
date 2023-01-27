class ForgetPasswordResponse {
  Error? error;
  bool? succeeded;

  ForgetPasswordResponse({this.error, this.succeeded});

  ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'] != null ? Error.fromJson(json['error']) : null;
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (error != null) {
      data['error'] = error!.toJson();
    }
    data['succeeded'] = succeeded;
    return data;
  }
}

class Error {
  String? title;
  Errors? errors;

  Error({this.title, this.errors});

  Error.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    return data;
  }
}

class Errors {
  List<String>? email;

  Errors({this.email});

  Errors.fromJson(Map<String, dynamic> json) {
    email = json['Email'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['Email'] = email;
    return data;
  }
}