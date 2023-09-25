class TicketResponse {
  List<Data>? data;
  bool? succeeded;

  TicketResponse({this.data, this.succeeded});

  TicketResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    succeeded = json['succeeded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['succeeded'] = this.succeeded;
    return data;
  }
}

class Data {
  String? ticketNumber;
  String? transactionDatetime;
  String? orderId;
  String? sourceCompanyCode;
  Null? destinationCompanyCode;
  String? sourceStopId;
  String? sourceStopName;
  String? destinationStopId;
  String? destinationStopName;
  Null? sourceStopNameGujarati;
  Null? destinationStopNameGujarati;
  String? qrCodeString;
  String? routeCode;
  String? issuedOn;
  String? expiresOn;
  int? tripFare;
  int? totalTickets;
  bool? isInterChange;
  Null? viaRouteNumber;
  Null? interChangeStation;
  bool? isExpired;
  Null? agency;
  Null? type;
  int? userId;
  String? ticketType;
  String? passName;

  Data(
      {this.ticketNumber,
      this.transactionDatetime,
      this.orderId,
      this.sourceCompanyCode,
      this.destinationCompanyCode,
      this.sourceStopId,
      this.sourceStopName,
      this.destinationStopId,
      this.destinationStopName,
      this.sourceStopNameGujarati,
      this.destinationStopNameGujarati,
      this.qrCodeString,
      this.routeCode,
      this.issuedOn,
      this.expiresOn,
      this.tripFare,
      this.totalTickets,
      this.isInterChange,
      this.viaRouteNumber,
      this.interChangeStation,
      this.isExpired,
      this.agency,
      this.type,
      this.userId,
      this.ticketType,
      this.passName});

  Data.fromJson(Map<String, dynamic> json) {
    ticketNumber = json['ticketNumber'];
    transactionDatetime = json['transactionDatetime'];
    orderId = json['orderId'];
    sourceCompanyCode = json['sourceCompanyCode'];
    destinationCompanyCode = json['destinationCompanyCode'];
    sourceStopId = json['sourceStopId'];
    sourceStopName = json['sourceStopName'];
    destinationStopId = json['destinationStopId'];
    destinationStopName = json['destinationStopName'];
    sourceStopNameGujarati = json['sourceStopNameGujarati'];
    destinationStopNameGujarati = json['destinationStopNameGujarati'];
    qrCodeString = json['qrCodeString'];
    routeCode = json['routeCode'];
    issuedOn = json['issuedOn'];
    expiresOn = json['expiresOn'];
    tripFare = json['tripFare'];
    totalTickets = json['totalTickets'];
    isInterChange = json['isInterChange'];
    viaRouteNumber = json['viaRouteNumber'];
    interChangeStation = json['interChangeStation'];
    isExpired = json['isExpired'];
    agency = json['agency'];
    type = json['type'];
    userId = json['userId'];
    ticketType = json['ticketType'];
    passName = json['passName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketNumber'] = this.ticketNumber;
    data['transactionDatetime'] = this.transactionDatetime;
    data['orderId'] = this.orderId;
    data['sourceCompanyCode'] = this.sourceCompanyCode;
    data['destinationCompanyCode'] = this.destinationCompanyCode;
    data['sourceStopId'] = this.sourceStopId;
    data['sourceStopName'] = this.sourceStopName;
    data['destinationStopId'] = this.destinationStopId;
    data['destinationStopName'] = this.destinationStopName;
    data['sourceStopNameGujarati'] = this.sourceStopNameGujarati;
    data['destinationStopNameGujarati'] = this.destinationStopNameGujarati;
    data['qrCodeString'] = this.qrCodeString;
    data['routeCode'] = this.routeCode;
    data['issuedOn'] = this.issuedOn;
    data['expiresOn'] = this.expiresOn;
    data['tripFare'] = this.tripFare;
    data['totalTickets'] = this.totalTickets;
    data['isInterChange'] = this.isInterChange;
    data['viaRouteNumber'] = this.viaRouteNumber;
    data['interChangeStation'] = this.interChangeStation;
    data['isExpired'] = this.isExpired;
    data['agency'] = this.agency;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['passName'] = this.passName;
    return data;
  }
}