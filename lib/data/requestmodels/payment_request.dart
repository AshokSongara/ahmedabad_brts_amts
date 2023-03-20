class PaymentRequest {
  String? sourceStopId;
  String? destinationStopId;
  String? discountype;
  String? txnStatus;
  String? merchantId;
  String? sourcecompanycode;
  String? destinationcompanycode;
  String? routeCode;

  PaymentRequest(
      {this.sourceStopId,
      this.destinationStopId,
      this.discountype,
      this.txnStatus,
      this.merchantId,
      this.sourcecompanycode,
      this.destinationcompanycode,
      this.routeCode});

  PaymentRequest.fromJson(Map<String, dynamic> json) {
    sourceStopId = json['sourceStopId'];
    destinationStopId = json['destinationStopId'];
    discountype = json['discountype'];
    txnStatus = json['txnStatus'];
    merchantId = json['merchantId'];
    sourcecompanycode = json['sourcecompanycode'];
    destinationcompanycode = json['destinationcompanycode'];
    routeCode = json['routeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sourceStopId'] = this.sourceStopId;
    data['destinationStopId'] = this.destinationStopId;
    data['discountype'] = this.discountype;
    data['txnStatus'] = this.txnStatus;
    data['merchantId'] = this.merchantId;
    data['sourcecompanycode'] = this.sourcecompanycode;
    data['destinationcompanycode'] = this.destinationcompanycode;
    data['routeCode'] = this.routeCode;
    return data;
  }
}
