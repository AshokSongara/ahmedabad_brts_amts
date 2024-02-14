class PhonepeRequest {
  String? startStopCode;
  String? endStopCode;
  String? discountype;
  String? routeCode;
  int? routeType;
  String? deviceOS;
  String? paymentInstrumentType;
  String? targateApp;

  PhonepeRequest(
      {this.startStopCode,
        this.endStopCode,
        this.discountype,
        this.routeCode,
        this.routeType,
        this.deviceOS,
        this.paymentInstrumentType,
        this.targateApp});

  PhonepeRequest.fromJson(Map<String, dynamic> json) {
    startStopCode = json['startStopCode'];
    endStopCode = json['endStopCode'];
    discountype = json['discountype'];
    routeCode = json['routeCode'];
    routeType = json['routeType'];
    deviceOS = json['deviceOS'];
    paymentInstrumentType = json['paymentInstrumentType'];
    targateApp = json['targateApp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startStopCode'] = this.startStopCode;
    data['endStopCode'] = this.endStopCode;
    data['discountype'] = this.discountype;
    data['routeCode'] = this.routeCode;
    data['routeType'] = this.routeType;
    data['deviceOS'] = this.deviceOS;
    data['paymentInstrumentType'] = this.paymentInstrumentType;
    data['targateApp'] = this.targateApp;
    return data;
  }
}