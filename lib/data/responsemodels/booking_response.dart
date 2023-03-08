class BookingListResponse {
  List<Data>? data;
  bool? succeeded;

  BookingListResponse({this.data, this.succeeded});

  BookingListResponse.fromJson(Map<String, dynamic> json) {
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
  String? ticketNo;
  int? ticketSerialNo;
  String? transactionDatetime;
  String? fareAmt;
  String? txnStatus;
  String? transactionNo;
  String? sourceStopId;
  String? sourceStopName;
  String? destinationStopId;
  String? destinationStopName;

  Data(
      {this.ticketNo,
        this.ticketSerialNo,
        this.transactionDatetime,
        this.fareAmt,
        this.txnStatus,
        this.transactionNo,
        this.sourceStopId,
        this.sourceStopName,
        this.destinationStopId,
        this.destinationStopName});

  Data.fromJson(Map<String, dynamic> json) {
    ticketNo = json['ticketNo'];
    ticketSerialNo = json['ticketSerialNo'];
    transactionDatetime = json['transactionDatetime'];
    fareAmt = json['fareAmt'];
    txnStatus = json['txnStatus'];
    transactionNo = json['transactionNo'];
    sourceStopId = json['sourceStopId'];
    sourceStopName = json['sourceStopName'];
    destinationStopId = json['destinationStopId'];
    destinationStopName = json['destinationStopName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticketNo'] = this.ticketNo;
    data['ticketSerialNo'] = this.ticketSerialNo;
    data['transactionDatetime'] = this.transactionDatetime;
    data['fareAmt'] = this.fareAmt;
    data['txnStatus'] = this.txnStatus;
    data['transactionNo'] = this.transactionNo;
    data['sourceStopId'] = this.sourceStopId;
    data['sourceStopName'] = this.sourceStopName;
    data['destinationStopId'] = this.destinationStopId;
    data['destinationStopName'] = this.destinationStopName;
    return data;
  }
}