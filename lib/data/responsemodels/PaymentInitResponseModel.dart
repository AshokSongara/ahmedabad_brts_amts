class PaymentInitResponseModel {
  PaymentInitResponseModel({
    this.data,
    this.succeeded,});

  PaymentInitResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    succeeded = json['succeeded'];
  }
  List<Data>? data;
  bool? succeeded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['succeeded'] = succeeded;
    return map;
  }

}
class Data {
  Data({
    this.transactionStatus,
    this.ticketNo,
    this.transactionNo,
    this.transactiondatetime,
    this.sourceStopId,
    this.destinationStopId,
    this.discountAmt,
    this.fareAmt,
    this.qrCode,
    this.sourceStopName,
    this.destinationStopName,
    this.ticketType
  });

  Data.fromJson(dynamic json) {
    transactionStatus = json['transactionStatus'];
    ticketNo = json['ticketNo'];
    transactionNo = json['transactionNo'];
    transactiondatetime = json['transactiondatetime'];
    sourceStopId = json['sourceStopId'];
    destinationStopId = json['destinationStopId'];
    discountAmt = json['discountAmt'];
    fareAmt = json['fareAmt'];
    qrCode = json['qrCode'];
    sourceStopName = json['sourceStopName'];
    destinationStopName = json['destinationStopName'];
    routeCode = json['routeCode'];
    ticketType = json['ticketType'];
  }
  String? transactionStatus;
  String? ticketNo;
  String? transactionNo;
  String? transactiondatetime;
  String? sourceStopId;
  String? destinationStopId;
  String? discountAmt;
  String? fareAmt;
  String? qrCode;
  String? sourceStopName;
  String? destinationStopName;
  String? routeCode;
  String? ticketType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transactionStatus'] = transactionStatus;
    map['ticketNo'] = ticketNo;
    map['transactionNo'] = transactionNo;
    map['transactiondatetime'] = transactiondatetime;
    map['sourceStopId'] = sourceStopId;
    map['destinationStopId'] = destinationStopId;
    map['discountAmt'] = discountAmt;
    map['fareAmt'] = fareAmt;
    map['qrCode'] = qrCode;
    map['sourceStopName'] = sourceStopName;
    map['destinationStopName'] = destinationStopName;
    map['routeCode'] = routeCode;
    map['ticketType'] = ticketType;
    return map;
  }

}