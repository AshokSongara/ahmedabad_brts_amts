class PaymentURLResponse {
  Data? data;
  bool? succeeded;

  PaymentURLResponse({this.data, this.succeeded});

  PaymentURLResponse.fromJson(Map<String, dynamic> json) {
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
  Null errorMessage;
  Null errorCode;
  String? paymentURL;

  Data({this.errorMessage, this.errorCode, this.paymentURL});

  Data.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    errorCode = json['errorCode'];
    paymentURL = json['paymentURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorMessage'] = this.errorMessage;
    data['errorCode'] = this.errorCode;
    data['paymentURL'] = this.paymentURL;
    return data;
  }
}