class PaymentNewResponse {
  Data? data;
  String? message;
  bool? succeeded;

  PaymentNewResponse({this.data, this.message, this.succeeded});

  PaymentNewResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['succeeded'] = this.succeeded;
    return data;
  }
}

class Data {
  String? transactionStatus;
  String? ticketNo;
  String? transactionNo;
  String? transactiondatetime;
  String? sourceStopId;
  String? sourceStopName;
  String? destinationStopId;
  String? destinationStopName;
  String? discountAmt;
  String? fareAmt;
  String? routeCode;
  String? ticketExpiry;
  String? ticketType;
  String? passName;
  String? paymentType;
  String? qrCode;
  String? paymentMethod;
  bool? responceReceived;

  Data(
      {this.transactionStatus,
        this.ticketNo,
        this.transactionNo,
        this.transactiondatetime,
        this.sourceStopId,
        this.sourceStopName,
        this.destinationStopId,
        this.destinationStopName,
        this.discountAmt,
        this.fareAmt,
        this.routeCode,
        this.ticketExpiry,
        this.ticketType,
        this.passName,
        this.paymentType,
        this.qrCode,
        this.paymentMethod,
        this.responceReceived});

  Data.fromJson(Map<String, dynamic> json) {
    transactionStatus = json['transactionStatus'];
    ticketNo = json['ticketNo'];
    transactionNo = json['transactionNo'];
    transactiondatetime = json['transactiondatetime'];
    sourceStopId = json['sourceStopId'];
    sourceStopName = json['sourceStopName'];
    destinationStopId = json['destinationStopId'];
    destinationStopName = json['destinationStopName'];
    discountAmt = json['discountAmt'];
    fareAmt = json['fareAmt'];
    routeCode = json['routeCode'];
    ticketExpiry = json['ticketExpiry'];
    ticketType = json['ticketType'];
    passName = json['passName'];
    paymentType = json['paymentType'];
    qrCode = json['qrCode'];
    paymentMethod = json['paymentMethod'];
    responceReceived = json['responceReceived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionStatus'] = this.transactionStatus;
    data['ticketNo'] = this.ticketNo;
    data['transactionNo'] = this.transactionNo;
    data['transactiondatetime'] = this.transactiondatetime;
    data['sourceStopId'] = this.sourceStopId;
    data['sourceStopName'] = this.sourceStopName;
    data['destinationStopId'] = this.destinationStopId;
    data['destinationStopName'] = this.destinationStopName;
    data['discountAmt'] = this.discountAmt;
    data['fareAmt'] = this.fareAmt;
    data['routeCode'] = this.routeCode;
    data['ticketExpiry'] = this.ticketExpiry;
    data['ticketType'] = this.ticketType;
    data['passName'] = this.passName;
    data['paymentType'] = this.paymentType;
    data['qrCode'] = this.qrCode;
    data['paymentMethod'] = this.paymentMethod;
    data['responceReceived'] = this.responceReceived;
    return data;
  }
}
